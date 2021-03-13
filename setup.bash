#!/usr/bin/env bash

set -Eeuo pipefail
trap cleanup SIGINT SIGTERM ERR EXIT

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

usage() {
  cat <<EOF
Automatically setup the development environment that I familiar with on debian-based linux.

NOTE: It is the very initial version, bugs may contain, use it, fix it. :(

Usage: $(basename "${BASH_SOURCE[0]}") [-h] [-v] [-f] [--shell SHELL_NAME] [--conda] [--iterm2-shell-integration] [--iterm2-hostname HOSTNAME] [--force-redownload]

Available options:

-h, --help                  Print this help and exit
-v, --verbose               Print script debug info
--shell                     The shell name you use (default: zsh), currently support: bash, zsh
--conda                     Enable miniconda (default: false)
--iterm2-shell-integration  Enable iterm2 shell integration, if you enable it, you must also specify --iterm2-hostname. (default: false)
--iterm2-hostname           It is the hostname you specified when you connect to this machine. E.g. ssh xxx@xxx_hostname, then you should specify it as xxx_hostname.
--force-redownload          Force to redownload every package. (default: false)
EOF
  exit
}

cleanup() {
  trap - SIGINT SIGTERM ERR EXIT
  # TODO: cleanup here
}

setup_colors() {
  if [[ -t 2 ]] && [[ -z "${NO_COLOR-}" ]] && [[ "${TERM-}" != "dumb" ]]; then
    NOFORMAT='\033[0m' RED='\033[0;31m' GREEN='\033[0;32m' ORANGE='\033[0;33m' BLUE='\033[0;34m' PURPLE='\033[0;35m' CYAN='\033[0;36m' YELLOW='\033[1;33m'
  else
    NOFORMAT='' RED='' GREEN='' ORANGE='' BLUE='' PURPLE='' CYAN='' YELLOW=''
  fi
}

msg() {
  echo >&2 -e "${1-}"
}

die() {
  local msg=$1
  local code=${2-1} # default exit status 1
  msg "$msg"
  exit "$code"
}

check_dependency() {
    # TODO: wrap it
    msg "checking dependency..."
    git --version
    curl --version

    msg "${GREEN}all dependencies satisfied\n${NOFORMAT}"
}

mkdir_if_not_exist() {
    mkdir -p "$1"
}

git_clone() {
    git -C "$2" pull || git clone "$1" "$2"
}

need_download() {
    if [[ -n "${force_redownload}" || ! -f "$1" ]]; then
        return 0 # true
    else
        return 1 # false
    fi
}

change_default_shell_if_necessary() {
    # TODO: zsh not exist?
    local current_shell=`getent passwd $LOGNAME | cut -d: -f7`
    local zsh_path=`grep zsh /etc/shells | head -n 1`
    if [[ -n "${zsh_path}" && "$current_shell" != "${zsh_path}" ]]; then
        msg "${GREEN}change default shell to $zsh_path, plz input your password${NOFORMAT}"
        chsh -s $zsh_path $USER
    fi
}

backup_file_if_exist() {
    local f="${1:-}"
    if [ -f "$f" ]; then
        cp "$f" "${f}.bak"
        msg "backup $f to ${f}.bak"
    fi
}

install_zsh_plugins() {
    git_clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/shell/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git_clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/shell/oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.config/shell/oh-my-zsh/custom}/themes/powerlevel10k
}

install_oh_my_zsh() {
    [[ -d "$HOME/.config/shell/oh-my-zsh" ]] && rm -rf "$HOME/.config/shell/oh-my-zsh"
    need_download "$SCRIPT_DIR/install_oh_my_zsh.sh" \
        && curl -L https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "$SCRIPT_DIR/install_oh_my_zsh.sh"
    ZSH="$HOME/.config/shell/oh-my-zsh" RUNZSH="no" CHSH="yes" bash "$SCRIPT_DIR/install_oh_my_zsh.sh"
}

config_zsh() {
    backup_file_if_exist "$HOME/.zshrc"
    install_oh_my_zsh
    install_zsh_plugins
    cp "$HOME/.config/shell/zshrc" "$HOME/.zshrc"

    # no need to change again, since on-my-zsh will change it during the install process
    # change_default_shell_if_necessary
}

config_bash() {
    backup_file_if_exist "$HOME/.bashrc"
    cp "$HOME/.config/shell/bashrc" "$HOME/.bashrc"
}

