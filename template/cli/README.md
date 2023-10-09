# shcli

CLI tool for convenient project development.

## Install

### For bash

```sh
echo 'export PATH=$PATH:'"$(pwd)/bin" >> ~/.bash_profile
echo "[[ -x `which shcli` ]] && eval \"$(shcli init -)\"" >> ~/.bash_profile
```

### For zsh

```sh
echo 'export PATH=$PATH:'"$(pwd)/bin" >> ~/.zsh_profile echo "[[ -x
`which shcli` ]] && eval \"$(shcli init -)\"" >> ~/.zsh_profile
```

## Usage

### Initialize

Install the tools necessary to run the project.

```sh
shcli init
```

### Change Directory To Project

```sh
shcli cd
```

### Edit Project

```sh
shcli edit
```
