# Dotfiles b93rn

These are my dotfiles that i use for private and professional projects.

## VSCode

Link settings.json to the vs code settings.

```bash
ln ~/dotfiles/vscode/settings.json ~/.config/Code/User
```

## ZSH

Replace all content within your current .zshrc file with the following:

```bash
export ZSH=$HOME/.oh-my-zsh
source $HOME/dotfiles/zsh/zshrc_manager.sh
source $ZSH/oh-my-zsh.sh
```
