#!/bin/sh
#
# This installs some native OS X apps

brew install caskroom/cask/brew-cask

function installcask() {
    brew cask install "${@}" 2> /dev/null
}

installcask appcleaner
installcask atom
installcask bartender
installcask bettertouchtool
installcask clipmenu
installcask colloquy
installcask dropbox
installcask flux
#installcask firefox
#installcask google-chrome
installcask google-drive
installcask handbrake
installcask hipchat
installcask infinit
installcask iterm2
installcask logitech-harmony
installcask logitech-control-center
installcask minecraft
installcask panic-unison
installcask plex-home-theater
installcask postgres
installcask sequel-pro
installcask sketchup
installcask skype
installcask sonos
installcask spotify
installcask strongvpn-client
installcask superduper
installcask transmission
installcask transmit
installcask vlc

exit 0
