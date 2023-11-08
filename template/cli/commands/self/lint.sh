#!/bin/sh

set -e

# shellcheck source=/dev/null
. "$LIBS/help.sh"

_lint() {
    if [ ! -x "$(command -v shellcheck)" ]; then
        help_need_command shellcheck && return 1
    fi

    cd "$REPOSITORY_ROOT/cli"

    status=0
    sh_files=$(mktemp)
    find . ! -name "$(printf "*\n*")" -name '*.sh' > "$sh_files"
    while IFS= read -r file; do
        echo "cli/$(echo "$file" | cut -c 3-)"
        shellcheck "$file" || status=$?
    done < "$sh_files"
    rm "$sh_files"

    return $status
}

_lint "$@"
