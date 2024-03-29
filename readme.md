# Dotfiles b93rn

These are my dotfiles that i use for private and professional projects.

```bash
git clone --recursive https://github.com/b93rn/dotfiles.git
```

## VSCode

Link settings.json to the vs code settings:

```bash
ln ~/.dotfiles/vscode/settings.json ~/.config/Code/User
```

## ZSH

Replace all content within your current .zshrc file with the following:

```bash
export ZSH=$HOME/.oh-my-zsh
source $HOME/.dotfiles/zsh/zshrc_manager.sh
source $ZSH/oh-my-zsh.sh
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
ln ~/dotfiles/i3/config.rasi ~/.config/rofi/
```
