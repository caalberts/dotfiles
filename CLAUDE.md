# CLAUDE.md - AI Assistant Guide for Dotfiles Repository

This document provides comprehensive guidance for AI assistants working with this dotfiles repository.

## Repository Overview

**Name**: dotfiles - "dev-machine-as-code"
**Purpose**: Personal development environment configuration and machine setup
**Philosophy**: A structured checklist and guideline for setting up a new Mac, not a fully automated installer
**Primary OS**: macOS (with some Linux compatibility)

This repository manages configuration files (dotfiles) for various development tools, shells, editors, and applications. It uses GNU stow for symlinking dotfiles and Homebrew for package management.

## Repository Structure

```
dotfiles/
├── asdf/              # asdf version manager configuration
├── bash/              # Bash shell configuration
├── brew/              # Homebrew package definitions
├── direnv/            # direnv environment switcher config
├── fish/              # Fish shell configuration and plugins
├── ghostty/           # Ghostty terminal emulator config
├── git/               # Git configuration and templates
├── kitty/             # Kitty terminal emulator config
├── mackup/            # GUI application config sync
├── profile/           # Shell profile initialization
├── tmux/              # TMux terminal multiplexer config
├── vim/               # Vim editor configuration and plugins
├── up                 # Main setup script (executable)
├── README.md          # User-facing setup guide
└── .gitignore         # Git ignore patterns
```

## Directory Organization Pattern

Each directory follows a **tool-centric organization** that mirrors the home directory structure:

- `fish/.config/fish/` → symlinks to `~/.config/fish/`
- `git/.gitconfig` → symlinks to `~/.gitconfig`
- `vim/.vimrc` → symlinks to `~/.vimrc`

This pattern enables **GNU stow** to create symlinks automatically by running:
```bash
cd /home/user/dotfiles
stow <directory-name>
```

## Key Files and Their Purposes

### Shell Configuration

| File | Purpose | Key Features |
|------|---------|--------------|
| `bash/.bashrc` | Bash runtime config | FZF integration, Terraform completion, asdf |
| `bash/.bash_profile` | Bash login shell | GCP SDK, PostgreSQL paths |
| `fish/.config/fish/config.fish` | Fish shell config | Aliases, GOPATH, direnv, git shortcuts |
| `fish/fish_plugins` | Fish plugin list | fzf, z (jump), forgit, Dracula theme, Tide prompt |
| `profile/.profile` | POSIX shell profile | Homebrew shellenv |

### Version Management

| File | Purpose |
|------|---------|
| `asdf/.tool-versions` | Pinned language versions (Ruby, Node, Go, Python, Rust, Elixir, Clojure, Terraform, Postgres) |
| `asdf/.asdfrc` | asdf configuration (legacy_version_file enabled) |
| `asdf/.default-gems` | Auto-installed Ruby gems: bundler, pry, ruby-debug-ide |

### Environment Management

**direnv** (`direnv/.config/direnv/`):
- `direnvrc` - Smart auto-detection for Nix and asdf environments
- Loads nix-direnv for Nix integration
- `use_auto()` function: Tries Nix (flake.nix/shell.nix) first, falls back to asdf (.tool-versions)
- Enables gradual migration from asdf to Nix on per-directory basis

### Terminal Emulators

**Kitty** (`kitty/.config/kitty/`):
- `kitty.conf` - Monaco font 12pt, Dracula theme, powerline tabs, copy-on-select
- `keymap.conf` - Custom keyboard shortcuts
- `dracula.conf` - Dracula color theme
- `neighboring_window.py` - Window navigation script
- `pass_keys.py` - Key management script

**Ghostty** (`ghostty/.config/ghostty/`):
- `config` - Minimal config using Dracula theme

### Editor Configuration

**Vim** (`vim/`):
- `.vimrc` - Main configuration with Dracula theme, plugin management
- Plugins: fzf, NERDTree, vim-sensible, vim-fugitive, vim-tmux-navigator, coc.nvim
- Language support: Ruby, Go, Rust, JavaScript, Terraform
- Testing: vim-test with tslime integration
- `.vim/coc-settings.json` - Language server configuration

### Terminal Multiplexer

**TMux** (`tmux/.tmux.conf`):
- Prefix: `Ctrl-S` (not default Ctrl-B)
- Vi-mode keybindings
- Plugins: tpm, sensible, Dracula theme
- Mouse support enabled
- Copy integration with pbcopy (macOS)

