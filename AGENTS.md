# Agent Guidelines

This repository contains dotfiles for macOS and Linux environments.

## Multi-Platform Support

These dotfiles are designed to work on both macOS and Linux. Platform-specific configuration is handled by:
- Separate config files (e.g., `tmux-osx.conf`, `tmux-linux.conf`)
- Conditional blocks in `zshrc` using `uname` checks

## Key Files

| File | Description |
|------|-------------|
| `zshrc` | Main zsh config - aliases, PATH, functions. Symlinked to `~/.zshrc` |
| `starship.toml` | Prompt configuration (Starship). Symlinked to `~/.config/starship.toml` |
| `tmux.conf` | Tmux configuration. Symlinked to `~/.tmux.conf`. Sources `tmux-osx.conf` or `tmux-linux.conf` |
| `nvim/` | Neovim config (fork of [NvChad](https://nvchad.com/)). Symlinked to `~/.config/nvim` |

## Local Configuration

Machine-specific settings go in `~/.zshrc.local` (not in this repo). This includes:
- API keys and secrets
- Machine-specific PATH additions
- Tool configurations (goenv, opam, etc.)

## Shell Setup

- **Shell**: Zsh
- **Prompt**: Starship (fast, Rust-based)
- **No oh-my-zsh** - migrated away for faster startup (~120ms)

### Startup optimizations:
- `compinit` is cached (only rebuilds once per day)
- `goenv` is lazy-loaded
- `uv` used instead of pyenv (no shell init needed)

## Python

Using `uv` for Python management:
- Python versions: `uv python install <version>`
- Global tools: `uv tool install <package>`
- Project deps: `uv pip install` / `uv venv`

## Node

Using `fnm` for Node.js version management.

## Install

```bash
git submodule update --init --recursive
bash install.sh
```
