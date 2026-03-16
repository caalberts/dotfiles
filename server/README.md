# Home Server Dotfiles

Configuration for a long-running Ubuntu Server dev machine, accessed via SSH from a MacBook.

## What's Included

- **Fish shell** with aliases, direnv, fzf, zoxide
- **tmux** with Dracula theme, vim-tmux-navigator, persistent SSH agent across reconnects
- **vim** with vim-plug, NERDTree, fzf, vim-tmux-navigator, coc.nvim, language plugins
- **asdf** for language version management (Go, Python, Ruby, Node.js, Rust)
- **direnv** for per-directory environment switching
- **git** configured for SSH commit signing via forwarded SSH agent
- **Homebrew (Linux)** for package management

## First-Time Setup

### 1. Enable SSH Agent Forwarding (on your MacBook — do this first)

Before cloning or running setup on the server, ensure your MacBook is configured
to forward the SSH agent. Without this, git clone and commit signing won't work.

Add to `~/.ssh/config` on your **MacBook**:

```
Host home-server
    HostName <server-ip-or-hostname>
    User <your-username>
    ForwardAgent yes
```

Then reconnect: `ssh home-server`

Verify the agent is forwarded:
```bash
# On the server — should list your keys
ssh-add -L
```

### 2. Fresh Ubuntu Server

```bash
# Install git if not present
sudo apt-get install -y git

# Clone dotfiles via SSH (uses the forwarded agent from your MacBook)
git clone git@github.com:caalberts/dotfiles.git ~/dotfiles
cd ~/dotfiles/server

# Run setup
./up
```

### 3. Git Commit Signing

Git is configured to sign commits using SSH. The public key is embedded inline in
`git/.gitconfig` (with a placeholder). The private key stays on your laptop; git
uses the forwarded SSH agent to sign.

**One-time setup:**

```bash
# 1. On your MacBook, get your public key from the agent
ssh-add -L
# Outputs something like: ssh-ed25519 AAAAC3... your-key-comment

# 2. In server/git/.gitconfig, replace the placeholder:
#    signingKey = key::ssh-ed25519 AAAA_REPLACE_WITH_YOUR_PUBLIC_KEY your-key-comment
#    with the actual output from ssh-add -L above

# 3. On the server, create the allowed signers file for verification
echo "you@example.com $(ssh-add -L | head -1)" >> ~/.ssh/allowed_signers

# 4. Set your git email (not committed to dotfiles)
git config --global user.email "you@example.com"
```

### 4. Post-Setup Steps

After `./up` completes and you restart the shell:

```bash
# Install tmux plugins (inside a tmux session)
tmux
# then press: Ctrl-S + I

# Install vim plugins
vim +PlugInstall +qall

# Install Claude Code (requires Node.js via asdf)
npm install -g @anthropic-ai/claude-code
```

## How SSH Agent Forwarding Works Across tmux Sessions

The key challenge: each SSH login creates a new `SSH_AUTH_SOCK` path, but existing tmux sessions still reference the old (broken) path.

**Solution:**

1. On each SSH login, `config.fish` (and `.profile`) creates a symlink:
   ```
   ~/.ssh/auth_sock -> /tmp/ssh-XXX/agent.YYY  (the real socket)
   ```
2. `tmux.conf` sets `SSH_AUTH_SOCK` to point at `~/.ssh/auth_sock` (the stable symlink).
3. When you SSH in again, the symlink is updated to the new socket — all tmux panes automatically get a working agent.

**Result:** `git clone git@github.com:...`, `git commit` (with signing), and `ssh` all work inside tmux, even after reconnecting.

## Typical Workflow

```
# On MacBook
ssh home-server

# On server
tmux new-session -s main    # or: tmux attach -t main

# Inside tmux
git clone git@github.com:caalberts/my-project
cd my-project
claude                       # start Claude Code
# edit, commit (commits are signed), push

# Detach from tmux (session keeps running)
Ctrl-S d

# Exit SSH
exit

# Later, reconnect
ssh home-server
tmux attach -t main          # SSH_AUTH_SOCK symlink is updated, agent works
```

## Key Bindings

### tmux (prefix: `Ctrl-S`)

| Key | Action |
|-----|--------|
| `Ctrl-S d` | Detach session |
| `Ctrl-S c` | New window |
| `Ctrl-S \|` | Split horizontally |
| `Ctrl-S \\` | Split vertically |
| `Ctrl-S h/j/k/l` | Navigate panes |
| `Ctrl-S [` | Enter copy mode |
| `Ctrl-S r` | Reload tmux config |
| `Ctrl-S I` | Install plugins |

### vim (leader: `Space`)

| Key | Action |
|-----|--------|
| `Ctrl-T` | FZF file search |
| `Space e` | Toggle NERDTree |
| `Space vr` | Edit .vimrc |
| `tCtrl-n` | Run nearest test |
| `tCtrl-f` | Run test file |
| `Ctrl-H/J/K/L` | Navigate to tmux pane |

## Directory Structure

```
server/
├── asdf/           # .asdfrc, .tool-versions
├── brew/           # Brewfile (Linux-compatible packages)
├── direnv/         # direnvrc (asdf integration, layout_tmux)
├── fish/           # config.fish
├── git/            # .gitconfig, .gitignore_global
├── profile/        # .profile (for bash/login shells)
├── ssh/            # SSH client config
├── tmux/           # .tmux.conf
├── vim/            # .vimrc
├── up              # Setup script
└── README.md       # This file
```

## Stowing Individual Packages

```bash
cd ~/dotfiles/server
stow -t ~ fish        # stow just fish config
stow -t ~ tmux        # stow just tmux config
```
