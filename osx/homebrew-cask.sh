#!/usr/bin/env bash
#
# This installs some native OS X apps

brew tap caskroom/cask

function cask() {
    brew cask install "${@}" 2> /dev/null
}

cask 1password
cask alfred
cask appcleaner
cask bartender
cask bettertouchtool
cask calibre
cask clipmenu
cask colloquy
cask dropbox
cask evernote
cask flux
cask firefox
cask google-chrome
cask handbrake
cask iterm2
cask kindle
cask logitech-control-center
cask minecraft
cask panic-unison
cask phpstorm-eap
cask plex-home-theater
cask postgres
cask sequel-pro
cask sketchup
cask skype
cask slack
cask sonos
cask spotify
cask steam
cask sublime-text3
cask superduper
cask transmission
cask transmit
cask tunnelbear
cask virtualbox
cask virtualbox-extension-pack
cask vagrant
cask vlc

exit 0
