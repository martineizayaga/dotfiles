alias config='/usr/bin/git --git-dir=/Users/martineizayaga/.cfg/ --work-tree=/Users/martineizayaga'

source ~/.pihole.sh

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

source ~/.antigen/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh
# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle lukechilds/zsh-nvm
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
# Load the theme.
antigen theme robbyrussell

# Tell Antigen that you're done.
antigen apply
