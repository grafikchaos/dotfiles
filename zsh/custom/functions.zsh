# Checks a boolean variable for "true".
# Case insensitive: "1", "y", "yes", "t", "true", "o", and "on".
function is-true {
  [[ -n "$1" && "$1" == (1|[Yy]([Ee][Ss]|)|[Tt]([Rr][Uu][Ee]|)|[Oo]([Nn]|)) ]]
}

# Checks a name if it is a command, function, or alias.
function is-callable {
  (( $+commands[$1] )) || (( $+functions[$1] )) || (( $+aliases[$1] ))
}

# Misc.
function ips {
  ifconfig | grep "inet " | awk '{ print $2 }'
}

function down4me() {
  curl -s "http://www.downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

function myip {
  res=$(curl -s jsonip.com | grep -Eo '[0-9\.]+')
  echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

# Search through history
function h() {
  if [ -z "$*" ]; then history 1; else history 1 | egrep "$@"; fi
}

# Search through directory contents with grep
function lsgrep() {
  ls | grep "$*"
}

# Makes a directory and changes to it.
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# Changes to a directory and lists its contents.
function cdls {
  builtin cd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pushes an entry onto the directory stack and lists its contents.
function pushdls {
  builtin pushd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Pops an entry off the directory stack and lists its contents.
function popdls {
  builtin popd "$argv[-1]" && ls "${(@)argv[1,-2]}"
}

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Displays user owned processes status.
function psu {
  ps -U "${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

function memcpu() {
    echo "\n*** Top 10 CPU eating processes ***";
    ps auxc | sort -nr -k 3 | head -10;
    echo "\n";
    echo "*** TOP 10 memory eating processes ***";
    ps auxc | sort -nr -k 4 | head -10;
}


function change_trigger_definer() {
  echo "perl -pi -e 's/DEFINER\=\`$1\`/DEFINER\=\`$2\`/g' $3"
}


function add_ssh_key() {
  USER="$1"
  HOST="$2"

  echo "Run this command: "
  echo "cat ~/.ssh/id_rsa.pub | ssh $USER@$HOST \"mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys; chmod 700 ~/.ssh; chmod 600 ~/.ssh/authorized_keys\""
}

# Grep Processes
function psx() {
  ps auxw | grep --color=always $1 | grep -v 'grep';
}

# Install Magento 2 CE via composer
function m2ce_install() {
    PROJECT_DIR="$1"

    echo "====================================================================="
    echo "Fetching Magento 2 CE from https://repo.magento.com and installing it in the $1 directory"
    echo "See http://devdocs.magento.com/guides/v2.0/install-gde/prereq/integrator_install.html#integrator-first-composer-ce for more details including how to get your authentication keys"
    echo "====================================================================="

    composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition "$PROJECT_DIR"
}
