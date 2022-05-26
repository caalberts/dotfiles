[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -s "/Users/albert/.jabba/jabba.sh" ] && source "/Users/albert/.jabba/jabba.sh"

# Added by GDK bootstrap
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Added by GDK bootstrap
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1 --with-readline-dir=/usr/local/opt/readline"

complete -C /Users/albert/.asdf/installs/terraform/0.15.4/bin/terraform terraform

# Added by GDK bootstrap
source /usr/local/Cellar/asdf/0.8.1_1/libexec/asdf.sh
