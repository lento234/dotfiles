#!/usr/bin/env bash
# auto-generated from manage.yml on Thu Feb  1 22:30:24 CET 2024

# Exit on error
set -e
# Error on unset variable
set -u

_red="$(tput bold; tput setaf 1)"
_green="$(tput bold; tput setaf 6)"
_violet="$(tput bold; tput setaf 5)"
_blue="$(tput bold; tput setaf 4)"
_bold="$(tput bold)"
_redbk="$(tput bold; tput setab 9)"
_reset="$(tput sgr0)"

fatal() { (>&2 echo -e "${_redbk}FATAL${_reset} $*"); exit 1; }
info() { echo -e "${_green}INFO${_reset} $*"; }

# Help
cmd_help() {
    # Usage section
    echo -e "Usage: ${_bold}./$(basename $0)${_reset} [${_blue}command${_reset}] [--${_violet}args${_reset} arg ...]"
    echo ""

    # Command sections
    echo -e "Command:"
    echo -e "  ${_blue}nvim    ${_reset}setup nvim dotfiles"
    echo -e "  ${_blue}shell   ${_reset}setup shell dotfiles"
    echo -e "    --${_violet}shell${_reset} (default: 'bash')"
    echo -e "  ${_blue}tmux    ${_reset}setup tmux dotfiles"
    # Help section
    echo ""
    echo "  help, -h, --help  show this help"
}


# Description: setup nvim dotfiles
cmd_nvim() {
    info "Running job: ${_blue}nvim${_reset}"

    # Script
    if [ -f ~/.config/nvim ]; then
        mv -v ~/.config/nvim ~/.config/nvim.old
    fi
    ln -sv ${PWD}/nvim ~/.config/nvim

    info "Job ${_blue}nvim${_reset} completed."
}

# Description: setup shell dotfiles
cmd_shell() {
    info "Running job: ${_blue}shell${_reset}"

    # parse options
    local tmp="$@"
    local shell="bash"
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --shell) shell="$2"; shift 2;;
            *) shift 2;;
        esac
    done
    set -- "$tmp"
    unset tmp

    # Script
    _shell=$shell
    [[ "${_shell}" == "zsh" || "${_shell}" == "bash" ]]\
      || (echo "'${_shell}' not valid shell"; exit 1)

    if [ -f ~/.aliases ]; then
        mv -v ~/.aliases ~/.aliases.old
    fi
    ln -sv ${PWD}/$shell/aliases ~/.aliases

    if [ -f ~/.$shellrc ]; then
        cp -v ~/.$shellrc ~/.$shellrc.old
        echo "[ -f ~/.aliases ] && source ~/.aliases " >> ~/.$shellrc
    fi


    info "Job ${_blue}shell${_reset} completed."
}

# Description: setup tmux dotfiles
cmd_tmux() {
    info "Running job: ${_blue}tmux${_reset}"

    # Script
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    if [ -f ~/.tmux.conf ]; then
        mv -v ~/.tmux.conf ~/.tmux.conf.old
    fi


    ln -sv ${PWD}/tmux/tmux.conf ~/.tmux.conf

    info "Job ${_blue}tmux${_reset} completed."
}


main() {
    if [[ $# == 0 || $1 == "-h" || $1 == "--help" || $1 == "help" ]]; then
        cmd_help
        exit 0
    fi

    # Check all the cases
    cmd="$1"
    case "$cmd" in
        nvim|shell|tmux)
            shift
            cmd_"$cmd" "$@"
            ;;
        *) fatal "unknown command ${_blue}$1${_reset}";;
    esac
}

main "$@"
