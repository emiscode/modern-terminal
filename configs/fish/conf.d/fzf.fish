# fzf integration for Fish
# Install fzf key bindings if available

if command -v fzf &> /dev/null
    # fzf key bindings
    if test -f ~/.fzf.fish
        source ~/.fzf.fish
    end
end

