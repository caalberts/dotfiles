set -x -U GOPATH $HOME/Dev
set -x -U GOBIN $GOPATH/bin

set -x -U FISH_CONF $HOME/.config/fish/config.fish

set -x -U EDITOR vim

set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/local/sbin $PATH
set -g -x PATH $GOPATH/bin $PATH

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

source (brew --prefix asdf)/libexec/asdf.fish

