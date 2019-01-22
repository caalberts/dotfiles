set -x -U GOPATH $HOME/Dev
set -x -U GOBIN $GOPATH/bin

set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/local/sbin $PATH
set -g -x PATH $GOPATH/bin $PATH

set -g -x GO111MODULE on

if functions -q bass
  bass source ~/.profile
  bass source ~/.bash_profile
end

alias v "vim"

function ll
    ls -al $argv
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/albert/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/albert/google-cloud-sdk/path.fish.inc'; else; . '/Users/albert/google-cloud-sdk/path.fish.inc'; end; end

source ~/.asdf/asdf.fish

fish_vi_key_bindings
