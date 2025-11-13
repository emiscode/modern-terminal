# Custom zsh functions

# fzf-based file finder
fzf-file() {
    local file
    file=$(fzf --preview 'bat --color=always {}' --height 40% --reverse)
    [ -n "$file" ] && nvim "$file"
}
alias ff='fzf-file'

# fzf-based directory finder
fzf-dir() {
    local dir
    dir=$(find ${1:-.} -type d 2>/dev/null | fzf --height 40% --reverse)
    [ -n "$dir" ] && cd "$dir"
}
alias fdir='fzf-dir'

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick file search with ripgrep
rgf() {
    rg -l "$1" | fzf --preview "rg --color=always -n '$1' {}"
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Weather function (requires curl)
weather() {
    curl -s "wttr.in/${1:-}?format=3"
}

