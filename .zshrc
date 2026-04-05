# Homebrew
export PATH="/opt/homebrew/bin:$PATH"

### Zinit
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

# Plugins
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light-mode for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-completions \
    sindresorhus/pure

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

# Aliases
alias ls='eza -1 --group-directories-first --show-symlinks'
alias la='ls -a'
alias ll='ls -ln --total-size --octal-permissions --no-permissions --time-style relative --smart-group'
alias lla='ll -a'
alias lt='ll --tree'
alias lta='lt -a'
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# zmx
if [[ -n $ZMX_SESSION ]]; then
  export PS1="%F{cyan}$ZMX_SESSION%f ${PS1}"
fi

_zmx_switch_by_index() {
  local idx=$1
  local session
  session=$(zmx l --short 2>/dev/null | awk -F'[\t=]' -v n="$idx" 'NR==n{print $2}')
  if [[ -n "$session" ]]; then
    BUFFER="zmx a $session"
    zle accept-line
  fi
}

for i in {1..9}; do
  eval "zmx-switch-$i() { _zmx_switch_by_index $i; }"
  zle -N "zmx-switch-$i"
  bindkey "\e[$((48+i));5u" "zmx-switch-$i"
done

zmx-list() { BUFFER="zmx l"; zle accept-line; }
zle -N zmx-list
bindkey "\e[48;5u" zmx-list

# Kitty keyboard protocol reset
autoload -Uz add-zsh-hook
_reset_kitty_keyboard_protocol() {
  printf '\e[<u'
}
add-zsh-hook precmd _reset_kitty_keyboard_protocol
