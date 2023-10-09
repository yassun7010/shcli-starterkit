#!/bin/sh

set -e

edit() {
    path=${*:-"."}
    editor=${SHCLI_EDITOR:-${EDITOR:-code}}

    cd "$REPOSITORY_ROOT"

    if [ "$editor" = "code" ] \
        && [ "$path" = "." ] \
        && [ -e "${PROJECT_NAME}.code-workspace" ]; then
        path="${PROJECT_NAME}.code-workspace"
    fi

    $editor "$path"
}

edit "$@"
