set -x -U GOPATH $HOME/Dev
set -x -U GOBIN $GOPATH/bin

set -x -U FISH_CONF $HOME/.config/fish/config.fish

set -x -U EDITOR vim

set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/local/sbin $PATH
set -g -x PATH $GOPATH/bin $PATH
set -g -x PATH $HOME/.cargo/bin $PATH

set -g -x GO111MODULE on

set -g -x LC_ALL en_US.UTF-8

# Initialize Homebrew (Linux)
if test -x /home/linuxbrew/.linuxbrew/bin/brew
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else if test -x ~/.linuxbrew/bin/brew
  eval "(~/.linuxbrew/bin/brew shellenv)"
end

# SSH agent socket persistence for tmux sessions
# Each SSH login creates a new socket path; this symlink keeps a stable path
# tmux.conf points SSH_AUTH_SOCK at this symlink so it works across reconnects
if test -n "$SSH_AUTH_SOCK" -a "$SSH_AUTH_SOCK" != "$HOME/.ssh/auth_sock"
  ln -sf $SSH_AUTH_SOCK $HOME/.ssh/auth_sock
  set -gx SSH_AUTH_SOCK $HOME/.ssh/auth_sock
end

# asdf version manager
if test -f (brew --prefix asdf)/libexec/asdf.fish
  source (brew --prefix asdf)/libexec/asdf.fish
end

# direnv
direnv hook fish | source
set -g direnv_fish_mode disable_arrow

# fzf
if command -v fzf > /dev/null
  fzf --fish | source
end

# zoxide (smart cd)
if command -v zoxide > /dev/null
  zoxide init fish | source
end

# Aliases
alias v "vim"
alias gcm "git checkout master"
alias gf "git fetch"
alias gfr "git fetch; and git rebase"
alias gp "git pull"
alias gpr "git pull -r"
alias gpf "git push --force"
alias glo "git log --oneline"
alias gg "git grep"

function git_branch_delete_merged
  git branch --merged | grep -v master | xargs git branch -d
end

function ll
  ls -al $argv
end

# Auto-exec into tmux after direnv sets environment variables
function __direnv_tmux_auto --on-event fish_prompt
  if not set -q DIRENV_TMUX_SESSION
    return
  end

  if set -q TMUX
    set -e DIRENV_TMUX_SESSION
    set -e DIRENV_TMUX_TYPE
    set -e DIRENV_TMUX_CONFIG
    return
  end

  set -l session_name $DIRENV_TMUX_SESSION
  set -l tmux_type $DIRENV_TMUX_TYPE

  set -e DIRENV_TMUX_SESSION
  set -e DIRENV_TMUX_TYPE
  set -e DIRENV_TMUX_CONFIG

  switch $tmux_type
    case "custom_config"
      if tmux has-session -t $session_name 2>/dev/null
        tmux -f .tmux.conf attach-session -t $session_name
      else
        tmux -f .tmux.conf new-session -s $session_name
      end
    case "basic"
      if tmux has-session -t $session_name 2>/dev/null
        tmux attach-session -t $session_name
      else
        tmux new-session -s $session_name
      end
  end
end
