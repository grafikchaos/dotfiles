#!/usr/bin/env bash
#
# This installs some of the common dependencies desired using Homebrew.

# update repository
brew update

# taps
brew tap homebrew/php
brew tap caskroom/cask
brew tap caskroom/versions
brew tap caskroom/fonts
brew tap gapple/services

# install updated utilities
# - GNU core utilities
# - GNU `find`, `locate`, `updatedb`, `xargs`
brew install git git-flow coreutils findutils moreutils grc spark zsh
brew install gnu-sed --with-default-names

# common packages
brew install ack
brew install bash-completion
brew install cmake
brew install ffmpeg --with-fdk-aac --with-ffplay --with-freetype --with-libass --with-libquvi --with-libvorbis --with-libvpx --with-opus --with-x265
brew install htop-osx
brew install p7zip
brew install python
brew install rbenv
brew install ruby-build
brew install curl
brew install speedtest_cli
brew install sqlite
brew install ssh-copy-id
brew install the_silver_searcher
brew install tmux
brew install tree
brew install icu4c
brew install vim --env-std --override-system-vim --enable-pythoninterp  --with-ruby --with-perl
# wget with IRI support
brew install wget --with-iri

# install powerline
pip install git+git://github.com/powerline/powerline
pip install psutil

# remove outdated versions
brew cleanup

exit 0
