# Returns the IP address of the Docker host (boot2docker)
function dockerip {
  dinghy ip 2> /dev/null
}

# Stop all containers
function dstop {
  docker stop $(docker ps -a -q)
}

# Remove all containers
function drm {
  docker rm $(docker ps -a -q)
}

# Dockerfile build, e.g., dbu petemcw/test
function dbu {
  docker build -t=$1 .;
}

# Connect to a container
function dbash {
  docker exec -it $1 bash;
}

# Remove all untagged images
function drmi {
  docker rmi $(docker images |grep "^<none>" |awk '{ print $3 }')
}

# Remove all orphaned volumes (> v1.9)
function drmv {
  docker volume rm $(docker volume ls -qf dangling=true)
}

#
# Aliases
#
alias d="docker"
alias dcom="docker-compose"

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -P -d"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -P -i -t"

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

