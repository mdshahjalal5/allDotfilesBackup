local keymap = vim.keymap

--t: Function to restore specific tmux layouts
function restore_tmux_layouts()
	vim.fn.system("tmux select-layout -t 0 '8d8d,210x44,0,0[210x27,0,0,4,210x16,0,28{104x16,0,28,5,105x16,105,28,6}]'")
	vim.fn.system("tmux select-layout -t 2 '6520,210x44,0,0[210x28,0,0,7,210x15,0,29{104x15,0,29,8,105x15,105,29,9}]'")
	vim.fn.system(
		"tmux select-layout -t 3 '2ecf,210x44,0,0[210x32,0,0,10,210x11,0,33{107x11,0,33,11,102x11,108,33,12}]'"
	)
end

--t: Map <leader>aa to restore the tmux layouts
keymap.set("n", "<leader>aa", ":lua restore_tmux_layouts()<CR>", { noremap = true, silent = true })

--
--
--
--
--
--
--
--t: clear tmux panes
vim.api.nvim_set_keymap("n", "<space>al", ":lua ClearOtherTmuxPanes()<CR>", { noremap = true, silent = true })
function ClearOtherTmuxPanes()
	-- Get the tmux pane ID for the current Neovim instance
	local current_pane = vim.fn.system('tmux display-message -p "#{pane_id}"'):gsub("%s+", "")

	-- Get a list of all tmux panes
	local panes = vim.fn.systemlist('tmux list-panes -F "#{pane_id}"')

	--t: Loop through each pane and clear it if it is not the current Neovim pane
	for _, pane in ipairs(panes) do
		if pane ~= current_pane then
			vim.fn.system("tmux send-keys -t " .. pane .. ' "clear" C-m')
		end
	end

	-- Notify the user
	vim.notify("Cleared all tmux panes except the active Neovim pane")
	vim.api.nvim_set_keymap("n", "<space>al", ":lua ClearOtherTmuxPanes()<CR>", { noremap = true, silent = true })

	function ClearOtherTmuxPanes()
		-- Get the tmux pane ID for the current Neovim instance
		local current_pane = vim.fn.system('tmux display-message -p "#{pane_id}"'):gsub("%s+", "")

		-- Get a list of all tmux panes
		local panes = vim.fn.systemlist('tmux list-panes -F "#{pane_id}"')

		-- Loop through each pane and clear it if it is not the current Neovim pane
		for _, pane in ipairs(panes) do
			if pane ~= current_pane then
				vim.fn.system("tmux send-keys -t " .. pane .. ' "clear" C-m')
			end
		end

		-- Clear Neovim's integrated terminal if in terminal mode
		if vim.bo.buftype == "terminal" then
			vim.api.nvim_feedkeys("i<C-u>", "n", true) -- Clear the terminal buffer
		end

		-- Notify the user
		vim.notify("Cleared all tmux panes except the active Neovim pane")
	end
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--t: Function to backup dotfiles and push to Git
	function backup_and_git_push()
		local backup_dir = "/mnt/fed/allDotfilesBackup"

		-- Run shell commands to back up the files
		vim.fn.system("mkdir -p " .. backup_dir)
		vim.fn.system("cp -r ~/.config/i3 " .. backup_dir .. "/i3")
		vim.fn.system("cp -r ~/.tmux.conf " .. backup_dir .. "/tmux.conf")
		vim.fn.system("cp -r ~/.zshrc " .. backup_dir .. "/zshrc")
		vim.fn.system("cp -r ~/.config/nvim " .. backup_dir .. "/nvim")
		vim.fn.system("cp -r /etc/keyd " .. backup_dir .. "/keyd")
		vim.fn.system("cp -r ~/.config/yazi " .. backup_dir .. "/yazi")
		vim.fn.system("cp -r /mnt/fed/zshScript " .. backup_dir)
		vim.fn.system("cp -r  " .. backup_dir)

		-- Prompt for the Git commit message
		local commit_message = vim.fn.input("Enter commit message: ")
		if commit_message == "" then
			print("Commit message cannot be empty. Aborting.")
			return
		end

		-- Git push operation within the target directory
		vim.fn.system("git -C " .. backup_dir .. " add .")
		vim.fn.system("git -C " .. backup_dir .. " commit -m '" .. commit_message .. "'")
		vim.fn.system("git -C " .. backup_dir .. " push")

		print("Backup and push completed successfully.")
	end

	vim.api.nvim_set_keymap("n", "<leader>ab", ":lua backup_and_git_push()<CR>", { noremap = true, silent = true })
	--
	--
	--
	--
	--
	--
	--
	--t: Function to open the current project root in VS Code
	function open_project_in_vscode()
		-- Get the current project root directory
		local project_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")

		-- Check if inside a Git repository
		if project_root == "" then
			print("Not in a Git repository.")
			return
		end

		-- Open VS Code in the project root
		vim.fn.system("code " .. project_root)
		print("Opening project in VS Code: " .. project_root)
	end
	vim.api.nvim_set_keymap("n", "<leader>av", ":lua open_project_in_vscode()<CR>", { noremap = true, silent = true })
	--
	--
	--
	--
	--
	--
	--
	--t:
	function GitPushFromNvim()
		-- Prompt for commit message
		local commit_message = vim.fn.input("Enter commit message: ")

		-- Ensure the commit message is not empty
		if commit_message == "" then
			print("Commit message cannot be empty. Aborting.")
			return
		end

		-- Execute the git commands sequentially
		vim.cmd("!git add .")
		vim.cmd("!git commit -m '" .. commit_message .. "'")
		vim.cmd("!git push -u origin main")
	end
	vim.api.nvim_set_keymap("n", "<space>aj", ":lua GitPushFromNvim()<CR>", { noremap = true, silent = true })

	--
	--
	--
	--
	--
	-- Function to copy the last command and its output
	-- -- Mapping to set the focus directory as root and close parent directory
	-- vim.api.nvim_set_keymap("n", "<space>ao", ":lua SetNvimTreeRootToCursor()<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<space>ao", ":lua SetNvimTreeRootToCursor()<CR>", { noremap = true, silent = true })
	--w: 09/11/2024 06:59 PM Sat GMT+6 Sharifpur, Gazipur, Dhaka
	-- change cursor existing  dir to root working dir for neovim
	--[[ function SetNvimTreeRootToCursor()
	local api = require("nvim-tree.api")

	-- Get the node at the current cursor location
	local node = api.tree.get_node_under_cursor()

	if node and node.type == "directory" then
		-- Change root to the current directory under the cursor
		api.tree.change_root_to_node(node)

		-- Close the parent node
		api.node.navigate.parent_close(node)

		-- Optional: Center the cursor
		vim.cmd("normal! zz")
	else
		print("Please place the cursor on a directory node to set it as the root.")
	end
end
]]

	function SetNvimTreeRootToCursor()
		local api = require("nvim-tree.api")

		-- Get the node at the current cursor location
		local node = api.tree.get_node_under_cursor()

		if node and node.type == "directory" then
			-- Change Neovim root to the current directory under the cursor
			api.tree.change_root_to_node(node)

			-- Close the parent node
			api.node.navigate.parent_close(node)

			-- Optional: Center the cursor
			vim.cmd("normal! zz")

			-- Get the current directory path
			local new_root = node.absolute_path

			-- Update all Tmux panes except the Neovim pane to the new directory
			SetTmuxPanesDir(new_root)
		else
			print("Please place the cursor on a directory node to set it as the root.")
		end
	end

	function SetTmuxPanesDir(new_root)
		-- Get the ID of the current Tmux window
		local current_pane = vim.fn.systemlist("tmux display-message -p '#{pane_id}'")[1]
		local panes = vim.fn.systemlist("tmux list-panes -F '#{pane_id}'")

		-- Iterate through each pane in the current Tmux window
		for _, pane in ipairs(panes) do
			if pane ~= current_pane then
				-- Send the command to change directory to the other panes
				vim.fn.system("tmux send-keys -t " .. pane .. " 'cd " .. new_root .. "' C-m")
			end
		end
	end

	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--
	--p: terminal run in neovim editor area
	local cmd_output_buf = nil

	-- Command Mode Setup
	vim.api.nvim_create_user_command("CmdMode", function()
		if not cmd_output_buf or not vim.api.nvim_buf_is_valid(cmd_output_buf) then
			vim.cmd("vnew") -- Open a vertical split for commands and outputs
			cmd_output_buf = vim.api.nvim_get_current_buf() -- Store buffer number
			vim.bo.buftype = "nofile" -- Set buffer type
			vim.bo.bufhidden = "hide" -- Ensure buffer persists until explicitly closed
			vim.bo.swapfile = false -- Disable swap file
		end
		vim.cmd("buffer " .. cmd_output_buf) -- Switch to the command/output buffer

		-- Map <CR> in the buffer to execute commands
		vim.api.nvim_buf_set_keymap(
			cmd_output_buf,
			"n",
			"<CR>",
			[[<Cmd>lua ExecuteCommandInSharedBuffer()<CR>]],
			{ noremap = true, silent = true }
		)
	end, {})
	-- Function to Execute Commands and Append Output
	function ExecuteCommandInSharedBuffer()
		if not cmd_output_buf or not vim.api.nvim_buf_is_valid(cmd_output_buf) then
			print("Error: Command buffer is not initialized.")
			return
		end

		local current_line = vim.api.nvim_get_current_line()
		if current_line == "" then
			return
		end -- Do nothing if the line is empty

		-- Get Git status in a simple prompt format
		local git_status = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null")
		local git_branch = ""
		if git_status ~= "" then
			git_branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
		end

		-- Get current directory
		local current_directory = vim.fn.getcwd()

		-- Create a prompt similar to "home(main)>"
		local prompt = current_directory .. " > "
		if git_branch ~= "" then
			prompt = prompt .. "(" .. git_branch .. ")"
		end

		-- Execute the command in Zsh (without interactive shell to avoid zle issues)
		local output = vim.fn.systemlist("zsh -c '" .. current_line .. "'")

		-- Add the prompt, command, and output to the buffer
		local lines_to_add = { prompt .. current_line } -- Display command with prompt
		vim.list_extend(lines_to_add, output) -- Append the output
		vim.api.nvim_buf_set_lines(cmd_output_buf, -1, -1, false, lines_to_add) -- Append to buffer
		vim.api.nvim_buf_set_lines(cmd_output_buf, -1, -1, false, { "" }) -- Add a blank line

		-- Clear the current line for the next command
		vim.api.nvim_buf_set_lines(cmd_output_buf, vim.fn.line(".") - 1, vim.fn.line("."), false, { "" })
	end
end
