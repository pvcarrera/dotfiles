dotfiles
========

My configuration files for *nix machines(Mac OS X, Linux)

## Prerequisites

* [Git](http://git-scm.com/)
* [GNU stow](http://www.gnu.org/software/stow/)
* [rbenv](https://github.com/sstephenson/rbenv)

## Installation

Clone the repository in your home directory:

```sh
$ cd
$ git clone --recursive https://github.com/pvcarrera/dotfiles.git
```

Use stow to sym link the conf files you need

```sh
$ cd ~/dotfiles
$ stow bash
$ stow git
$ stow vim
```

### Install Vim plugins

```sh
$ vim
:BundleInstall!
```

## Unlink configuration

Unlink bash configuration example:

```sh
$ cd ~/dotfiles
$ stow --delete bash
```

## Authors

- Pablo Vicente

