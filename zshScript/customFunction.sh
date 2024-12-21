#clear pane with c-v 

function clear_terminal() {
  clear  # This is the regular clear command
}
zle -N clear_terminal  # Register the function as a ZLE widget
bindkey '^V' clear_terminal




# clear all the panes inside a window in tmux 
function clear_tmux_panes() {
  tmux list-panes -F "#{pane_id}" | xargs -I {} tmux send-keys -t {} "clear" C-m
}
zle -N clear_tmux_panes  # Register the function as a widget
bindkey '^A' clear_tmux_panes

alias cl="clear_tmux_panes"





#copy pwd by c-e 
 copydir() {
   pwd | xclip -selection clipboard
   echo "Copied: $(pwd)"
 }
zle -N copydir  # Define it as a Zsh widget
bindkey '^E' copydir









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







# Function to copy the last command and its output
copy_last_command_and_output() {
    {
        cmd=$(fc -ln -1)
        output=$(eval "$cmd" | sed 's/\x1B\[[0-9;]*m//g')
        echo -e "Command: $cmd\nOutput:\n$output"
    } | xclip -selection clipboard
}
# Register the function as a ZLE widget
zle -N copy_last_command_and_output
# Bind Ctrl+b to the widget
bindkey '^Y' copy_last_command_and_output
















#
# function show_zsh_keybindings() {
#   echo "=== Zsh Keybindings ==="
#   bindkey | less
# }
# zle -N show_zsh_keybindings  # Register the function as a ZLE widget
# bindkey '^M' show_zsh_keybindings  # Bind Ctrl+h to show Zsh keybindings
#







# # Function to send the current command to all tmux panes
# send_current_command_to_all_panes() {
#     # Get the current command line
#     current_command="${BUFFER}"
#
#     # Send the command to all tmux panes
#     tmux list-panes -F "#{pane_id}" | xargs -I {} tmux send-keys -t {} "$current_command" C-m
# }
#
# # Register the function as a ZLE widget
# zle -N send_current_command_to_all_panes
#
# # Key binding for sending the current command to all tmux panes
# bindkey '^B' send_current_command_to_all_panes  # Ctrl+/
#
#
# send_current_command_to_all_panes() {
#     # Get the current command line
#     current_command="${BUFFER}"
#
#     # Get the active pane ID
#     active_pane=$(tmux display-message -p "#{pane_id}")
#
#     # Send the command to all tmux panes except the active one
#     tmux list-panes -F "#{pane_id}" | while read -r pane_id; do
#         if [[ "$pane_id" != "$active_pane" ]]; then
#             tmux send-keys -t "$pane_id" "$current_command" C-m
#         fi
#     done
# }
#
# # Register the function as a ZLE widget
# zle -N send_current_command_to_all_panes
#
# # Key binding for sending the current command to all tmux panes
# bindkey '^B' send_current_command_to_all_panes  # Ctrl+/
#


send_current_command_to_all_panes() {
    # Get the current command line from the Zsh BUFFER
    current_command="${BUFFER}"

    # Get the active pane ID (where the user is typing)
    active_pane=$(tmux display-message -p "#{pane_id}")

    # Loop through all tmux panes
    tmux list-panes -F "#{pane_id}" | while read -r pane_id; do
        # Skip the active pane
        if [[ "$pane_id" == "$active_pane" ]]; then
            continue
        fi

        # Check if Neovim is active in this pane
        is_neovim=$(tmux capture-pane -t "$pane_id" -p | grep -q 'nvim' && echo "yes" || echo "no")

        # Skip sending the command if Neovim is detected
        if [[ "$is_neovim" == "yes" ]]; then
            continue
        fi

        # Send the command to the pane and execute it
        tmux send-keys -t "$pane_id" "$current_command" C-m
    done
}

# Register the function as a ZLE widget
zle -N send_current_command_to_all_panes

# Bind the widget to Ctrl+B
bindkey '^B' send_current_command_to_all_panes




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

  # cp -r ~/.config/i3 "$backup_dir/i3"
  cp -r ~/.tmux.conf "$backup_dir/tmux.conf"
  cp -r ~/.zshrc "$backup_dir/zshrc"
  cp -r ~/.config/nvim "$backup_dir/nvim"
  cp -r /etc/keyd "$backup_dir/keyd"
  cp -r ~/.config/yazi "$backup_dir/yazi"

  cp -r ~/.config/hypr "$backup_dir/hypr"
  cp -r /mnt/fed/zshScript /mnt/fed/allDotfilesBackup
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




