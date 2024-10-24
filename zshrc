
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

 copydir() {
   pwd | xclip -selection clipboard
   echo "Copied: $(pwd)"
 }

zle -N copydir  # Define it as a Zsh widget
bindkey '^E' copydir

#git pushing dynamically 

git_push() {
  # Prompt for commit message (Zsh-friendly)
  echo -n "Enter commit message: "
  read commit_message

  # Ensure commit message is not empty
  if [[ -z "$commit_message" ]]; then
    echo "Commit message cannot be empty. Aborting."
    return 1
  fi

  # Execute the git commands sequentially
  git add . && \
  git commit -m "$commit_message" && \
  git push -u origin main
}
zle -N git_push_widget git_push
# bindkey '^Q' git_push_widget


# back up all the dotfiles 


backup_dotfiles() {
  local backup_dir="/mnt/fed/allDotfilesBackup"
  mkdir -p "$backup_dir"

  cp -r ~/.config/i3 "$backup_dir/i3"
  cp -r ~/.tmux.conf "$backup_dir/tmux.conf"
  cp -r ~/.zshrc "$backup_dir/zshrc"
  cp -r ~/.config/nvim "$backup_dir/nvim"
  cp -r /etc/keyd "$backup_dir/keyd"
  cp -r ~/.config/yazi "$backup_dir/yazi"

  echo "All dotfiles have been backed up to $backup_dir."
}





# git push from any dir without need to cd 
git_push2() {
  # Ensure the directory is provided
  if [[ -z "$1" ]]; then
    echo "Usage: git_push <target-directory>"
    return 1
  fi

  local target_dir="$1"

  # Ensure the target directory exists
  if [[ ! -d "$target_dir" ]]; then
    echo "Directory '$target_dir' not found. Aborting."
    return 1
  fi

  # Prompt for commit message
  echo -n "Enter commit message: "
  read commit_message

  # Ensure commit message is not empty
  if [[ -z "$commit_message" ]]; then
    echo "Commit message cannot be empty. Aborting."
    return 1
  fi

  # Perform git operations within the target directory
  git -C "$target_dir" add .
  git -C "$target_dir" commit -m "$commit_message"
  git -C "$target_dir" push

  echo "Changes pushed successfully from $target_dir."
}





#fancy ctrl y 
fancy-ctrl-y () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-y
bindkey '^Y' fancy-ctrl-y



function init_git_project() {
  echo "# chk" >> README.md
  git init
  git add .
  git commit -m "first commit"
  git branch -M main

  # Prompt the user to enter the repository name
  echo -n "Enter the repository name: "
  read repo_name

  # Create the GitHub repository with the entered name
  gh repo create "$repo_name" --public --source=. --remote=origin --push
}

# Create a Zsh widget that calls the function
zle -N init_git_project_widget init_git_project

# Bind Ctrl+p to the widget
bindkey '^P' init_git_project_widget


#sj repo fzf-repo-manager
# Function to run fzf-repo-manager from /mnt/fed/zshScript
function fzf_repo_manager {
    /mnt/fed/zshScript/fzf-repo-manager.sh
}

# Bind Ctrl+R to the function
zle -N fzf_repo_manager  # Register the function as a Zsh widget
bindkey '^U' fzf_repo_manager  # Bind Ctrl+R to it




#fzf_repo_manager_level1

# Function to run the fzf-repo-manager from /mnt/fed/zshScript
function fzf_repo_manager_level1() {

     /mnt/fed/zshScript/fzf-repo-manager-level1.sh
}

# Register the function as a ZLE widget
zle -N fzf_repo_manager_level1

# Bind the widget to Ctrl+Q
bindkey '^Q' fzf_repo_manager_level1





# Function to run the fzf-repo-manager from /mnt/fed/zshScript
function fzf_repo_manager_level2() {
    /mnt/fed/zshScript/fzf-repo-manager-level2.sh                                                          ─╯

}

# Register the function as a ZLE widget
zle -N fzf_repo_manager_level2

# Bind the widget to Ctrl+Q
bindkey '^W' fzf_repo_manager_level2








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








# dir history M-j go back history, M-k go to parent , m-l go forward in history 
function dirhistory_zle_dirhistory_back() {
  zle .kill-buffer
  dirhistory_back
  zle .accept-line
}
zle -N dirhistory_zle_dirhistory_back
bindkey -M emacs "\ej" dirhistory_zle_dirhistory_back
bindkey -M vicmd "\ej" dirhistory_zle_dirhistory_back
bindkey -M viins "\ej" dirhistory_zle_dirhistory_back

function dirhistory_zle_dirhistory_future() {
  zle .kill-buffer
  dirhistory_forward
  zle .accept-line
}
zle -N dirhistory_zle_dirhistory_future
bindkey -M emacs "\el" dirhistory_zle_dirhistory_future
bindkey -M vicmd "\el" dirhistory_zle_dirhistory_future
bindkey -M viins "\el" dirhistory_zle_dirhistory_future

function dirhistory_zle_dirhistory_up() {
  zle .kill-buffer
  dirhistory_up
  zle .accept-line
}
zle -N dirhistory_zle_dirhistory_up
bindkey -M emacs "\ek" dirhistory_zle_dirhistory_up
bindkey -M vicmd "\ek" dirhistory_zle_dirhistory_up
bindkey -M viins "\ek" dirhistory_zle_dirhistory_up



