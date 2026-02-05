# Dotfiles

My dotfiles commonly used in a UNIX environment.

## Common Setup

These steps need to be done without considering any target platform:

```bash
# Install submodules
git submodule update --init --recursive

# Link all dotfiles in home-directory
bash install.sh
```

## macOS "From Scratch" Setup

If you are setting up your machine from scratch:

```bash
# Requires XCode to be installed
sudo xcodebuild -license

# Install brew -> http://brew.sh/
```

## macOS Setup

If you are using macOS and want to use the full configuration:

```bash
brew install tmux

# Used by Telescope in nvim for fast file search
brew install ripgrep

# For node management (https://github.com/Schniz/fnm)
brew install fnm
```

## Shell Setup (Zsh + Starship)

This setup uses [Starship](https://starship.rs/) as the prompt (replaced oh-my-zsh for faster startup):

```bash
brew install starship
```

The starship config is in `starship.toml` and should be symlinked:

```bash
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
```

**Shell startup time:** ~120ms

### Key optimizations:
- **Starship** instead of oh-my-zsh (~60% faster)
- **Lazy-loaded goenv** (saves ~100ms)
- **Cached compinit** (saves ~25ms)
- **uv** instead of pyenv (no shell init needed)

## Python Setup

Using [uv](https://github.com/astral-sh/uv) for Python management (replaces pyenv + pip + virtualenv):

```bash
brew install uv

# Install a Python version
uv python install 3.10

# Install global CLI tools
uv tool install llm
uv tool install pynvim
```

## Neovim Setup

The `nvim` directory contains everything you need to get running.
Make sure to link all directories first, otherwise `.config/nvim` doesn't exist yet.

```bash
brew install neovim
```

For Python support in neovim, add to your nvim config:

```lua
vim.g.python3_host_prog = vim.fn.expand('~/.local/share/uv/tools/pynvim/bin/python')
```

## Local Configuration

Each machine has configurations which only make sense for the local context.
Create a `~/.zshrc.local` to apply additional settings (API keys, machine-specific paths, etc.).

## macOS Hints

**Key Repeat:**

```bash
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 2
```
