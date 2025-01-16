--
--
--
--t: git push from neovim
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
--
local keymap = vim.keymap

--t: Function to restore specific tmux layouts
function restore_tmux_layouts()
	vim.fn.system("tmux select-layout -t 0 '8d8d,210x44,0,0[210x27,0,0,4,210x16,0,28{104x16,0,28,5,105x16,105,28,6}]'")
	vim.fn.system("tmux select-layout -t 2 '6520,210x44,0,0[210x28,0,0,7,210x15,0,29{104x15,0,29,8,105x15,105,29,9}]'")
	vim.fn.system(
		"tmux select-layout -t 3 '2ecf,210x44,0,0[210x32,0,0,10,210x11,0,33{107x11,0,33,11,102x11,108,33,12}]'"
	)
end

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
end
--
--
--
--
--
--
--w: github repository create and push the local directory by leader gg
local function init_git_project()
	-- Get the current working directory
	local cwd = vim.fn.getcwd()

	-- Get the system username
	local username = vim.fn.system("whoami"):gsub("%s+", "")

	-- Get the current date and time
	local date_time = os.date("%d/%m/%Y %I:%M %p %a GMT+6")

	-- Define the location
	local location = "Sharifpur, Gazipur, Dhaka"

	-- Prompt for the repository name
	local repo_name = vim.fn.input("Enter the repository name: ")

	-- Construct the GitHub URL
	local github_url = "https://github.com/" .. username .. "/" .. repo_name

	-- Generate README.md content
	local readme_content = string.format(
		[[
# %s

## Project Details
- **GitHub URL:** %s
- **Local Directory:** %s
- **Username:** %s
- **Created On:** %s
- **Location:** %s
]],
		repo_name,
		github_url,
		cwd,
		username,
		date_time,
		location
	)

	-- Write content to README.md
	local readme_file = io.open("README.md", "w")
	readme_file:write(readme_content)
	readme_file:close()

	-- Initialize Git repository and commit changes
	vim.fn.system("git init")
	vim.fn.system("git add .")
	vim.fn.system("git commit -m 'Initial commit'")
	vim.fn.system("git branch -M main")

	-- Create the GitHub repository and push
	local command = string.format("gh repo create %s --public --source=. --remote=origin --push", repo_name)
	local result = vim.fn.system(command)

	-- Notify the user about the result
	vim.notify(result, vim.log.levels.INFO)
end

-- Map the function to a key combination
vim.keymap.set("n", "<leader>gg", init_git_project, { noremap = true, silent = true })

-- again updated

local function create_and_push_repo()
	-- Get the current working directory
	local cwd = vim.fn.getcwd()

	-- Get the system username
	local username = vim.fn.system("whoami"):gsub("%s+", "")

	-- Get the current date and time
	local date_time = os.date("%d/%m/%Y %I:%M %p %a GMT+6")

	-- Define the location
	local location = "Sharifpur, Gazipur, Dhaka"

	-- Default repository name to root directory name
	local repo_name = vim.fn.fnamemodify(cwd, ":t")

	-- Prompt for repository name (non-blocking) with default
	vim.ui.input({ prompt = "Enter the repository name: ", default = repo_name }, function(input)
		repo_name = input or repo_name -- Use input if provided, otherwise use default
		local github_url = "https://github.com/" .. username .. "/" .. repo_name

		-- Notify starting status
		vim.cmd("redrawstatus")
		vim.cmd("echo 'Initializing repository...'")

		-- Prepare README.md content
		local readme_content = string.format(
			[[# %s

## Project Details
- **GitHub URL:** %s
- **Local Directory:** %s
- **Username:** %s
- **Created On:** %s
- **Location:** %s

]],
			repo_name,
			github_url,
			cwd,
			username,
			date_time,
			location
		)

		-- Check if README.md exists and append content at the top
		local readme_file_path = "README.md"
		local readme_content_with_existing = readme_content

		if vim.fn.filereadable(readme_file_path) == 1 then
			local existing_content = table.concat(vim.fn.readfile(readme_file_path), "\n")
			readme_content_with_existing = readme_content .. "\n" .. existing_content
		end

		-- Write the README.md file
		local readme_file = io.open(readme_file_path, "w")
		readme_file:write(readme_content_with_existing)
		readme_file:close()

		-- Initialize Git repository
		vim.fn.system("git init")
		vim.fn.system("git add .")
		vim.fn.system("git commit -m 'Initial commit'")
		vim.fn.system("git branch -M main")

		-- Create GitHub repository and push
		local command = string.format("gh repo create %s --public --source=. --remote=origin --push", repo_name)
		local result = vim.fn.system(command)

		-- Notify user about the result
		vim.cmd("redrawstatus")
		vim.notify("Repository created and pushed successfully!", vim.log.levels.INFO)

		-- Display result in the status line
		vim.cmd("echo 'GitHub repository created and pushed!'")
	end)
