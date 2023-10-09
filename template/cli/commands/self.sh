#!/bin/sh

set -e

self() {
    sub_command="$1"
    [ $# -gt 0 ] && shift
    case $sub_command in
        format)
            "$COMMANDS/self/format.sh" "$@"
            ;;
        lint)
            "$COMMANDS/self/lint.sh" "$@"
            ;;
        *)
            usage
            ;;
    esac
}

usage() {
    cat <<- END 1>&2
Commands:
    format [--dry-run]               format this tool.
    lint                             lint this tool.

END
}

self "$@"
