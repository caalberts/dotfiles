set -x -U GOPATH $HOME/Dev/go
set -x -U GOBIN $GOPATH/bin

set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/local/sbin $PATH
set -g -x PATH $GOPATH/bin $PATH

set -g -x GO111MODULE on

bass source ~/.profile
bass source ~/.bash_profile

alias v "vim"

function ll
    ls -al $argv
end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/albert/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/albert/google-cloud-sdk/path.fish.inc'; else; . '/Users/albert/google-cloud-sdk/path.fish.inc'; end; end

source ~/.asdf/asdf.fish