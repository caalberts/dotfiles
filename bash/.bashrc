[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -s "/Users/albert/.jabba/jabba.sh" ] && source "/Users/albert/.jabba/jabba.sh"

# Added by GDK bootstrap
export PKG_CONFIG_PATH="$(brew --prefix icu4c)/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Added by GDK bootstrap
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline)"

complete -C /Users/albert/.asdf/installs/terraform/0.15.4/bin/terraform terraform

# Added by GDK bootstrap
source $(brew --prefix asdf)/libexec/asdf.sh