end

-- Map the function to <leader>gh
vim.keymap.set("n", "<leader>gh", create_and_push_repo, { noremap = true, silent = true })

-- update another time

local function create_and_push_repo_with_error_handling()
	-- Get the current working directory
	local cwd = vim.fn.getcwd()

	-- Get the system username
	local username = vim.fn.system("whoami"):gsub("%s+", "")

	-- Get the current date and time
	local date_time = os.date("%d/%m/%Y %I:%M %p %a GMT+6")

	-- Define the location
	local location = "Sharifpur, Gazipur, Dhaka"

	-- Default repository name to root directory name
	local repo_name = vim.fn.fnamemodify(cwd, ":t")

	-- Prompt for repository name (non-blocking) with default
	vim.ui.input({ prompt = "Enter the repository name: ", default = repo_name }, function(input)
		repo_name = input or repo_name -- Use input if provided, otherwise use default
		local github_url = "https://github.com/mdshahjalal5/" .. repo_name

		-- Notify starting status
		vim.cmd("redrawstatus")
		vim.cmd("echo 'Initializing repository...'")

		-- Prepare README.md content
		local readme_content = string.format(
			[[# %s

## Project Details
- **GitHub URL:** %s
- **Local Directory:** %s
- **Username:** %s
- **Created On:** %s
- **Location:** %s

]],
			repo_name,
			github_url,
			cwd,
			username,
			date_time,
			location
		)

		-- Check if README.md exists and append content at the top
		local readme_file_path = "README.md"
		local readme_content_with_existing = readme_content

		if vim.fn.filereadable(readme_file_path) == 1 then
			local existing_content = table.concat(vim.fn.readfile(readme_file_path), "\n")
			readme_content_with_existing = readme_content .. "\n" .. existing_content
		end

		-- Write the README.md file
		local readme_file = io.open(readme_file_path, "w")
		readme_file:write(readme_content_with_existing)
		readme_file:close()

		-- Initialize Git repository and handle errors
		local init_result = vim.fn.system("git init")
		if vim.v.shell_error ~= 0 then
			vim.notify("Error initializing Git repository: " .. init_result, vim.log.levels.ERROR)
			return
		end

		local add_result = vim.fn.system("git add .")
		if vim.v.shell_error ~= 0 then
			vim.notify("Error adding files to Git: " .. add_result, vim.log.levels.ERROR)
			return
		end

		local commit_result = vim.fn.system("git commit -m 'Initial commit'")
		if vim.v.shell_error ~= 0 then
			vim.notify("Error committing files to Git: " .. commit_result, vim.log.levels.ERROR)
			return
		end

		local branch_result = vim.fn.system("git branch -M main")
		if vim.v.shell_error ~= 0 then
			vim.notify("Error renaming branch to main: " .. branch_result, vim.log.levels.ERROR)
			return
		end

		-- Create GitHub repository and push, handle errors
		local command = string.format("gh repo create %s --public --source=. --remote=origin --push", repo_name)
		local result = vim.fn.system(command)

		if vim.v.shell_error ~= 0 then
			vim.notify("Error creating or pushing to GitHub repository: " .. result, vim.log.levels.ERROR)
			return
		end

		-- Notify user about the successful creation and push of the repository
		vim.cmd("redrawstatus")
		vim.notify("Repository created and pushed successfully!", vim.log.levels.INFO)

		-- Open the new GitHub repository in the browser
		local open_url_command = string.format("xdg-open %s", github_url) -- For Linux; change as needed for other OSes.
		os.execute(open_url_command)

		-- Display result in the status line
		vim.cmd("echo 'GitHub repository created and pushed!'")
	end)
end

-- Map the function to <leader>gj
vim.keymap.set("n", "<leader>gj", create_and_push_repo_with_error_handling, { noremap = true, silent = true })
