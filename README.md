dotfiles
========

My configuration files for *nix machines(Mac OS X, Linux)

## Installation

Clone the repository:

```sh
$ git clone --recursive https://github.com/pvcarrera/dotfiles.git
```

Use stow to sym link the conf files you need

```sh
$ cd ~/dotfiles
$ stow bash
$ stow bin
```

## Unlink configuration

Unlink bash configuration example:

```sh
$ cd ~/dotfiles
$ stow bash
```

## Authors

- Pablo Vicente