### Git Configuration

**Git** (`git/`):
- `.gitconfig` - User settings, aliases, merge tools, context-specific configs
- `.gitignore_global` - Global ignore patterns
- `.git_template/hooks/` - Git hook templates (post-checkout, post-commit, post-merge, post-rewrite)
- Custom aliases: `mr` (merge request), `jump` (stash and checkout)

### Package Management

**Homebrew** (`brew/Brewfile`):
- 35+ packages including: asdf, fish, fzf, git, vim, htop, postgresql, redis
- GUI apps: VS Code, Docker, Firefox, Brave, Slack, Spotify, Rectangle, JetBrains Toolbox

**Mackup** (`mackup/.mackup.cfg`):
- Syncs GUI app configs via Dropbox
- Applications: VSCode, Atom, Xcode, IntelliJ, RubyMine, Terminal, iTerm2, Rectangle

## Main Setup Script: `up`

The `up` script is an executable bash script that orchestrates machine setup. It contains functions for:

1. `acceptXcodeLicense()` - Accepts Xcode license
2. `getLatestBrew()` - Installs/updates Homebrew
3. `brewInstall()` - Runs brew bundle
4. `stowDotfiles()` - Symlinks dotfiles with GNU stow
5. `mackupRestore()` - Restores GUI app configs
6. `initFish()` - Sets fish as default shell
7. `initAsdf()` - Initializes asdf plugins and installs language versions
8. `makeDirs()` - Creates `~/Dev/src` directory structure
9. `installTmuxPluginManager()` - Clones tpm
10. `setMacPreferences()` - Applies macOS system preferences

## Development Workflow

### Making Changes to Dotfiles

1. **Edit files directly** in their respective directories (e.g., `fish/.config/fish/config.fish`)
2. **Test changes** - Since files are symlinked, changes take effect immediately
3. **Commit changes** with descriptive messages
4. **Push to branch** - Always use branches starting with `claude/` and matching session ID

### Adding New Tool Configuration

1. Create a new directory named after the tool
2. Mirror the home directory structure inside it (e.g., `newtool/.config/newtool/config`)
3. Add configuration files
4. Update the `up` script if automated installation is needed
5. Document in README.md

### Testing Configuration Changes

**Shell configs**: Source the file or restart the shell
```bash
source ~/.bashrc
# or
exec fish
```

**Vim config**: Reload within Vim
```vim
:source ~/.vimrc
```

**TMux config**: Reload within tmux
```
Ctrl-S + I  (install plugins)
Ctrl-S + :source ~/.tmux.conf
```

## Key Conventions for AI Assistants

### File Editing Guidelines

1. **Preserve formatting**: Maintain existing indentation and style
2. **Keep comments**: Don't remove existing comments unless obsolete
3. **Match patterns**: Follow existing patterns (e.g., if aliases use `alias x='y'`, continue that style)
4. **Test compatibility**: Remember this is primarily macOS-focused (pbcopy, brew, etc.)

### Shell Script Conventions

- Use **bash** for scripts (not sh) - see `up` script
- Include error handling for critical operations
- Use functions for modularity
- Add descriptive comments for complex operations

### Configuration File Patterns

- **Fish shell**: Use fish syntax, not bash/sh
- **Vim**: Use vim-plug for plugin management
- **TMux**: Prefix is `Ctrl-S`, not default `Ctrl-B`
- **Theme consistency**: Dracula theme is used across all tools

### Common Aliases and Functions (from fish config)

```fish
# Git shortcuts
alias ga='git add'
alias gc='git commit'
alias gd='git diff'
alias gp='git push'
alias gl='git pull'
alias gst='git status'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'

# Custom functions
deletescreen <name>   # Delete tmux session
deletescreens         # Delete all tmux sessions except current
```

### Language Version Management

- **Always use asdf** for language version management
- Pin versions in `asdf/.tool-versions`
- Update `.default-gems` for Ruby gems that should be installed automatically
- Update `.default-npm-packages` for global npm packages

## Common Tasks

### Update Tool Versions

Edit `asdf/.tool-versions`:
```
ruby 3.2.0
nodejs 18.12.0
golang 1.19.3
```

Then run: `asdf install`

### Add Homebrew Package

Edit `brew/Brewfile`:
```ruby
brew "package-name"
# or for casks
cask "application-name"
```

Then run: `brew bundle install --file=brew/Brewfile`

### Add Vim Plugin

