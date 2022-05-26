# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/albert/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/albert/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/albert/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/albert/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export PATH="/usr/local/opt/postgresql@10/bin:$PATH"
# export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"

[ -s "/Users/albert/.jabba/jabba.sh" ] && source "/Users/albert/.jabba/jabba.sh"

. $(brew --prefix asdf)/libexec/asdf.sh
