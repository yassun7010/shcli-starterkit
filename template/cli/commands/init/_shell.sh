#!/bin/sh

set -e

init_shell() {
    shell=${1:-$SHELL}
    case "$shell" in
        bsh | bash)
            shell=bash
            ;;

        zsh)
            :
            ;;

        *)
            echo "\"$shell\" is not supported." 1>&2
            return 1
            ;;
    esac

    "$COMMANDS/init/_shell/_$shell.sh"
    trap_cd
    complete_cli "$shell"
}

trap_cd() {
    echo "trap \"source $CD_TRAP\" SIGUSR1;"
}

complete_cli() {
    "$COMMANDS/init/_shell/_complete.sh" "$1"
}

init_shell "$@"