Edit `vim/.vimrc`, add to the plugin section:
```vim
Plug 'author/plugin-name'
```

Then in Vim: `:PlugInstall`

### Add Fish Plugin

Edit `fish/fish_plugins`:
```
author/plugin-name
```

Then run: `fisher update`

### Modify Git Configuration

Edit `git/.gitconfig` - changes take effect immediately due to symlink.

## Important Notes for AI Assistants

### Platform-Specific Considerations

- **macOS-centric**: Many configs assume macOS (pbcopy, brew, Rectangle app)
- **Path differences**: macOS uses `/Users/`, Linux uses `/home/`
- **Shell differences**: Fish syntax is NOT bash-compatible

### Symlink Awareness

Files in this repository are **symlinked** to the home directory. Editing them here changes the live configuration immediately. Be cautious with:
- Shell configs (could break active shell)
- Git config (affects all git operations)
- Editor configs (could make vim unusable)

### Security Considerations

- **Never commit secrets** (API keys, tokens, passwords)
- **Review before committing**: Check for sensitive paths, usernames, or system-specific info
- **Use git-crypt or similar** if secrets must be stored
- The `.gitignore` excludes common secret files

### Testing Recommendations

Before committing changes:
1. **Shell configs**: Open a new shell and verify it loads
2. **Vim configs**: Open vim and run `:checkhealth` (neovim) or verify plugins load
3. **TMux configs**: Start tmux and verify keybindings work
4. **Git configs**: Run `git config --list` to verify settings

### Backup Strategy

The repository itself IS the backup. Additional considerations:
- **Mackup**: Backs up GUI apps to Dropbox (configured in `mackup/.mackup.cfg`)
- **Git history**: Provides version control for all changes
- **Stow**: Makes it easy to restore by re-symlinking

## Git Workflow for AI Assistants

### Branch Naming
- Always use branches starting with `claude/`
- Branch must end with matching session ID
- Example: `claude/add-vim-plugin-abc123`

### Commit Messages
Follow conventional commit style:
```
feat: add fzf integration to fish config
fix: correct tmux prefix key binding
docs: update README with fish setup instructions
chore: update asdf tool versions
```

### Push Commands
Always use: `git push -u origin <branch-name>`

If network errors occur, retry up to 4 times with exponential backoff (2s, 4s, 8s, 16s).

### Pull Request Guidelines
- Title should be clear and descriptive
- Body should include:
  - What was changed
  - Why it was changed
  - How to test the changes
  - Any breaking changes or migration steps

## Debugging Common Issues

### Stow Conflicts
If stow reports conflicts:
1. Check if target file already exists in home directory
2. Backup existing file
3. Remove existing file
4. Re-run stow

### asdf Plugin Issues
If language version won't install:
1. Update asdf: `asdf update`
2. Update plugin: `asdf plugin update <language>`
3. Check asdf plugin repository for known issues

### Fish Plugin Issues
If fisher fails:
1. Reinstall fisher: `curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher`
2. Update plugins: `fisher update`

### TMux Plugin Manager Issues
If tpm won't install plugins:
1. Ensure tpm is cloned: `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
2. In tmux, press `Ctrl-S + I` (capital I) to install plugins

## File Locations Reference

When working with this repository, remember:

| Repository Path | Symlinked To | Active Config |
|----------------|--------------|---------------|
| `fish/.config/fish/config.fish` | `~/.config/fish/config.fish` | ✓ |
| `direnv/.config/direnv/direnvrc` | `~/.config/direnv/direnvrc` | ✓ |
| `git/.gitconfig` | `~/.gitconfig` | ✓ |
| `vim/.vimrc` | `~/.vimrc` | ✓ |
| `tmux/.tmux.conf` | `~/.tmux.conf` | ✓ |
| `bash/.bashrc` | `~/.bashrc` | ✓ |

Editing files in the repository directly modifies the active configuration.

## Additional Resources

- **Stow Manual**: https://www.gnu.org/software/stow/manual/stow.html
- **asdf Documentation**: https://asdf-vm.com/
- **Fish Shell Documentation**: https://fishshell.com/docs/current/
- **Vim-Plug Documentation**: https://github.com/junegunn/vim-plug
- **TMux Plugin Manager**: https://github.com/tmux-plugins/tpm

---

**Last Updated**: 2026-01-02
**Maintained By**: AI assistants should update this file when making significant changes to repository structure or conventions.
