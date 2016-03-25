FROM ubuntu:14.04.1
MAINTAINER Pete McWilliams <pmcwilliams@augustash.com>

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm-256color

# Command to run
CMD [ "/bin/zsh" ]

# Set locale to UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
RUN locale-gen $LANG && \
  /usr/sbin/update-locale LANG=$LANG

# Install
RUN \
  apt-get -yqq update && \
  apt-get -yqq install \
    autoconf \
    build-essential \
    curl \
    git \
    python \
    tmux \
    vim \
    wget \
    zsh && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Change shell
ENV SHELL /bin/zsh
RUN chsh -s /bin/zsh

# Add dotfiles
WORKDIR /root
RUN mkdir -p /root/.dotfiles
VOLUME [ "/root/.dotfiles" ]
