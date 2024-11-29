-- plugins.lua or init.lua
return {
	{
		"nvim-lua/plenary.nvim", -- Dependency for nvim-spectre
		lazy = true, -- Load this plugin lazily
	},
	{
		"nvim-pack/nvim-spectre",
		lazy = true, -- Load this plugin lazily
		config = function()
			require("spectre").setup({
				default = {
					replace = {
						cmd = "oxi", -- Set default replace command to "oxi"
					},
				},
			})

			-- Key mappings
			vim.keymap.set("n", "<leader>S", '<cmd>lua require("spectre").toggle()<CR>', {
				desc = "Toggle Spectre",
			})
			vim.keymap.set("n", "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("v", "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
				desc = "Search current word",
			})
			vim.keymap.set("n", "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
				desc = "Search on current file",
			})
		end,
	},
}
