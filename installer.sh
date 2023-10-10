#!/bin/sh

set -e

install_shcli() {
    project_name="$1"
    cli_name="${2:-$project_name}"

    if [ $# -gt 2 ]; then
        printf "ERROR: Too many arguments.\n\n" 1>&2
        usage
        return 1
    fi

    if [ "$project_name" = "" ]; then
        printf "ERROR: Please input PROJECT_NAME.\n\n" 1>&2
        usage
        return 1
    fi

    if [ "$cli_name" = "help" ] || [ "$cli_name" = "--help" ]; then
        usage
        return 1
    fi

    if [ ! -x "$(command -v ed)" ]; then
        echo 'ERROR: "ed" command does not found.' 1>&2
        return 1
    fi

    [ -d ./bin ] && echo "ERROR: 'bin' already exists." 1>&2 && return 1
    [ -d ./cli ] && echo "ERROR: 'cli' already exists." 1>&2 && return 1

    # copy template
    cp -r "$(dirname "$0")"/template/* .

    # rename tool name.
    grep -r -e 'shcli-starterkit' -e 'shcli' bin/ cli/ | awk -F':' '{print $1}' | while read -r i; do
        cli_command="$(echo "${cli_name}_command" | sed -e 's/-/_/g')"
        ed "$i" 1> /dev/null 2>&1 << END
            1
            g/shcli-starterkit/s//$project_name/g
            1
            g/shcli_command/s//$cli_command/g
            1
            g/shcli/s//$cli_name/g
            w
            q
END
    done

    # rename filename.
    mv bin/shcli bin/"$cli_name"
    mv cli/shcli.sh cli/"$cli_name".sh
    mv cli/completion/shcli_cmdcomp.yaml cli/completion/"$cli_name"_cmdcomp.yaml
}

usage() {
    cat <<- END 1>&2
Usage:
    install-shcli.sh PROJECT_NAME [CLI_NAME]

END
}

install_shcli "$@"
