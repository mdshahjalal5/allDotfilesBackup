return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		local fb_actions = require("telescope").extensions.file_browser.actions

		telescope.setup({
			extensions = {
				file_browser = {
					theme = "ivy",
					hijack_netrw = true, -- Use telescope-file-browser instead of netrw
					mappings = {
						["i"] = {
							["<C-h>"] = fb_actions.goto_home_dir, -- Go to home directory
							["<C-x>"] = function(prompt_bufnr)
								print("Custom action invoked!")
							end,
						},
						["n"] = {
							f = false, -- Unmap toggle_browser
							["<C-h>"] = fb_actions.goto_home_dir,
						},
					},
				},
			},
		})

		-- Load the extension
		telescope.load_extension("file_browser")

		-- Key mapping for quick access
		vim.keymap.set("n", "<space>fb", function()
			require("telescope").extensions.file_browser.file_browser({
				path = "%:p:h", -- Start in the current buffer's directory
				select_buffer = true,
			})
		end, { noremap = true, silent = true })
	end,
}
