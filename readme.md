# Dotfiles b93rn

These are my dotfiles that i use for private and professional projects.

```zsh
git clone --recursive https://github.com/b93rn/dotfiles.git
```

## VSCode

Link settings.json to the vs code settings:

```bash
ln ~/.dotfiles/vscode/settings.json ~/.config/Code/User
```

Install extensions:

```bash
cat extensions.txt | xargs -L1 code --install-extension
```

## ZSH

Replace all content within your current .zshrc file with the following:

```bash
export ZSH=$HOME/.oh-my-zsh
source $HOME/.dotfiles/zsh/zshrc_manager.sh
source $ZSH/oh-my-zsh.sh
```

### Plugins

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestionsu
```

## Tmux

Tmux config file can be sourced like this:

```bash
printf "source-file $HOME/.dotfiles/tmux/tmux.conf" > ~/.tmux.conf
```

## NVIM

```bash
stow nvim
```

## Terminator

Dracula theme

```bash
printf "source $HOME/.dotfiles/terminator/config" > $HOME/.config/terminator/config
```

## i3

```bash
ln ~/.dotfiles/i3/config ~/.config/i3/
```

### rofi

```bash
mkdir ~/.config/rofi
ln ~/.dotfiles/i3/config.rasi ~/.config/rofi/
```

## Mac OS

### Brew casks

```bash
xargs brew install --cask < ~/.dotfiles/mac/brew-casks.txt
```

### Brew formulae

```bash
xargs brew install < ~/.dotfiles/mac/brew-formulae.txt
```

### Aerospace

```bash
stow aerospace
```

### Kitty

```bash
stow kitty
```

### Ghostty

```bash
stow ghostty
```
