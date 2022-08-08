# Homebrew
if command -v brew &>/dev/null; then
    # Traditional installation.
    eval "$(brew shellenv)"
elif command -v /opt/homebrew/bin/brew &>/dev/null; then
    # M1 installation.
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# source: https://formulae.brew.sh/formula/zsh-completions
fpath=("$HOMEBREW_PREFIX/share/zsh/site-functions" "$HOMEBREW_PREFIX/share/zsh-completions" $fpath)

# source: https://github.com/Homebrew/homebrew-command-not-found
HB_CNF_HANDLER=$HOMEBREW_REPOSITORY/Library/Taps/homebrew/homebrew-command-not-found/handler.sh

if [ -f "$HB_CNF_HANDLER" ]; then
    source "$HB_CNF_HANDLER"
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

# Use GNU tools without the "g" prefix.
# source: https://formulae.brew.sh/formula/coreutils
# source: https://formulae.brew.sh/formula/findutils
# source: https://formulae.brew.sh/formula/gnu-sed
export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
export PATH="$HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"

# Aliases
USER_ALIASES=$HOME/.aliases

if [ -f "$USER_ALIASES" ]; then
    source "$USER_ALIASES"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# openssl
export PATH="$HOMEBREW_PREFIX/opt/openssl/bin:$PATH"
export LDFLAGS="-L$HOMEBREW_PREFIX/opt/openssl/lib"
export CPPFLAGS="-I$HOMEBREW_PREFIX/opt/openssl/include"
export PKG_CONFIG_PATH="$HOMEBREW_PREFIX/opt/openssl/lib/pkgconfig"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv &>/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# thefuck
eval "$(thefuck --alias)"

# volta
export VOLTA_HOME=$HOME/.volta
export PATH="$VOLTA_HOME/bin:$PATH"

# Add multiverse tools to the PATH as late as possible.
if [ -d "$HOME/github.com/sugarcrm/multiverse" ]; then
    export PATH="$HOME/github.com/sugarcrm/multiverse/tools/bin:$PATH"

    # kubectl
    source <(kubectl completion zsh)

    # skaffold zsh-completions are not available in skaffold@0.21.1
    # source <(skaffold completion zsh)

    # kubectx completions are not included in the tarball that multiverse downloads.
    # kubens completions are not included in the tarball that multiverse downloads.
fi

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
