[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -s "$HOME/.jabba/jabba.sh" ] && source "$HOME/.jabba/jabba.sh"

# Cross-platform clipboard aliases (Linux compatibility)
if ! command -v pbcopy &> /dev/null; then
  if command -v xclip &> /dev/null; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
  elif command -v xsel &> /dev/null; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

# Added by GDK bootstrap
export PKG_CONFIG_PATH="$(brew --prefix icu4c)/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Added by GDK bootstrap
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1) --with-readline-dir=$(brew --prefix readline)"

# Terraform completion (uses terraform from PATH, managed by asdf)
command -v terraform &>/dev/null && complete -C terraform terraform

# Added by GDK bootstrap
source $(brew --prefix asdf)/libexec/asdf.sh