install_nodejs() {
    mkdir_if_not_exist "$HOME/runtime"
    msg "finding latest lts release nodejs..."
    # FIXME: this will not work on macos
    local latest_lts_version=`curl -s "https://nodejs.org/en/download/" \
        | grep -oP "(?<=Latest LTS Version: <strong>)(.*)(?=</strong>)"`
    local url="https://nodejs.org/dist/v${latest_lts_version}/node-v${latest_lts_version}-linux-x64.tar.xz"
    msg "begin to download nodejs from $url"
    need_download "$SCRIPT_DIR/nodejs.tar.xz" && curl -L "$url" -o "$SCRIPT_DIR/nodejs.tar.xz"
    tar Jxf "$SCRIPT_DIR/nodejs.tar.xz" -C "$HOME/runtime"
    # let the node path comes first, in case the machine has node already installed, but whose version is not what we want
    echo 'export PATH="${HOME}/runtime/node-v'"$latest_lts_version"'-linux-x64/bin:$PATH"' >> "$HOME/.config/shell/envs.sh"
    "${HOME}/runtime/node-v${latest_lts_version}-linux-x64/bin/npm" install -g neovim
}

install_neovim() {
    msg "finding latest release neovim..."
    local url="https://github.com"`curl -s -L https://github.com/neovim/neovim/releases/latest \
        | egrep -o '/neovim/neovim/releases/download/[v]?[0-9.]*/nvim-linux64.tar.gz'`
    msg "begin to download neovim from $url"
    need_download "$SCRIPT_DIR/neovim.tar.gz" && curl -L $url -o "$SCRIPT_DIR/neovim.tar.gz"
    mkdir_if_not_exist "$HOME/software"
    tar zxf "$SCRIPT_DIR/neovim.tar.gz" -C "$HOME/software"
    echo 'export PATH="$PATH:${HOME}/software/nvim-linux64/bin"' >> "$HOME/.config/shell/envs.sh"
}

config_neovim() {
    install_nodejs
    install_neovim
    mkdir_if_not_exist "$HOME/.config"
    cp -r "$SCRIPT_DIR/nvim" "$HOME/.config/"

    msg "${GREEN}neovim configuration done, plugins will be installed the next time you open it\n${NOFORMAT}"
}

install_fzf() {
    mkdir_if_not_exist "$HOME/software"
    mkdir_if_not_exist "$HOME/.config/shell"
    # FIXME: --depth 1 will fail git_clone
    # git_clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/software/fzf"
    git_clone https://github.com/junegunn/fzf.git "$HOME/software/fzf"
    if [[ "${shell}" == "zsh" ]]; then
        $HOME/software/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
        mv "$HOME/.fzf.zsh" "$HOME/.config/shell/fzf.sh"
    elif [[ "${shell}" == "bash" ]]; then
        $HOME/software/fzf/install --key-bindings --completion --no-update-rc --no-zsh --no-fish
        mv "$HOME/.fzf.bash" "$HOME/.config/shell/fzf.sh"
    fi

}

install_bat() {
    mkdir_if_not_exist "$HOME/software"
    [[ -d "$HOME/software/bat" ]] && rm -r "$HOME/software/bat"
    # REFACTOR: duplicate code
    msg "finding latest release bat..."
    local url="https://github.com"`curl -s -L https://github.com/sharkdp/bat/releases/latest \
        | egrep -o '/sharkdp/bat/releases/download/[v]?[0-9.]*/bat_[0-9.]*_amd64.deb'`
    msg "begin to download bat from $url"
    need_download "$SCRIPT_DIR/bat.deb" && curl -L $url -o "$SCRIPT_DIR/bat.deb"
    mkdir_if_not_exist tmp
    dpkg -x "$SCRIPT_DIR/bat.deb" tmp
    mv tmp/usr "$HOME/software/bat"
    echo 'export PATH="$PATH:${HOME}/software/bat/bin"' >> "$HOME/.config/shell/envs.sh"
}

install_iterm2_shell_integration() {
    # TODO: the install script will append 'source xxx' to xshrc, we can remove it
    curl -L https://iterm2.com/shell_integration/install_shell_integration_and_utilities.sh | bash
    if [[ "${shell}" == "zsh" ]]; then
        mv "$HOME/.iterm2_shell_integration.zsh" "$HOME/.config/shell/iterm2_shell_integration.sh"
        # fill the placeholder in zshrc
        sed -i "s/{{placeholder_iterm2_hostname}}/$iterm2_hostname/" "$HOME/.zshrc"
    elif [[ "${shell}" == "bash" ]]; then
        mv "$HOME/.iterm2_shell_integration.bash" "$HOME/.config/shell/iterm2_shell_integration.sh"
        # fill the placeholder in bashrc
        sed -i "s/{{placeholder_iterm2_hostname}}/$iterm2_hostname/" "$HOME/.bashrc"
    fi
}

