# Adapted from https://github.com/fish-shell/fish-shell/issues/4434#issuecomment-332626369
# only run in interactive (not automated SSH for example)
if status is-interactive
    # don't nest inside another tmux
    and not set -q TMUX
    # Adapted from https://unix.stackexchange.com/a/176885/347104
    # Create session 'main' or attach to 'main' if already exists.
    tmux new-session -A -s main
end

# asdf version manager
if test -e ~/.asdf/asdf.fish
    source ~/.asdf/asdf.fish
end

# pipx
set PATH $PATH ~/.local/bin

# thefuck
thefuck --alias | source

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

alias j='z' # cd, same functionality as j in autojump

#aliases
alias gc='git commit --verbose'
alias gcm='git commit --message'
alias gcam='git commit --all --message'
alias gca='git commit --amend'

alias gbc='git checkout -b'
alias gb='git branch'
alias gbbm='git checkout master'

alias gF='git pull'

alias gp-f='git push --force'
alias gp='git push'

alias gs='git status'

alias git-clean="git remote prune origin; git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"

# tmux
function fs -d "Switch tmux session"
    tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

# bobthefish
set -g theme_color_scheme solarized-dark
set -g theme_nerd_fonts yes


set -gx GOPATH ~/data/programming/go
set -gx PATH $PATH $GOPATH/bin
set -gx PATH $PATH $HOME/data/applications
set -gx PATH $PATH $HOME/bin
set -gx PATH $PATH $HOME/.emacs.d/bin


# flatpak
set -l xdg_data_home $XDG_DATA_HOME ~/.local/share
set -gx --path XDG_DATA_DIRS $xdg_data_home[1]/flatpak/exports/share:/var/lib/flatpak/exports/share:/usr/local/share:/usr/share

for flatpakdir in ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    if test -d $flatpakdir
        contains $flatpakdir $PATH; or set -a PATH $flatpakdir
    end
end
