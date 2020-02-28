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

[[ ! -f settings.sh ]] \
    && err abort 'settings.sh is missing' \
    && exit 1

source settings.sh

[[ -z $(echo "$GITHUB_LOGIN") ]] \
    && err abort 'variables must be defined in settings.sh' \
    && exit 1


log apt update
apt update

for prog in git git-flow curl zsh nano;
do
    log install $prog
    apt install --yes $prog
done

chsh --shell /bin/zsh

log install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

log configure git
git config --global user.email $GIT_CONFIG_EMAIL
git config --global user.name $GIT_CONFIG_NAME

log create '~/.netrc' 
echo "machine github.com
login $GITHUB_LOGIN
password $GITHUB_PASSWORD" > ~/.netrc