#
# #fancy ctrl y 
# fancy-ctrl-y () {
#   if [[ $#BUFFER -eq 0 ]]; then
#     BUFFER="fg"
#     zle accept-line -w
#   else
#     zle push-input -w
#     zle clear-screen -w
#   fi
# }
# zle -N fancy-ctrl-y
# bindkey '^Y' fancy-ctrl-y
#
#

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
    /mnt/fed/zshScript/fzf-repo-manager-level2.sh                                                          

}

# Register the function as a ZLE widget
zle -N fzf_repo_manager_level2

# Bind the widget to Ctrl+Q
bindkey '^W' fzf_repo_manager_level2



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
      tmux send-keys -t ${window}.${pane} 'cd /mnt/fed/web && clear' C-m
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







 #p: Close all tmux panes except the active one
close_tmux_panes() {
  tmux list-panes -F "#{pane_id}" | grep -v "$(tmux display-message -p "#{pane_id}")" | xargs -I{} tmux kill-pane -t {}
}

# Register the function as a ZLE widget
zle -N close_tmux_panes

# Bind the widget to Alt + U
 bindkey '^[u' close_tmux_panes


function b() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}



tmux_setup() {
  # Prompt for session name
  echo "Enter session name:"
  read SESSION_NAME

  # Create a new tmux session
  tmux new-session -s "$SESSION_NAME" -d
  tmux switch-client -t "$SESSION_NAME"

  sleep 2
  # Create new windows
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

  # Set /mnt/fed/web as the directory for each pane
  for window in 0 1 2; do
    for pane in 0 1 2; do
      tmux send-keys -t ${window}.${pane} 'cd /mnt/fed/web && clear' C-m
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


tmux_setup2() {
  # Prompt for session name
  echo "Enter session name:"
  read SESSION_NAME

  # Create a new tmux session
  tmux new-session -s "$SESSION_NAME" -d
  sleep 1  # Small delay to ensure the session is created before proceeding

  # Create new windows
  tmux new-window -t 0 -n 'Window-1'
  sleep 1
  tmux new-window -t 1 -n 'Window-2'
  sleep 1
  tmux new-window -t 2 -n 'Window-3'
  sleep 1

  # Split panes in each window
  tmux select-window -t 0
  tmux split-window -h  # Horizontal split
  tmux split-window -v  # Vertical split
  tmux select-pane -t 0  # Focus the first pane in window 0
  sleep 1

  tmux select-window -t 1
  tmux split-window -h
  tmux split-window -v
  sleep 1

  tmux select-window -t 2
  tmux split-window -h
  tmux split-window -v
  sleep 1

  # Set /mnt/fed/web as the directory for each pane
  for window in 0 1 2; do
    for pane in 0 1 2; do
      tmux send-keys -t ${window}.${pane} 'cd /mnt/fed/web && clear' C-m
      sleep 1
    done
  done

  # Apply saved layouts (replace with your layout strings)
  tmux select-layout -t 0 '8d8d,210x44,0,0[210x27,0,0,4,210x16,0,28{104x16,0,28,5,105x16,105,28,6}]'
  sleep 1
  tmux select-layout -t 1 '6520,210x44,0,0[210x28,0,0,7,210x15,0,29{104x15,0,29,8,105x15,105,29,9}]'
  sleep 1
  tmux select-layout -t 2 '2ecf,210x44,0,0[210x32,0,0,10,210x11,0,33{107x11,0,33,11,102x11,108,33,12}]'
  sleep 1

  # Focus the first window and the first pane
  tmux select-window -t 0
  tmux select-pane -t 0
}

#p: nvim . enter first copy the current pwd and then cd the into dir with the other tmux panes
nvim_cd_all() {
  # Get the current working directory
  local current_dir="$PWD"

  # Get the current tmux pane ID
  local current_pane=$(tmux display-message -p '#{pane_id}')

  # Iterate over all tmux panes in the current window
  tmux list-panes -F '#{pane_id}' | while read -r pane; do
    if [[ "$pane" != "$current_pane" ]]; then
      # Send `cd` command to other panes
      tmux send-keys -t "$pane" "cd $current_dir" C-m
    fi
  done

  # Open nvim in the current pane
  nvim .
}

# Alias for convenience
alias ,="nvim_cd_all"


#w: 21/12/2024 01:27 PM Sat GMT+6 Sharifpur, Gazipur, Dhaka
# 
#p: tmux creating session  ,, sess "name of the session "  example:  sess cfg 
sess() {
    if [ -z "$1" ]; then
        echo -n "Enter session name: "
        read session_name
    else
        session_name=$1
    fi
    tmux new-session -d -s "$session_name" && tmux switch-client -t "$session_name"
}
