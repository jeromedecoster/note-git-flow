#!/bin/bash

# the directory of this script file
dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dir"

# echo $1 in underline green then $2 in yellow
log() {
   echo -e "\033[1;4;32m$1\033[0m \033[1;33m$2\033[0m"
}

log 'docker run' ubuntu
RAND=flow-$(mktemp --dry-run XXXX)
docker run \
    --detach \
    --interactive \
    --tty \
    --name $RAND \
    --volume $(pwd):/var/task \
    --workdir /tmp \
    ubuntu

log 'docker exec' install.sh
docker exec $RAND bash /var/task/install.sh

log 'docker commit' flow
docker commit --change='CMD ["/bin/zsh"]' $RAND flow

log 'docker' 'remove temp container'
docker container stop $RAND
docker container rm $RAND

log 'created' 'docker image "flow"'