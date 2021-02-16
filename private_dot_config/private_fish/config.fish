if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
    fish -c fisher
end

# asdf version manager
source ~/.asdf/asdf.fish

# thefuck
thefuck --alias | source 

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

#fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias j='fasd_cd -d'     # cd, same functionality as j in autojump

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

function _fnm_autoload_hook --on-variable PWD --description 'Change Node version on directory change'
    status --is-command-substitution; and return
    if test -f .node-version
        echo "fnm: Found .node-version"
        fnm use
    else if test -f .nvmrc
        echo "fnm: Found .nvmrc"
        fnm use
    end
end

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

# fnm
fnm env | source
set -gx NODE_PATH (npm root -g)
