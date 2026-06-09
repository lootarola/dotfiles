### Package Managers

# homebrew
export PATH="/opt/homebrew/bin:$PATH"

### Plugins

# zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light-mode for \
    sindresorhus/pure \
    zsh-users/zsh-autosuggestions \
    Aloxaf/fzf-tab

### zoxide
eval "$(zoxide init zsh)"

### fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout reverse
  --border sharp
  --prompt '❯ '
  --pointer '▶'
  --marker '✓'
  --color 'fg:#c0caf5,bg:#1a1b26,hl:#bb9af7,fg+:#c0caf5,bg+:#283457,hl+:#bb9af7,info:#7dcfff,prompt:#7aa2f7,pointer:#7dcfff,marker:#9ece6a,border:#3b4261'
"

# History
fh() {
  print -z $(history | awk '{$1=""; print substr($0,2)}' | fzf --tac --no-sort)
}

fhe() {
  eval $(history | awk '{$1=""; print substr($0,2)}' | fzf --tac --no-sort)
}

# docker
dsh() {
  docker exec -it $(docker ps --format '{{.Names}}' | fzf) sh
}
alias drmi='docker rmi $(docker images --format "{{.Repository}}:{{.Tag}}" | fzf -m)'
alias dst='docker stop $(docker ps --format "{{.Names}}" | fzf)'

# podman
psh() {
  podman exec -it $(podman ps --format '{{.Names}}' | fzf) sh
}
alias prmi='podman rmi $(podman images --format "{{.Repository}}:{{.Tag}}" | fzf -m)'
alias pst='podman stop $(podman ps --format "{{.Names}}" | fzf)'

# Files
alias fn="nvim \$(fzf --preview 'bat --color=always {}')"
alias fcd='cd $(find . -type d | fzf)'
alias zf='cd $(zoxide query -l | fzf --preview "ls {}")'
fln() {
  local result
  result=$(rg --line-number --no-heading "" \
    | fzf --delimiter=: \
          --preview 'bat --color=always {1} --highlight-line {2}' \
          --preview-window 'right:50%')
  [ -n "$result" ] && nvim $(echo "$result" | cut -d: -f1) \
    +$(echo "$result" | cut -d: -f2)
}
fgd() {
  if [ $# -ne 2 ]; then
    echo "Usage: fgd <ref1> <ref2>"
    return 1
  fi
  local commit
  commit=$(git log --oneline "$1".."$2" | fzf \
    --preview "git show {1} --stat --color=always")
  [ -n "$commit" ] && git show $(echo "$commit" | awk '{print $1}')
}

# Git
alias fgc='git checkout $(git branch | fzf)'
alias fga='git add $(git ls-files -m -u | fzf -m | xargs)'
fgl() {
  local commit
  commit=$(git log --oneline | fzf --preview "git show {1} --stat --color=always")
  [ -n "$commit" ] && git show $(echo "$commit" | awk '{print $1}')
}

# Processes
alias fkill='kill -9 $(ps aux | fzf | awk "{print \$2}")'
alias fport='lsof -i | fzf'

# Manual
alias fman='man $(man -k . | fzf | awk "{print \$1}")'

# ssh
fssh() {
  local host
  host=$(grep -i "^Host " ~/.ssh/config | awk '{print $2}' | fzf)
  [ -n "$host" ] && ssh "$host"
}

# env
alias fenv='env | fzf | cut -d= -f2 | pbcopy'
funset() {
  local var
  var=$(env | fzf | cut -d= -f1)
  [ -n "$var" ] && unset "$var" && echo "Unset $var"
}

### eza
alias ls='eza -1 --group-directories-first --show-symlinks'
alias la='ls -a'
alias ll='ls -ln --total-size --octal-permissions --no-permissions --time-style relative --smart-group'
alias lla='ll -a'
alias lt='ll --tree'
alias lta='lt -a'

### General
export PATH="$HOME/.local/bin:$PATH"

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# History
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt APPENDHISTORY
setopt SHAREHISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

