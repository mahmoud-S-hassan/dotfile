
function nvims() {
    items=("default" "kickstart" "DEVASLIFE" "LazyVim" "NvChad" "AstroNvim" "nvimGrim" "nvimgg")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config=""
    fi
    NVIM_APPNAME=$config nvim $@
}
bindkey -s '^[a' "nvims\n"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



gcop() {
    git log \
        --reverse \
        --color=always \
        --format="%C(cyan)%h %C(blue)%ar%C(auto)%d \
        %C(yellow)%s%+b %C(black)%ae" "$@" |
    fzf -i -e +s \
        --reverse \
        --tiebreak=index \
        --no-multi \
        --ansi \
        --preview="echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'" \
        --header "enter: view, C-c: copy hash" \
        --bind "enter:execute:_viewGitLogLine {} | less -R" \
        --bind "ctrl-c:execute:_gitLogLineToHash {} | xclip -r -selection clipboard"
}

_viewGitLogLine() {
    local commit_hash="$1"
    git show --color=always "$commit_hash" | less -r
}

_gitLogLineToHash() {
    local commit_line="$1"
    local commit_hash=$(echo "$commit_line" | grep -o '[a-f0-9]\{7\}' | head -1)
    echo "$commit_hash" | xclip -r -selection clipboard
}

#-----------------------------------------------------------------------------#
# Function to handle directory changes using fzf
function _fzf_change_directory {
    local foo
    foo=$(printf "%s\n" "${directories[@]}" | fzf --prompt="🗂 Select Directory → " --height=50% --layout=reverse --border --exit-0)
    if [ "$foo" ]; then
        builtin cd "$foo"
    fi
}

# Main function to list and navigate directories using fzf
function fzf_change_directory {
    local directories
    directories=($(echo "$HOME/.config"
        # Check if ghq root exists or remove this line if not needed
        [ -d "$(ghq root)" ] && find "$(ghq root)" -maxdepth 4 -type d -name .git | sed 's/\/\.git//'
        ls -ad */ | perl -pe "s#^#$PWD/#" | grep -v \.git
        # Check if Developments exists and contains directories
        if [ -d "$HOME/Developments" ]; then
            ls -ad $HOME/Developments/*/* | grep -v \.git
        fi
    ))

    if [ ${#directories[@]} -eq 0 ]; then
        echo "No directories found!"
        return
    fi

    _fzf_change_directory
}

