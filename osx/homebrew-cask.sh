#!/usr/bin/env bash
#
# This installs some native OS X apps

brew tap caskroom/cask

function cask() {
    brew cask install "${@}" 2> /dev/null
}

cask 1password
cask appcleaner
cask atom
cask bartender
cask bettertouchtool
cask clipmenu
cask colloquy
cask dropbox
cask daisydisk
cask evernote
cask flux
cask firefox
cask google-chrome
cask handbrake
cask iterm2
cask kindle
cask logitech-control-center
cask navicat-for-postgresql
cask navicat-for-oracle
cask panic-unison
cask postgres
cask sequel-pro
cask sketchup
cask slack
cask spotify
cask sqlpro-for-mssql
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
