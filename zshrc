# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"  # Or any other theme of your choice




# Fig pre block. Keep at the top of this file.
# [[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"



source /mnt/fed/zshScript/customFunction.sh

source /mnt/fed/zshScript/alias.sh
# source /mnt/fed/zshScript/enviromentVariable.sh

source /mnt/fed/secret.sh





# Enable tmux autostart
 export ZSH_TMUX_AUTOSTART="true"
 export ZSH_TMUX_AUTOSTART_ONCE="false"  # Set to "true" if you want it to autostart only once per shell session

 # Autostart tmux when opening a new terminal
 if [[ -z "$TMUX" ]]; then
   # Check if tmux autostart is enabled
   if [[ "$ZSH_TMUX_AUTOSTART" == "true" ]]; then
     # Actually don't autostart if multiple autostarts are disabled and already started
     if [[ "$ZSH_TMUX_AUTOSTART_ONCE" == "false" || "$ZSH_TMUX_AUTOSTARTED" != "true" ]]; then
       export ZSH_TMUX_AUTOSTARTED=true
       tmux attach || tmux new
     fi
   fi
 fi








#   f you come from bash you might have to change your $PATH.
 export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
# environment variable for bat (perhaps )
export PATH="$HOME/.local/bin:$PATH"
# environment variable for eza 
export PATH="/usr/bin/eza:$PATH"

# fasd for file folder navigation 
#eval "$(fasd --init auto | sed 's/fasd/zfasd/g')"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

export NODE_NO_WARNINGS=1
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
 ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to dy red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.


# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
	# zsh-syntax-highlighting 
  zsh-autosuggestions
	#zsh-z
	dirhistory	
	sudo
	web-search
 # zsh-vi-mode
	copybuffer 
	globalias
  alias-finder
  zsh-completions
)
# Only changing the escape key to `jk` in insert mode, we still
# keep using the default keybindings `^[` in other modes
# ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

source $ZSH/oh-my-zsh.sh
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
# custom function for customization 


# zsh-z plugin 
export PATH="$PATH:$HOME/.npm-global/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH="/opt/nvim/bin:$PATH"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion






# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
bindkey -v
# Bind ';' key to accept the autosuggestion
# bindkey ';' autosuggest-accept
bindkey "'" autosuggest-accept

# enhanced zsh by chatgpt prompt 
fpath+=~/.zsh-completions/src
autoload -U compinit && compinit

# Set up fzf key bindings and fuzzy completion
#;; fzf on Fedora fzf wasn't working by this stack overflows script working now 
if command -v fzf >/dev/null 2>&1; then
    source /usr/share/fzf/shell/key-bindings.zsh
fi
# -- Use fd instead of fzf --
# -- added by josean 
#export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# Set the FZF_DEFAULT_COMMAND to use fd and exclude .git and node_modules
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git --exclude node_modules"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git --exclude node_modules" # Use fd (https://github.com/sharkdp/fd) for listing path candidates. - The first argument to the function ($1) is the base path to start traversal - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
# added josean  fd --hidden --exclude .git . "$1"
  fd --hidden --exclude .git --exclude node_modules . "$1"
}

#josean Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git --exclude node_modules . "$1"

}





show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview   '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# josean Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}
#Search and execute commands from your history:
 export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border"

export FZF_DEFAULT_OPTS="
  --height 80% --layout=reverse --border
  --bind 'alt-g:execute-silent(google_search {+})'
"


#view with fzf any command 
cf() {
  $@ | fzf
}




source ~/fzf-git.sh/fzf-git.sh

# the fuck added by josean 
# thefuck alias
eval $(thefuck --alias)
eval $(thefuck --alias fk)
# ---- Zoxide (better cd) ----

# unsetopt completealiases
 eval "$(zoxide init zsh)"
# eval "$(zoxide init zsh)"




# cursor shape change for normal mode and insert mode for vi mode 
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q' # Block cursor
  else
    echo -ne '\e[5 q' #t: Beam cursor
  fi
}
zle -N zle-keymap-select

function zle-line-finish {
  echo -ne '\e[5 q' # Beam cursor
}
zle -N zle-line-finish

echo -ne '\e[5 q' # Beam cursor at the start
# export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$(yarn global bin)"

# pnpm
export PNPM_HOME="/home/sj/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end



# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
