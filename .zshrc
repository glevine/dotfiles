# Homebrew
if command -v brew &>/dev/null; then
    # Traditional installation.
    eval "$(brew shellenv)"
elif command -v /opt/homebrew/bin/brew &>/dev/null; then
    # M1 installation.
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if command -v brew &>/dev/null; then
    # source: https://formulae.brew.sh/formula/zsh-completions
    fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" "$HOMEBREW_PREFIX/share/zsh-completions" $fpath)

    # source: https://github.com/Homebrew/homebrew-command-not-found
    HB_CNF_HANDLER=$HOMEBREW_REPOSITORY/Library/Taps/homebrew/homebrew-command-not-found/handler.sh

    if [ -f "$HB_CNF_HANDLER" ]; then
        source "$HB_CNF_HANDLER"
    fi
fi

# oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(aws colored-man-pages command-not-found common-aliases copybuffer copypath copyfile fzf last-working-dir per-directory-history screen timer urltools wd volta zsh-interactive-cd)

source $ZSH/oh-my-zsh.sh

# Add custom locations to $PATH.
export PATH="$HOME/bin:$HOME/.machine/bin:$PATH"

# Use code to launch Visual Studio Code.
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
export EDITOR="code"

# Colors
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

# Don't require escaping globbing characters in zsh.
unsetopt nomatch

# Aliases
USER_ALIASES=$HOME/.aliases

if [ -f "$USER_ALIASES" ]; then
    source "$USER_ALIASES"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# multiverse
export PATH="$HOME/github.com/sugarcrm/multiverse/tools/bin:$PATH"
source $HOME/github.com/sugarcrm/multiverse/tools/complete.bash

# openssl
if command -v brew &>/dev/null; then
    export PATH="$(brew --prefix openssl)/bin:$PATH"
    export LDFLAGS="-L$(brew --prefix openssl)/lib"
    export CPPFLAGS="-I$(brew --prefix openssl)/include"
    export PKG_CONFIG_PATH="$(brew --prefix openssl)/lib/pkgconfig"
fi

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv &>/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

if command -v pyenv-virtualenv-init &>/dev/null; then
    eval "$(pyenv virtualenv-init -)"
fi

# thefuck
if command -v thefuck &>/dev/null; then
    eval "$(thefuck --alias)"
fi

# volta
export VOLTA_HOME=$HOME/.volta
export PATH="$VOLTA_HOME/bin:$PATH"

# All the zsh extensions should be last.
# zsh-syntax-highlighting must be at the end but zsh-history-substring-search must come after zsh-syntax-highlighting.
# source: https://github.com/zsh-users/zsh-syntax-highlighting
# source: https://github.com/zsh-users/zsh-history-substring-search
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Allow history search via up/down keys.
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