# Function to restore specific tmux layouts
tr() {
  tmux select-layout -t 0 '8d8d,210x44,0,0[210x27,0,0,4,210x16,0,28{104x16,0,28,5,105x16,105,28,6}]'
  tmux select-layout -t 2 '6520,210x44,0,0[210x28,0,0,7,210x15,0,29{104x15,0,29,8,105x15,105,29,9}]'
  tmux select-layout -t 3 '2ecf,210x44,0,0[210x32,0,0,10,210x11,0,33{107x11,0,33,11,102x11,108,33,12}]'
}



#tmux auto layout 
# Function to set up tmux layout with alias `tla`
tmux_layout() {
  # Create 3 windows (starting with 0, since tmux is 0-indexed)
  tmux new-window -t 0 -n 'Window-1'
  tmux new-window -t 1 -n 'Window-2'
  tmux new-window -t 2 -n 'Window-3'

  # Split panes in each window
  tmux select-window -t 0
  tmux split-window -h  # Horizontal split
  tmux split-window -v  # Vertical split
  tmux select-pane -t 0  # Focus the first pane in window 0

  tmux select-window -t 1
  tmux split-window -h
  tmux split-window -v

  tmux select-window -t 2
  tmux split-window -h
  tmux split-window -v

  # Set /mnt/fed/web2 as the directory for each pane
  for window in 0 1 2; do
    for pane in 0 1 2; do
      tmux send-keys -t ${window}.${pane} 'cd /mnt/fed/web2 && clear' C-m
    done
  done

  # Apply saved layouts (replace with your layout strings)
  tmux select-layout -t 0 '8d8d,210x44,0,0[210x27,0,0,4,210x16,0,28{104x16,0,28,5,105x16,105,28,6}]'
  tmux select-layout -t 1 '6520,210x44,0,0[210x28,0,0,7,210x15,0,29{104x15,0,29,8,105x15,105,29,9}]'
  tmux select-layout -t 2 '2ecf,210x44,0,0[210x32,0,0,10,210x11,0,33{107x11,0,33,11,102x11,108,33,12}]'

  # Focus the first window and the first pane
  tmux select-window -t 0
  tmux select-pane -t 0
}

# Create an alias for the function
alias tla='tmux_layout'



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
 ZSH_THEME="powerlevel10k/powerlevel10k"
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
alias l="nvim ~/.config/nvim/init.lua"
alias f="cd ~ && cd \$(find /mnt/fed/web2 -type d \( -name node_modules -o -name .git \) -prune -o -name '*'  -type d -print | fzf)"
alias -g  y="yazi"
alias ss="sudo systemctl restart keyd"
alias -g n="nvim"
alias v='nvim ~/.zshrc'
alias j='n ~/.config/i3/config'
alias b="nvim /home/mdshahjalal5/.xmonad/xmonad.hs"
alias s="systemctl suspend"
alias e='exec zsh'
alias cc="code "

alias t="tmux attach || tmux new"
alias tt="nvim /home/sj/.tmux.conf"
alias a="exit"
alias -g u="/mnt/fed/web2"

alias w="/mnt/fed2/web2"
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias ,='nvim .'
alias c="/home/sj/.config/nvim"
alias i='nocorrect sudo dnf install '
alias r='nocorrect sudo dnf remove '
alias p='systemctl --user restart pipewire && systemctl --user restart pipewire-pulse && systemctl --user daemon-reload'
alias gi="git_push"
# alias d='nmcli device disconnect enp1s0'
# alias de='nmcli device connect enp1s0'
alias tl='tmux ls'
alias tn='tmux new -s '
alias ta='tmux attach -t '
alias tk='tmux kill-session -t '
alias alt="setxkbmap -option altwin:meta_alt"
# alias fp="$(tmux ls | fzf | awk '{print $1}' | sed 's/://')"
# alias ff ="$(  | fzf | awk '{print $1}' | sed 's/://')"
alias gkk="git init && git add . && git commit -m 'first message' && git branch -M main"
alias -g nano="nvim "
alias gn='gh gd'
alias cd="z"
alias sg="yarn build  && surge dist"
alias up="/mnt/fed/web2/nextLevelPrerequisite/"
# custom function for customization 
#enter will run the last used command 
last_if_empty() {
  if [[ -z "$BUFFER" ]]; then
    zle up-history
    zle accept-line
  else
    zle accept-line
  fi
}
zle -N last_if_empty
bindkey -M viins '^M' last_if_empty



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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# enhanced zsh by chatgpt prompt 
fpath+=~/.zsh-completions/src
autoload -U compinit && compinit

# Set up fzf key bindings and fuzzy completion
# setxkbmap -option "caps:swapescape"

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
    echo -ne '\e[5 q' # Beam cursor
  fi
}
zle -N zle-keymap-select

function zle-line-finish {
  echo -ne '\e[5 q' # Beam cursor
}
zle -N zle-line-finish

echo -ne '\e[5 q' # Beam cursor at the start
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:$(yarn global bin)"

