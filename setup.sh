#!/bin/bash

# the directory of this script file
dir="$(cd "$(dirname "$0")"; pwd)"
cd "$dir"

# echo $1 in underline green then $2 in yellow
log() {
   echo -e "\033[1;4;32m$1\033[0m \033[1;33m$2\033[0m"
}

# echo $1 in underline magenta then $2 in cyan
err() {
    echo -e "\033[1;4;35m$1\033[0m \033[1;36m$2\033[0m" >&2
}

log 'docker pull' ubuntu
docker pull ubuntu

log create settings.sh
cp --no-clobber settings.sample.sh settings.sh

# check if variables are already defined
source settings.sh

if [[ -z $(echo "$GITHUB_LOGIN") ]];
then
    err important 'variables in `settings.sh` must be defined'
fi