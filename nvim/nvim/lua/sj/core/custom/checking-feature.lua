vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true }) -- Escape terminal mode
vim.api.nvim_set_keymap("t", "<C-h>", [[<C-\><C-n><C-w>h]], { noremap = true }) -- Navigate left
vim.api.nvim_set_keymap("t", "<C-l>", [[<C-\><C-n><C-w>l]], { noremap = true }) -- Navigate right
vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-w>j]], { noremap = true }) -- Navigate down
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-w>k]], { noremap = true }) -- Navigate up
vim.api.nvim_set_keymap("n", "<leader>tz", ":split | terminal<CR>", { noremap = true, silent = true })

if vim.g.started_by_firenvim then
	-- General configuration for Firenvim
	vim.g.firenvim_config = {
		globalSettings = {
			alt = "all",
		},
		localSettings = {
			[".*"] = {
				cmdline = "neovim",
				priority = 0,
				selector = "textarea",
				takeover = "never",
			},
		},
	}

	-- Setup function for Firenvim
	local function setup_firenvim()
		vim.opt.filetype = "markdown"
		vim.opt.ruler = false
		vim.opt.showcmd = false
		vim.opt.laststatus = 0
		vim.opt.showtabline = 0
	end

	-- Autocommand group for Firenvim
	vim.api.nvim_create_augroup("Firenvim", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = "Firenvim",
		pattern = "text",
		callback = setup_firenvim,
	})
end
