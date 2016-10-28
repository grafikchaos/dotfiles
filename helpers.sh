#!/usr/bin/env bash

#
# Useful bash helpers for the installation process
#

# colors
ENV_ESC="\033"
ENV_RESET="${ENV_ESC}[0m"
ENV_RED="${ENV_ESC}[0;31m"
ENV_GREEN="${ENV_ESC}[00;32m"
ENV_YELLOW="${ENV_ESC}[0;33m"
ENV_BLUE="${ENV_ESC}[00;34m"
ENV_MAGENTA="${ENV_ESC}[0;35m"
ENV_CYAN="${ENV_ESC}[0;36m"
ENV_WHITE="${ENV_ESC}[0;37m"

# user feedback
tell() {
    printf "\n\r${ENV_ESC}[2K  [${ENV_CYAN} ^_^${ENV_RESET}] $1\n\n"
}

info() {
    printf "\r${ENV_ESC}[2K  [${ENV_BLUE} .. ${ENV_RESET}] $1\n"
}

ask() {
    printf "\r${ENV_ESC}[2K  [${ENV_YELLOW} ?? ${ENV_RESET}] $1 "
}

success() {
    printf "\r${ENV_ESC}[2K  [${ENV_GREEN} OK ${ENV_RESET}] $1\n"
}

warn() {
    printf "\r${ENV_ESC}[2K  [${ENV_MAGENTA}WARN${ENV_RESET}] $1\n"
}

fail() {
    printf "\r${ENV_ESC}[2K  [${ENV_RED}FAIL${ENV_RESET}] $1\n"
    echo ""
    exit 1
}

# operations
check_tools() {
    REQUIRED_TOOLS=${REQUIRED_TOOLS:-""}
    MISSING_TOOLS=`_check_installed $REQUIRED_TOOLS`
    if (( `echo $MISSING_TOOLS | wc -w` > 0 ));
    then
        fail "missing required tools: ${MISSING_TOOLS}"
    fi
    success "all required tools are installed"
}

_check_installed() {
    local MISSED=""

    until [ -z "$1" ]; do
        type -t $1 >/dev/null 2>/dev/null
        if (( $? != 0 ));
        then
            MISSED="${MISSED} $1"
        fi
        shift
    done

    echo $MISSED
}

create_link() {
    ln -s $1 $2
    success "linked ${1} to ${2}"
}

clone_repo() {
    if ! [ -d $DOTFILES_ROOT ];
    then
        info "cloning dotfiles repository into ${DOTFILES_ROOT}"
        # git clone --recursive -b $DOTFILES_BRANCH $DOTFILES_REPOT "{$DOTFILES_ROOT}"
        success "dotfiles are cloned"
    else
        info "updating dotfiles repository at ${DOTFILES_ROOT}"
        # git submodule update --init --recursive "${DOTFILES_ROOT}"
        success "dotfiles are updated"
    fi
}

configure_git() {
    if ! [ -f $DOTFILES_ROOT/git/gitconfig.symlink ];
    then
        info "collecting user information"

        # Ask the user for info needed to complete the install
        ask "What is your first name?"
        read -e FIRST_NAME
        ask "What is your last name?"
        read -e LAST_NAME
        ask "What is your author email?"
        read -e GIT_AUTHOREMAIL
        ask "What is your Github username?"
        read -e GITHUB_USERNAME
        ask "What is your Github token?"
        read -e GITHUB_TOKEN

        tell "Thanks, setting up Git"

        FULL_NAME="${FIRST_NAME} ${LAST_NAME}"
        GIT_AUTHORNAME=$FULL_NAME
        GIT_CREDENTIALS="cache"
        if [ "$(uname -s)" == "Darwin" ];
        then
            GIT_CREDENTIALS="osxkeychain"
        fi

        # replace tokens for user input
        sed -e "s/AUTHOR_NAME/${GIT_AUTHORNAME}/g" -e "s/AUTHOR_EMAIL/${GIT_AUTHOREMAIL}/g" \
            -e "s/GITHUB_USERNAME/${GITHUB_USERNAME}/g" -e "s/CREDENTIAL_HELPER/${GIT_CREDENTIALS}/g" \
            -e "s/GITHUB_TOKEN/${GITHUB_TOKEN}/g" \
            ${DOTFILES_ROOT}/git/gitconfig.symlink.example > ${DOTFILES_ROOT}/git/gitconfig.symlink 2>&1

        success "created configuration file"
    else
        warn "configuration file already exists"
    fi
}

enable_zsh() {
    info "checking login shells"

    local SHELL=`which zsh`
    if ! grep -Fq "${SHELL}" /etc/shells;
    then
        echo "${SHELL}" | sudo tee -a /etc/shells > /dev/null 2>&1
        warn "added ${SHELL} as a valid login shell"
    fi

    sudo chsh -s $SHELL $(whoami)
    success "set the default login shell to zsh"
}

