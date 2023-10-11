# 🚀 shcli-starterkit

![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)
[![CI](https://github.com/yassun7010/shcli-starterkit/actions/workflows/ci.yml/badge.svg)](https://github.com/yassun7010/shcli-starterkit/actions/workflows/ci.yml)

`shcli-starterkit` is a CLI tools to make shell script cli tool for your
project.

With this tool, you can create a cli for your project very easily.

## Install

### Clone Repository

```sh
git clone git@github.com:yassun7010/shcli-starterkit.git
```

### Install `cmdcomp`

#### Docker

If you are running dockerd, `cmdcomp` will automatically run using the Docker
image.

#### pipx

If `cmdcomp` is installed locally, it takes precedence over the Docker Image
method. You can use the following method to install `cmdcomp`.

```sh
pipx install cmdcomp
```

### Set up your shell environment for `shcli`

#### For `bash`

```sh:bash
echo 'export PATH=$PATH:'"$(pwd)/bin" >> ~/.bash_profile
echo "[[ -x `which shcli` ]] && eval \"$(shcli init -)\"" >> ~/.bash_profile
```

#### For `zsh`

```sh:zsh
echo 'export PATH=$PATH:'"$(pwd)/bin" >> ~/.zsh_profile
echo "[[ -x `which shcli` ]] && eval \"$(shcli init -)\"" >> ~/.zsh_profile
```

## Usage

Go to the repository where you want to install cli and execute the following
command. As a result, The `cli` and `bin` directories will be created.

```sh
YOUR_PROJECT=
cd $YOUR_PROJECT

PROJECT_NAME=
COMMAND_NAME=
install-shcli $PROJECT_NAME $COMMAND_NAME

# Please read the README for instructions on how to use the generated cli tool.
less cli/README.md
```

## For Developer

### Directory structure

The `template` directory has real sources. The `cli` and `bin` directories are
symbolic links to the directory of the same name in `template`.

The reason why we have symbolic links is that we want to use the `shcli` command
in development process. The symbolic link allows the `shcli` command to be fully
functional without having to look in the `template` directory.

```text
.
├── .vscode -> template/cli/.vscode
├── bin -> template/bin
├── cli -> template/cli
├── template
│  ├── bin
│  │  └── shcli
│  └── cli
│     ├── .vscode
│     └── shcli.sh
└── installer.sh
```
