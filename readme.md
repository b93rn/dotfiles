# Dotfiles b93rn

These are my dotfiles that i use for private and professional projects.

```zsh
git clone https://github.com/b93rn/dotfiles.git
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

Stow the zsh configuration:

```bash
stow zsh
```

This will create symlinks for:

- `~/.zshrc` - Main zsh configuration file
- `~/.zsh/` - Directory for custom zsh scripts and plugins

### Plugins

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
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
