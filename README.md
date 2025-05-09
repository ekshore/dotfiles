# Caleb's dotfiles

## Basic Info
This repository is meant to be cloned into your home directory and then symlink all of the dot files into their proper place via GNU Stow.

Things configured in this set up
- Alacritty
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

### Ghostty
This is optional but I like using allacrity as my terminal emulator.

```shell
brew install --cask ghostty
```

### Nerd Fonts
```shell
brew install font-hack-nerd-font
```

### Starship
I've opted to replace `ohmyzsh` / `powerlevel10k` with starship. Powerlevel10k has been discontinued and I don't want to add the overhead of ohmyzsh.

```shell
brew install starship
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

### AeroSpace
AeroSpace is a tiling window manager for MacOS based on i3. I like it for improving my work flow.

```shell
brew install --cask nikitabobko/tap/aerospace
```

### GNU Stow
```shell
brew install stow
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

## GNU Stow
GNU Stow sym links everyting in the target directory into it's parent directory.
Allowing you to have all of your managed dotfiles in one git controlled directory but also where they need to be.
After installing GNU stow run the following command inside of this repo's directory to symlink everything into your home directory
```shell
stow .
```
