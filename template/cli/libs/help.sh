#!/bin/sh

set -e

help_command_not_found() {
    echo "\"$1\" command does not found." 1>&2
}
