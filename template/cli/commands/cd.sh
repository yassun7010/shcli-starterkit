#!/bin/sh

set -e

_cd() {
    echo "cd $REPOSITORY_ROOT/$1" > "$CD_TRAP" \
        && kill -USR1 "$CURRENT_PID"
}

_cd "$@"
