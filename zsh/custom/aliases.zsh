# reload ZSH config
alias reload!='source ~/.zshrc'

# misc. system aliases
alias ssh='ssh -o ServerAliveInterval=60'
alias diff='diff -ubB'
alias untar='tar -zxvf'
alias zipcreate='zip -y -r -q'
alias cp_folder='cp -Rpv'
alias fixpermd='find . -type d -exec chmod 755 {} \;'
alias fixpermf='find . -type f -exec chmod 644 {} \;'
alias nsopen='netstat -lptu'
alias grep="grep -i $GREP_OPTIONS"

# directory listing
alias l='ls -lAh'        # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias sl='ls'            # I often screw this up.

alias phpsize="ps --no-headers -o \"rss,cmd\" -C php-fpm | awk '{ sum+=$1 } END { printf (\"%d%s\n\", sum/NR/1024,\"M\") }'"

# file download
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

# resource usage
alias df='df -kh'
alias du='du -kh'
alias free='free -m'

# composer
alias ci='composer install --no-dev'
alias cu='composer update --no-dev'

if (( $+commands[htop] )); then
  alias top='htop'
else
  alias topc='top -o cpu'
  alias topm='top -o vsize'
fi

