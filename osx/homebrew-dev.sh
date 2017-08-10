#!/usr/bin/env bash
#
# This installs some development packages using Homebrew.

echo "  Installing development brews.\n "

# common packages
brew install ansible@1.9
brew install dnsmasq
brew install composer
brew install n98-magerun
brew install n98-magerun2
brew install drush
brew install git
brew install git-flow
brew install git-lfs
brew install heroku-toolbelt
brew install jq
brew install lynx
brew install mcrypt
brew install nginx
brew install ngrok
brew install imagemagick
brew install node
brew install percona-server
brew install redis
brew install php56 --with-fpm --without-apache --with-homebrew-curl --with-homebrew-openssl --without-snmp --with-mysql
brew install php56-ioncubeloader
brew install php56-mcrypt
brew install php56-redis
brew install php56-intl
brew unlink php56
brew install php70 --with-fpm --without-apache --with-homebrew-curl --with-homebrew-openssl --without-snmp --with-mysql
brew install php70-mcrypt
brew install php70-opcache
brew install php70-xdebug
brew install php70-intl

# Or https://www.docker.com/toolbox
#brew install docker
#brew install docker-machine
#brew install docker-compose

# remove outdated versions
brew cleanup

exit 0
