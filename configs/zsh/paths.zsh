# Path configuration
# Add custom paths here

# Homebrew (Apple Silicon)
if [[ $(uname -m) == "arm64" ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
fi

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Go (if installed)
[ -d "$HOME/go/bin" ] && export PATH="$HOME/go/bin:$PATH"

# Rust (if installed)
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# Python (pyenv)
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# Node.js (asdf)
if command -v asdf &> /dev/null; then
    . $(brew --prefix asdf)/libexec/asdf.sh
fi

