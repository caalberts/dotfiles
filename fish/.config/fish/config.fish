set -x -U GOPATH $HOME/Dev
set -x -U GOBIN $GOPATH/bin

set -x -U FISH_CONF $HOME/.config/fish/config.fish

set -x -U EDITOR vim

set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/local/sbin $PATH
set -g -x PATH $GOPATH/bin $PATH
set -g -x PATH $HOME/.cargo/bin $PATH
set -g -x PATH $HOME/Library/Application\ Support/JetBrains/Toolbox/scripts/ $PATH

set -g -x GPG_TTY $(tty)

set -g -x GO111MODULE on

set -g -x LC_ALL en_US.UTF-8

# Set hydro theme colours
set --global hydro_color_pwd $fish_color_quote
set --global hydro_color_git $fish_color_normal

if functions -q bass
  bass source ~/.profile
  bass source ~/.bash_profile
end

eval "$(/opt/homebrew/bin/brew shellenv)"

alias v "vim"
alias gcm "git checkout master"
alias gf "git fetch"
alias gfr "git fetch; and git rebase"
alias gp "git pull"
alias gpr "git pull -r"
alias gpf "git push --force"
alias glo "git log --oneline"
alias gg "git grep"
alias grdb "git restore db/structure.sql db/schema.rb"

function git_branch_delete_merged
  git branch --merged | grep -v master | xargs git branch -d
end

function delete_screenshots
  find ~/Desktop/ -name "Screenshot*" -exec rm {} \+
end

function ll
  ls -al $argv
end


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/albert/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/albert/google-cloud-sdk/path.fish.inc'; else; . '/Users/albert/google-cloud-sdk/path.fish.inc'; end; end

direnv hook fish | source

set -g direnv_fish_mode disable_arrow

# Auto-exec into tmux after direnv sets environment variables
# This runs after each prompt is displayed
function __direnv_tmux_auto --on-event fish_prompt
  # Skip if no tmux trigger set
  if not set -q DIRENV_TMUX_SESSION
    return
  end

  # Skip if already in tmux (safety check)
  if set -q TMUX
    set -e DIRENV_TMUX_SESSION
    set -e DIRENV_TMUX_TYPE
    set -e DIRENV_TMUX_CONFIG
    return
  end

  # Get session name and type
  set -l session_name $DIRENV_TMUX_SESSION
  set -l tmux_type $DIRENV_TMUX_TYPE

  # Clear variables before exec (they'll be set again when tmux shell loads)
  set -e DIRENV_TMUX_SESSION
  set -e DIRENV_TMUX_TYPE
  set -e DIRENV_TMUX_CONFIG

  # Execute based on type (without exec so shell remains after tmux exits)
  switch $tmux_type
    case "tmuxinator"
      tmuxinator start -p .tmuxinator.yml
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

source (brew --prefix asdf)/libexec/asdf.fish

zoxide init fish | source
fish_add_path /opt/homebrew/opt/curl/bin
