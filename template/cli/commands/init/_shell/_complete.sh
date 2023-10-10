#!/bin/sh

set -e

_complete() {
    shell_type="$1"
    config_file="cli/completion/${COMMAND_NAME}_cmdcomp.yaml"
    output_file="cli/completion/${shell_type}"

    echo "source $REPOSITORY_ROOT/$output_file"

    [ -e "$REPOSITORY_ROOT/$output_file" ] \
        && [ -n "$(find "$REPOSITORY_ROOT/$output_file" -newer "$REPOSITORY_ROOT/$config_file")" ] \
        && return

    printf "%s command completion update..." "${COMMAND_NAME}" 1>&2

    if [ -x "$(command -v cmdcomp)" ]; then
        cmdcomp \
            --file "$config_file" \
            --shell-type "$shell_type" \
            --output "$output_file"

    else
        docker run --rm -itv "$REPOSITORY_ROOT:/app/cmdcomp" yassun7010/cmdcomp:2.5 \
            --file "$config_file" \
            --shell-type "$shell_type" \
            --output "$output_file"

    fi

    echo "Done" 1>&2
}

_complete "$@"
