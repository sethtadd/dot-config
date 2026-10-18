# ── Colors ────────────────────────────────────────────────────────────
autoload -U colors && colors

# ── Prompt (replicates OMZ "simple" theme) ────────────────────────────
setopt prompt_subst

_git_prompt() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null) || return
  local indicator
  if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
    indicator=" %{$fg[red]%}✗"
  else
    indicator=" %{$fg[green]%}✔"
  fi
  echo " %B%{$fg[blue]%}(${branch}${indicator}%B%{$fg[blue]%})"
}

PROMPT='%(!.%{$fg[red]%}.%{$fg[green]%})%~$(_git_prompt)%{$reset_color%} '

# ── Completion ────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit
zmodload -i zsh/complist

unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USERNAME -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/compcache"

# ── History ───────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# ── Key bindings ──────────────────────────────────────────────────────
bindkey -e

# Up/Down arrow: prefix search (type "git" then Up filters to "git" commands)
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
[[ -n "${terminfo[kcuu1]}" ]] && bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
[[ -n "${terminfo[kcud1]}" ]] && bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# Ctrl+Arrow: word jumping
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# Home/End/Delete
[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" beginning-of-line
[[ -n "${terminfo[kend]}" ]]  && bindkey "${terminfo[kend]}"  end-of-line
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" delete-char

# Ctrl+R: history search
bindkey '^r' history-incremental-search-backward

# Ctrl+X Ctrl+E: edit command in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# ── Terminal title (replicates OMZ termsupport) ───────────────────────
autoload -Uz add-zsh-hook

function _set_title {
  case "$TERM" in
    xterm*|putty*|rxvt*|konsole*|ansi|mlterm*|alacritty*|st*|foot*|contour*|wezterm*)
      print -Pn "\e]2;${2:q}\a"
      print -Pn "\e]1;${1:q}\a"
      ;;
    screen*|tmux*)
      print -Pn "\ek${1:q}\e\\"
      ;;
  esac
}

function _title_precmd  { _set_title "%15<..<%~%<<" "%n@%m:%~" }
function _title_preexec {
  local CMD="${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}"
  local LINE="${2:gs/%/%%}"
  _set_title "$CMD" "%100>...>${LINE}%<<"
}

add-zsh-hook precmd  _title_precmd
add-zsh-hook preexec _title_preexec

# ── ls colors ─────────────────────────────────────────────────────────
alias ls='ls --color=auto'

# ── Git aliases ───────────────────────────────────────────────────────
alias ga='git add'
alias gb='git branch'
alias gc='git commit --verbose'
alias gd='git diff'
alias gl='git pull'
alias glo='git log --oneline --decorate'
alias gp='git push'
alias gsw='git switch'
alias gst='git status'
alias gwt='git worktree'

# ── Aliases & functions ───────────────────────────────────────────────
source ~/.bash_aliases

# ── Environment ───────────────────────────────────────────────────────
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:$HOME/Repos/zk"
export PATH="$PATH:$HOME/.local/bin"

export TERMINAL=alacritty
export EDITOR='nvim'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# OpenCode
export PATH="$HOME/.opencode/bin:$PATH"

# Bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ── Functions ─────────────────────────────────────────────────────────
record-screen() {
  local audio_mode="${1:-system}"
  local out="${2:-$HOME/Videos/rec-$(date +%F_%H-%M-%S).mp4}"
  local size source

  size=$(xrandr --current | sed -n 's/.*current \([0-9][0-9]*\) x \([0-9][0-9]*\).*/\1x\2/p')
  if [[ -z "$size" ]]; then
    printf "Could not detect screen size from xrandr\n" >&2
    return 1
  fi

  case "$audio_mode" in
    system)
      source=$(ffmpeg -hide_banner -sources pulse 2>/dev/null | sed -n 's/^ *\*\? *\([^ ]*\.monitor\).*/\1/p' | head -n 1)
      [[ -z "$source" ]] && source="default"
      ;;
    mic)
      source=$(ffmpeg -hide_banner -sources pulse 2>/dev/null | sed -n '/\.monitor/! s/^ *\*\? *\([^ ]*\).*/\1/p' | head -n 1)
      [[ -z "$source" ]] && source="default"
      ;;
    none)
      source=""
      ;;
    *)
      source="$audio_mode"
      ;;
  esac

  mkdir -p "$HOME/Videos"
  printf "Recording full screen (%s) to %s\n" "$size" "$out"
  [[ -n "$source" ]] && printf "Audio source: %s\n" "$source"
  printf "Press q in terminal to stop.\n"

  if [[ -n "$source" ]]; then
    ffmpeg -f x11grab -framerate 60 -video_size "$size" -i "$DISPLAY" \
      -f pulse -i "$source" \
      -c:v libx264 -preset veryfast -crf 23 -pix_fmt yuv420p \
      -c:a aac -b:a 160k \
      "$out"
  else
    ffmpeg -f x11grab -framerate 60 -video_size "$size" -i "$DISPLAY" \
      -c:v libx264 -preset veryfast -crf 23 -pix_fmt yuv420p \
      "$out"
  fi
}

record-screen-audio-sources() {
  ffmpeg -hide_banner -sources pulse
}
