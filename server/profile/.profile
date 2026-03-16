# ~/.profile - sourced by bash login shells

# Homebrew (Linux)
if [ -d "/home/linuxbrew/.linuxbrew" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -d "$HOME/.linuxbrew" ]; then
  eval "$($HOME/.linuxbrew/bin/brew shellenv)"
fi

# SSH agent socket persistence for tmux sessions
# Symlinks the current session's socket to a fixed path so tmux can find it
if [ -n "$SSH_AUTH_SOCK" ] && [ "$SSH_AUTH_SOCK" != "$HOME/.ssh/auth_sock" ]; then
  ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/auth_sock"
  export SSH_AUTH_SOCK="$HOME/.ssh/auth_sock"
fi
