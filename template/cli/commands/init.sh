#!/bin/sh

set -e

init() {
    # if args are empty, run initialization.
    if [ $# = 0 ]; then
        echo "📝 Please add the initialization process for this project." 1>&2

        return
    fi

    for arg in "$@"; do
        case "$arg" in
            -)
                shift
                exec "$COMMANDS/init/_shell.sh" "$@"
                return
                ;;
        esac
    done

    usage && return 1
}

usage() {
    cat <<- END 1>&2
Commands:
    init                       initialize project.
    init - [bash|zsh|csh|fish] initialize shell setting.

END
}

init "$@"
