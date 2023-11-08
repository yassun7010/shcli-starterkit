#!/bin/sh

set -e

help_need_command() {
    echo "\"$1\" command does not found." 1>&2
}
