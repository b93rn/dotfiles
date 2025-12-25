# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow for creating symlinks. It contains configuration files for development tools across macOS and Linux platforms, with a focus on terminal-based workflows.

## Setup and Installation

The repository uses **GNU Stow** for symlink management. Common stow commands:

```bash
# Install a configuration
stow <directory-name>

# Remove a configuration
stow -D <directory-name>

# Example: Install zsh config (creates ~/.zshrc and ~/.zsh/)
stow zsh
```

### Special Installation Cases

**Tmux** (requires sourcing instead of stowing):
```bash
printf "source-file $HOME/.dotfiles/tmux/tmux.conf" > ~/.tmux.conf
```

**VSCode** (manual symlink):
```bash
ln ~/.dotfiles/vscode/settings.json ~/.config/Code/User
cat extensions.txt | xargs -L1 code --install-extension
```

**i3 window manager** (manual symlink):
```bash
ln ~/.dotfiles/i3/config ~/.config/i3/
mkdir ~/.config/rofi
ln ~/.dotfiles/i3/config.rasi ~/.config/rofi/
```

**Homebrew packages** (macOS):
```bash
xargs brew install --cask < ~/.dotfiles/mac/brew-casks.txt
xargs brew install < ~/.dotfiles/mac/brew-formulae.txt
```

**Zsh plugins**:
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Architecture

### Configuration Layers

1. **Shell Layer** (Zsh)
   - Main config: `zsh/.zshrc`
   - Custom scripts: `zsh/.zsh/` (custom.zsh, kube-ps1.zsh)
   - Uses Oh-My-Zsh with plugins: git, kubernetes, azure, dotnet, zsh-autosuggestions, kube-ps1

2. **Editor Layer** (Neovim)
   - Main config: `nvim/.config/nvim/init.vim`
   - Lua modules: `nvim/.config/nvim/lua/airborn/` (telescope.lua, luasnip.lua, init.lua)
   - Uses vim-plug for plugin management
   - Custom Telescope commands for dotfiles and project navigation

3. **Window Management**
   - macOS: Aerospace tiling WM (`aerospace/.aerospace.toml`) + Borders
   - Linux: i3 WM (`i3/config`) + Rofi launcher

4. **Terminal Emulators**
   - macOS primary: Ghostty (`ghostty/.config/ghostty/config`)
   - macOS backup: Kitty (`kitty/.config/kitty/kitty.conf`)
   - Linux: Alacritty (`alacritty/dracula.toml`)
   - Consistent Dracula/Vesper theming across all terminals

5. **Terminal Multiplexer**
   - Tmux (`tmux/.tmux.conf`) with Alt-s prefix and Dracula theme

### Key Dependencies

- Neovim LSP requires OmniSharp for C# development
- Aerospace launches Ghostty on macOS
- i3 launches Alacritty on Linux
- Zsh integrates with Kubernetes tools (kubectl, kubectx, kube-ps1)
- All configurations use consistent color themes (Dracula/Vesper/Catppuccin-Mocha)

## Development Focus

- **Primary languages**: C#/.NET, Python, JavaScript/TypeScript
- **Platforms**: macOS (primary), Linux, Kubernetes
- **Cloud**: Azure, Databricks
- **Workflow**: Project-centric with fzf-based quick navigation

## Common Modifications

When editing configurations:

- **Zsh aliases/functions**: Edit `zsh/.zshrc` or add to `zsh/.zsh/custom.zsh`
- **Neovim keybindings**: Edit `nvim/.config/nvim/lua/airborn/init.lua`
- **Neovim plugins**: Managed in `nvim/.config/nvim/plugged/` (uses vim-plug)
- **Window manager shortcuts**:
  - macOS: `aerospace/.aerospace.toml`
  - Linux: `i3/config`
- **Terminal themes**: Each terminal has its own theme config file
- **Homebrew packages**: Update `mac/brew-casks.txt` or `mac/brew-formulae.txt`

## Notes

- The `.stow-local-ignore` file controls which files Stow ignores when creating symlinks
- Tmux uses TPM (Tmux Plugin Manager) for plugin management
- Recent commit history shows active theme switching (Dracula → Catppuccin-Mocha for Ghostty)
- Custom cp function in zshrc handles git repository detection
