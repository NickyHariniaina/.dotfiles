# dotfiles

My personal dotfiles for Arch Linux / Hyprland desktop.

## Structure

```
~/.dotfiles/
├── gitconfig          # Git config (aliases, delta, rebase defaults)
├── tmux.conf          # Tmux config (vi mode, C-a prefix, resize bindings)
├── zshrc              # Zsh config (starship, zoxide, fzf, completions)
├── zshenv             # Zsh env (cargo)
├── zprofile           # Zsh profile
└── config/
    ├── nvim/          # Neovim (LSP, DAP, Treesitter, Telescope, cmp...)
    ├── hypr/          # Hyprland (keybinds, animations, rules, hyprlock)
    ├── waybar/        # Wayland status bar
    ├── rofi/          # App launcher
    ├── swaync/        # Notification center
    ├── wlogout/       # Logout / lock screen
    ├── picom/         # Compositor
    ├── ghostty/       # Terminal emulator
    ├── kitty/         # Terminal emulator (alt)
    ├── yazi/          # File manager
    ├── btop/          # System monitor
    ├── fastfetch/     # System info
    ├── dunst/         # Notifications (legacy)
    ├── mpv/           # Media player (uosc, sponsorblock)
    ├── gtk-3.0/       # GTK theme (Catppuccin-based)
    ├── zathura/       # PDF viewer
    ├── wallust/       # Wallpaper colorscheme generator
    ├── cava/          # Audio visualizer
    ├── gh/            # GitHub CLI
    ├── lazygit/       # Git TUI
    └── fontconfig/    # Font rendering
```

## Setup on a new machine

```sh
# Clone into home
git clone https://github.com/NickyHariniaina/dotfiles ~/.dotfiles

# Symlink root files
ln -sf ~/.dotfiles/gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/zshrc ~/.zshrc
ln -sf ~/.dotfiles/zshenv ~/.zshenv
ln -sf ~/.dotfiles/zprofile ~/.zprofile

# Symlink config directories
for dir in ~/.dotfiles/config/*/; do
  name=$(basename "$dir")
  ln -sfn "$dir" ~/.config/"$name"
done

# Install Neovim plugins
nvim --headless "+lua vim.pack.sync()" +qa
```

## Git aliases

| Alias    | Command                                |
|----------|----------------------------------------|
| `s`      | `status -s`                            |
| `l`      | `log --oneline --graph --decorate -20` |
| `a`      | `add`                                  |
| `aa`     | `add -A`                               |
| `c`      | `commit`                               |
| `cm`     | `commit -m`                            |
| `ca`     | `commit --amend`                       |
| `co`     | `checkout`                             |
| `cb`     | `checkout -b`                          |
| `b`      | `branch`                               |
| `d`      | `diff`                                 |
| `ds`     | `diff --staged`                        |
| `push`   | `push -u origin HEAD`                  |
| `undo`   | `reset HEAD~1 --soft`                  |
| `unstage`| `restore --staged .`                   |
| `discard`| `restore .`                            |
| `clean`  | `clean -fd`                            |
