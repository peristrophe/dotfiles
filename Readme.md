# Installation

```
$ make deploy
$ make install
```

# Homebrew

```
$ brew bundle
```

# About Resources

In this environ using patched fonts for custom status-line on vim/tmux.

Patched fonts repository is below.

```
$ git clone https://github.com/powerline/fonts.git
```

Fontpatcher repository is below.

```
$ git clone https://github.com/powerline/fontpatcher.git
```

# Build docker image for sandbox

after `make deploy`

```
$ cd
$ make clean build
```

usage.

```
$ make enter
$ make enter USERNAME=root   # logging in by root user
```
