
#!/bin/bash
# Get the current working directory of Neovim
path=$(pwd)

# Send the path change command to other Tmux panes
tmux send-keys -t 2 "cd $path" C-m
tmux send-keys -t 3 "cd $path" C-m

# Now open Neovim
nvim $path
