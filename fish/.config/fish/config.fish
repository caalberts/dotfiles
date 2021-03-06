set -x -U GOPATH $HOME/Dev
set -x -U GOBIN $GOPATH/bin

set -x -U FISH_CONF $HOME/.config/fish/config.fish

set -x -U GDK $HOME/Dev/gdk

set -x -U EDITOR vim

set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/local/sbin $PATH
set -g -x PATH $GOPATH/bin $PATH

set -g -x GO111MODULE on

set -g -x LC_ALL en_US.UTF-8

if functions -q bass
  bass source ~/.profile
  bass source ~/.bash_profile
end

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

function ll
  ls -al $argv
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/albert/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/albert/google-cloud-sdk/path.fish.inc'; else; . '/Users/albert/google-cloud-sdk/path.fish.inc'; end; end

source /usr/local/opt/asdf/asdf.fish

function __not_inside_tmux
  [ -z "$TMUX" ]
end

function ensure_tmux_is_running
  if __not_inside_tmux
    taf
  end
end

# ensure_tmux_is_running


[ -s "/Users/albert/.jabba/jabba.fish" ]; and source "/Users/albert/.jabba/jabba.fish"
