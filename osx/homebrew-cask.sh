#!/usr/bin/env bash
#
# This installs some native OS X apps

brew tap caskroom/cask
brew tap caskroom/fonts

function cask() {
    brew cask install "${@}" 2> /dev/null
}

cask 1password
cask appcleaner
cask atom
cask bartender
cask clipmenu
cask dropbox
cask daisydisk
cask evernote
cask firefox
cask flux
cask font-hack-nerd-font
cask google-chrome
cask iterm2
cask java
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
cask virtualbox
cask virtualbox-extension-pack
cask vagrant
cask vlc

exit 0
