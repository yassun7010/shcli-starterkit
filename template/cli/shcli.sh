#!/bin/sh

set -e

shcli_command() {
    project_name=shcli-starterkit
    command_name=shcli
    repository_root=$(
        cd "$(dirname "$0")/.."
        pwd
    )
    commands=$repository_root/cli/commands
    libs=$repository_root/cli/libs

    shell=$SHELL
    cd_trap="${CD_TRAP:-"${XDG_CACHE_HOME:-$HOME/.cache}/.cd_trap"}"
    subcommand_name=$1
    [ $# -gt 0 ] && shift
    case "$subcommand_name" in
        init)
            subcommand_script=$commands/init.sh
            shell=$(get_shell)
            ;;

        cd)
            subcommand_script=$commands/cd.sh
            ;;

        edit)
            subcommand_script=$commands/edit.sh
            ;;

        self)
            subcommand_script=$commands/self.sh
            ;;

        help)
            usage && return
            ;;

        *)
            usage && return 1
            ;;
    esac

    # コマンドの実行
    REPOSITORY_ROOT="$repository_root" \
        SHELL="$shell" \
        CURRENT_PID=$PPID \
        CD_TRAP=$cd_trap \
        PROJECT_NAME="$project_name" \
        COMMAND_NAME="$command_name" \
        COMMANDS="$commands" \
        LIBS="$libs" \
        AWS_PROFILE="$project_name" \
        $subcommand_script "$@"
}

get_shell() {
    shell="$(ps -p "$PPID" -o 'args=' 2> /dev/null || true)"
    shell="${shell%% *}"
    shell="${shell##-}"
    shell="${shell:-$SHELL}"
    shell="${shell##*/}"
    shell="${shell%%-*}"
    echo "$shell"
}

usage() {
    cat <<- END 1>&2
CLI tool for convenient project development.

Commands:
    init           initialize project.
    init -         initialize shell.
    cd [DIRECTORY] change directory on project root.
    edit [FILE]... edit project file.
    self           operate this tool.
    help           print help.

END
}

shcli_command "$@"
