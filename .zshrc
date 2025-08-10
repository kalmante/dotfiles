# Load the instant prompt if it exists
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable vi mode
bindkey -v
export KEYTIMEOUT=1

function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]] ; then
    echo -ne "\e]2;NORMAL MODE\a"
  else
    echo -ne "\e]2;INSERT MODE\a"
  fi
}
zle -N zle-keymap-select

# Load the Powerlevel10k theme
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Load zsh autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Load zsh syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Alias "g" for git
alias g="git"

# Alias "c" for clear
alias c="clear"

#Alias "s" for source
alias s="source"

#Alias "m" for mkdir
alias m="mkdir"

#Alias "mp" for mkdir -p
alias mp="mkdir -p"

# Alias "x" for exit
alias x="exit"

# Alias "lg" to open LazyGit
alias gg="lazygit"

# Alias "nv" to lauch neovim
alias n="nvim"

# Alias "ls" to use eza with icons and simplified output
alias ls="eza -al --color=always --long --git --icons=always --created --time-style=long-iso"

# Initialize Zoxide for smarter directory navigation
eval "$(zoxide init zsh)"

# Set the default theme for bat syntax highlighting
export BAT_THEME="Solarized (dark)"

# Add Mason's bin directory to PATH for Neovim LSPs
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Customize FZF options for file and directory preview
export FZF_CTRL_T_OPTS="--preview 'eza --tree --color=always {} | head -200'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Custom FZF completion runner with different previews based on command
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "eza --tree --color=always {} | head -200" "$@" ;;
  esac
}

# Set the default FZF commands for finding files and directories
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# FZF path completion function
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# FZF directory completion function
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Enable FZF integration with Zsh
eval "$(fzf --zsh)"

# Load Powerlevel10k configuration if it exists
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=nvim
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
