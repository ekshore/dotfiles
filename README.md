# Caleb's dotfiles

## Basic Info
This repository is meant to be cloned into your home directory and then symlink all of the dot files into their proper place via GNU Stow.

Things configured in this set up
- Allacrity
- zsh
- p10k
- Tmux
- Nvim
- Some of git

## Installs
I have done this setup on MacOS using home brew so all of my commands are with that assumption.
If you are using a linux box you'll have to convert these to be your package manger.

### Zsh
Going to assume this is installed if not look it up, it's default on MacOS

### Allacrity
This is optional but I like using allacrity as my terminal emulator.

```shell
brew install --cask allacrity
```

### Nerd Fonts
```shell
brew install font-hack-nerd-font
```

### Power Level 10 K
There are several ways that you can install this however I've opted to do it through HomeBrew

```shell
brew install powerlevel10k
```
### TMUX

```shell
brew install tmux
```

### Nvim
```shell
brew install nvim
```

### Git
This should be installed by default but if it's not install it.

```shell
brew install git
```

### Zsh nicities
These are somethings that I have to make zsh a little nicer.
All of these can be managed via proper plugin managers however I've just installed them and added them to .zshrc

#### Zsh Auto Suggestions
Provides suggestions from your history.
```shell
brew install zsh-autosuggestions
```

#### Zsh Syntax Highlighting
This does what you think it does
```shell
brew install zsh-syntax-highlighting
```

#### Zoxide
Fuzzy finding `cd` (written in Rust btw) allows you to cd through your directories in a more ergonomic way.
```shell
brew install zoxide
```

#### Eza
Replaces `ls` and makes it a bit nicer
```shell
brew install eza
```

#### Lazygit
I nice tui git client
```shell
brew install lazygit
```
