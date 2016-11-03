# pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# shorten up n98
alias n="n98-magerun"
alias n2="n98-magerun2"

# Magedownload-cli (https://github.com/steverobbins/magedownload-cli)
alias magedownload="$HOME/.bin/magedownload.phar"

# git
alias g="git"
alias gs="git status"
alias gb="git branch"


# update lookup database
alias updatedb="sudo /usr/libexec/locate.updatedb"

# flush local DNS cache
alias flush-dns="dscacheutil -flushcache"

# kill preferences system
alias flush-prefs="killall cfprefsd"

# clean up LaunchServices to remove duplicates in the "Open With" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# redis
alias redis.start="brew services start redis"
alias redis.stop="brew services stop redis"
alias redis.restart="brew services restart redis"
alias redis.status="/usr/local/bin/redis-cli status"

# dns
alias dns.start="sudo brew services start dnsmasq"
alias dns.stop="sudo brew services stop dnsmasq"
alias dns.restart="sudo brew services restart dnsmasq"
alias dns.flush="flush-dns"

# nginx
alias nginx.start="sudo brew services start nginx"
alias nginx.stop="sudo brew services stop nginx"
alias nginx.restart="sudo brew services restart nginx"
alias nginx.reload="sudo /usr/local/bin/nginx -s reload"
alias vhosts="cd /etc/nginx/sites-enabled"

# percona
alias percona.start="brew services start percona-server"
alias percona.stop="brew services stop percona-server"
alias percona.restart="brew services restart percona-server"
