# Dotfiles

My dotfiles commonly used in a UNIX environment.

## Common Setup

```bash
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

The starship config is in `starship.toml` (symlinked by `install.sh`).

## Herdr Setup

The Herdr config is in `herdr/config.toml` and is symlinked to `~/.config/herdr/config.toml` by `install.sh`.

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

## Pi Setup

`pi/settings.json` and `pi/keybindings.json` are the portable user config.
`install.sh` symlinks them into `~/.pi/agent/` (or `PI_CODING_AGENT_DIR`).
It converts identical existing files to symlinks, but leaves differing files and
other symlinks untouched. Back up and reconcile any skipped files manually.
Run `/reload` in Pi after changing config. Alt+N jumps to the transcript bottom
and follows new output in fullscreen mode.

Use `pi/`, not `.pi/`: `.pi/` is Pi's project-specific configuration directory.
Pi can update the linked settings when preferences change; review the Git diff.
`pi/.gitignore` permits only the two approved config files; extend that allowlist
when deliberately adding more portable config.

### Other Pi resources (audit)

- `~/.pi/agent/AGENTS.md` and most skills/extensions are already symlinked to
  `personal-pi-extensions` or `minibot` checkouts. Keep their source in those repos
  rather than copying it here. They still need a separate checkout/install.
- Local extensions worth reviewing for migration: `herdr-agent-state.ts` and
  `workmux-status.ts` in `~/.pi/agent/extensions/`.
- Local skills worth reviewing: `herdr`, `herdwerk`, and `rebase` in
  `~/.pi/agent/skills/`. Review private paths/context before tracking them.
  The local `datadog` skill collection should be managed from its upstream source.
- Broken links found during the audit: `extensions/fzf.ts`,
  `skills/example-skill`, and `skills/merge`. These were left untouched.
- Keep authentication, sessions, trust decisions, model caches, logs, private
  `context/`, Ketryx environment/user mappings, the vault, and sound runtime state
  outside Git. Review any future MCP/provider config for secrets first.

Do **not** symlink or copy the entire `~/.pi/agent` directory into this repository.

## Local Configuration

Each machine has configurations which only make sense for the local context.
Create a `~/.zshrc.local` to apply additional settings (API keys, machine-specific paths, etc.).

## macOS Hints

**Key Repeat:**

```bash
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 2
```