config_tmux() {
    [[ -f "$HOME/.tmux.conf" ]] && cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
    cp "$SCRIPT_DIR/shell/tmux.conf" "$HOME/.tmux.conf"
}

config_shell() {
    mkdir_if_not_exist "$HOME/.config"
    cp -r "$SCRIPT_DIR/shell" "$HOME/.config/"
    if [[ "${shell}" == "zsh" ]]; then
        config_zsh
    elif [[ "${shell}" == "bash" ]]; then
        config_bash
    fi

    config_tmux

    install_fzf
    install_bat

    # iterm2_shell_integration must come lastly
    [[ -n "${enable_iterm2_shell_integration}" ]] && install_iterm2_shell_integration

    msg "${GREEN}shell config done\n${NOFORMAT}"
}

install_conda() {
    mkdir_if_not_exist "$HOME/runtime/python"
    need_download "$SCRIPT_DIR/conda.sh" \
        && curl -L "https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh" -o "$SCRIPT_DIR/conda.sh"
    bash conda.sh -b -p "$HOME/runtime/python/miniconda"
    echo 'export PATH="$PATH:${HOME}/runtime/python/miniconda/bin"' >> "$HOME/.config/shell/envs.sh"
}

config_conda() {
    install_conda
    cp "$HOME/.config/shell/condarc" "$HOME/.condarc"

    msg "${GREEN}conda config done\n${NOFORMAT}"
}

config_conda_if_necessary() {
    if [[ -n "${enable_conda}" ]]; then
        if [[ -d "${HOME}/runtime/python/miniconda" ]]; then
            msg "${ORANGE}It seems that conda already installed, skip...${NOFORMAT}"
        else
            config_conda
        fi
    fi
}

parse_params() {
  # default values of variables set from params
  shell='zsh'
  enable_conda=''
  enable_iterm2_shell_integration=''
  iterm2_hostname=''
  force_redownload=''

  while :; do
    case "${1-}" in
    -h | --help) usage ;;
    -v | --verbose) set -x ;;
    --no-color) NO_COLOR=1 ;;
    --shell) shell="${2-}"
      shift
      ;;
    --conda) enable_conda='yes' ;;
    --iterm2-shell-integration) enable_iterm2_shell_integration='yes' ;;
    --force-redownload) force_redownload='yes' ;;
    --iterm2-hostname) iterm2_hostname="${2-}"
      shift
      ;;
    -?*) die "Unknown option: $1" ;;
    *) break ;;
    esac
    shift
  done

  # args=("$@")

  # check required params and arguments
  # [[ -z "${param-}" ]] && die "Missing required parameter: param"
  # [[ ${#args[@]} -eq 0 ]] && die "Missing script arguments"
  # [[ -z "${iterm2_hostname}" && -n  ]] \
  [[ -n "${enable_iterm2_shell_integration}" && -z "${iterm2_hostname}" ]] \
      && die "If you want to enable iterm2 shell integration, you must also specify iterm2 hostname by --iterm2-hostname. Use -h for more help info."

  [[ "${shell}" != "zsh" && "${shell}" != "bash" ]] \
      && die "currently support shells: zsh, bash"

  return 0
}

print_parameters() {
    msg "${ORANGE}Parameters:${NOFORMAT}"
    msg "- shell: ${shell}"
    msg "- enable_conda: ${enable_conda}"
    msg "- enable_iterm2_shell_integration: ${enable_iterm2_shell_integration}"
    msg "- iterm2_hostname: ${iterm2_hostname}"
    msg "- force_redownload: ${force_redownload}"
    # msg "- arguments: ${args[*]-}"
}

parse_params "$@"
setup_colors

# script logic here

print_parameters

check_dependency
# must let shell first, then other follows
config_shell
config_neovim

config_conda_if_necessary

msg "\n${GREEN}All done, cheers!${NOFORMAT}\n"

msg "To let vim work properly, make sure your python3 version is ${GREEN}3.6.1+${NOFORMAT}\n"

msg "${ORANGE}Maybe you need run the following two command first to bootstrap vim${NOFORMAT}"
msg "  - pip[3] install pynvim"
msg "  - pip[3] install pyyaml"
msg ""

msg "Relogin and load vim to begin to install plugins"
