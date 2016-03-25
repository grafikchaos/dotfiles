#!/usr/bin/env bash
set -e

#
# This script installs all the things needed for a kick ass home directory
#
################################################################################
#
#                  888          888     .d888 d8b 888
#                  888          888    d88P"  Y8P 888
#                  888          888    888        888
#              .d88888  .d88b.  888888 888888 888 888  .d88b.  .d8888b
#             d88" 888 d88""88b 888    888    888 888 d8P  Y8b 88K
#             888  888 888  888 888    888    888 888 88888888 "Y8888b.
#             Y88b 888 Y88..88P Y88b.  888    888 888 Y8b.          X88
#              "Y88888  "Y88P"   "Y888 888    888 888  "Y8888   88888P'
#
################################################################################

DATETIME=`date -u +"%Y%m%d%H%M.%S"`
REQUIRED_TOOLS="git grep sed tee zsh"
DOTFILES_ROOT="${HOME}/.dotfiles"
DOTFILES_BAK="${HOME}/.backups/${DATETIME}"
DOTFILES_REPO="https://github.com/petemcw/dotfiles.git"
DOTFILES_BRANCH="dockerize"
source $DOTFILES_ROOT/helpers.sh

#
# Systems check
#
tell "Welcome, let's get started"
check_tools

#
# Administrator permissions and keep-alive;
#   update existing `sudo` time stamp until finished
#
tell "I will need admin privileges, you may need to enter your password"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
info "checking privileges"

#
# Clone the repository
#
tell "First I need to make sure you have the repository"
clone_repo

#
# Setup Git configuration
#
tell "Now let's see if Git is configured"
configure_git

#
# Activate new shell
#
tell "Let's make sure you are running zsh"
enable_zsh

#
# Mac OS X extras
#
if [ "$(uname -s)" == "Darwin" ];
then
    tell "I see you're an Apple fan boy"
    setup_osx

    tell "You're going to want Homebrew, I'll set it up"
    homebrew
fi

#
# Symlink dotfiles to home directory
#
tell "Next I'm going to install your dotfiles"
install_dotfiles

# The end
tell "All finished!"
exit