install_dotfiles() {
    info "linking dotfiles into ${DOTFILES_ROOT}"

    BACKUP_ALL=false
    OVERWRITE_ALL=false
    SKIP_ALL=false

    # look for all files/directories ending in ".symlink"
    for SOURCE in `find ${DOTFILES_ROOT} -maxdepth 2 -name \*.symlink`
    do
        ITEM=".`basename \"${SOURCE%.*}\"`"
        DEST="${HOME}/${ITEM}"

        if [ -f $DEST ] || [ -d $DEST ];
        then
            BACKUP=false
            OVERWRITE=false
            SKIP=false

            if [ "${BACKUP_ALL}" == "false" ] && [ "${OVERWRITE_ALL}" == "false" ] && [ "${SKIP_ALL}" == "false" ];
            then
                # file/directory exists, ask what to do
                local CURRENT="$(readlink $DEST)"
                if [ "${CURRENT}" == "$SOURCE" ];
                then
                    SKIP=true
                else
                    while true
                    do
                        ask "Item already exists: ${ITEM}, what should I do? [b]ackup, [B]ackup all, [o]verwrite, [O]verwrite all, [s]kip, [S]kip all"
                        read -n 1 -r ACTION
                        case "${ACTION}" in
                            b )
                                BACKUP=true
                                break;;
                            B )
                                BACKUP_ALL=true
                                break;;
                            o )
                                OVERWRITE=true
                                break;;
                            O )
                                OVERWRITE_ALL=true
                                break;;
                            s )
                                SKIP=true
                                break;;
                            S )
                                SKIP_ALL=true
                                break;;
                            * )
                                ;;
                        esac
                    done
                fi
            fi

            if [ "${OVERWRITE}" == "true" ] || [ "${OVERWRITE_ALL}" == "true" ];
            then
                rm -rf $DEST
                warn "removed ${ITEM}"
            fi

            if [ "${BACKUP}" == "true" ] || [ "${BACKUP_ALL}" == "true" ];
            then
                mkdir -p $DOTFILES_BAK
                mv $DEST $DOTFILES_BAK/$ITEM
                warn "backed up ${ITEM} to ${DOTFILES_BAK}/${ITEM}"
            fi

            if [ "${SKIP}" == "false" ] && [ "${SKIP_ALL}" == "false" ];
            then
                create_link $SOURCE $DEST
            else
                warn "skipped ${ITEM}"
            fi
        else
            create_link $SOURCE $DEST
        fi
    done
}

setup_osx() {
    if ! [ -f $DOTFILES_ROOT/osx/defaults.sh ];
    then
        info "setting os x defaults"

        # Ask the user for info needed to complete the install
        ask "What is your computer name?"
        read -e COMPUTER_NAME

        # replace tokens for user input
        sed -e "s/COMPUTER_NAME/${COMPUTER_NAME}/g" \
            ${DOTFILES_ROOT}/osx/defaults.sh.example > ${DOTFILES_ROOT}/osx/defaults.sh
        chmod +x ${DOTFILES_ROOT}/osx/defaults.sh
        ${DOTFILES_ROOT}/osx/defaults.sh > /tmp/dotfiles-osx 2>&1

        success "created os x defaults"
    else
        warn "os x defaults already exist"
    fi

    # make sure xcode is good
    if type xcode-select >&- && xpath=$(xcode-select --print-path) && test -d "${xpath}" && test -x "${xpath}";
    then
        success "xcode command-line tools are installed"
    else
        info "you need Xcode's command-line tools"
        xcode-select --install
    fi
}

homebrew() {
    if test ! $(which brew);
    then
        info "installing Homebrew for you"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null > /tmp/dotfiles-brew 2>&1
    fi

    # install default brew packages
    info "installing default packages, it might take a while"
    ${DOTFILES_ROOT}/osx/homebrew.sh > /tmp/dotfiles-brews 2>&1
    success "Homebrew is all set"

    # Ask to install development brews
    while true
    do
        ask "Would you like to run development installer? [y]es [n]o"
        read -n 1 -r ACTION1
        case "${ACTION1}" in
            y )
                DEV=true
                break;;
            n )
                DEV=false
                break;;
            * )
                ;;
        esac
    done

    if [ "${DEV}" == "true" ];
    then
        ${DOTFILES_ROOT}/osx/homebrew-dev.sh > /tmp/dotfiles-dev 2>&1
        success "installed development brews"
    fi

    # Ask to install native apps
    while true
    do
        ask "\nWould you like to run native app installer? [y]es [n]o"
        read -n 1 -r ACTION2
        case "${ACTION2}" in
            y )
                NATIVE=true
                break;;
            n )
                NATIVE=false
                break;;
            * )
                ;;
        esac
    done

    if [ "${NATIVE}" == "true" ];
    then
        ${DOTFILES_ROOT}/osx/homebrew-cask.sh > /tmp/dotfiles-cask 2>&1
        success "installed native app brews"
    fi
}

