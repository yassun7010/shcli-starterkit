#!/bin/sh

set -e

_format() {
    if [ ! -x "$(command -v shfmt)" ]; then
        echo '"shfmt" command does not found.' 1>&2 && return 1
    fi

    if [ "$1" = "--dry-run" ]; then
        option="-d"
    else
        option="-w"
    fi

    cd "$REPOSITORY_ROOT/cli"

    status=0
    sh_files=$(mktemp)
    find . ! -name "$(printf "*\n*")" -name '*.sh' > "$sh_files"
    while IFS= read -r file; do
        echo "cli/$(echo "$file" | cut -c 3-)"
        shfmt "$option" "$file" || status=$?
    done < "$sh_files"
    rm "$sh_files"

    return $status
}

_format "$@"
