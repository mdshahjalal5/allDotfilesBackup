return {
	-- Other plugin entries go here

	-- Harpoon Plugin Setup
	{
		"ThePrimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("harpoon").setup()
		end,
		keys = {
			{ "<space>mm", "<cmd>lua require('harpoon.mark').add_file()<CR>", desc = "Harpoon: Mark file" },
			{ "<space>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Harpoon: Quick Menu" },
		},
	},

	-- Telescope Plugin Setup
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup()
		end,
		keys = {
			{ "<space>rh", "<cmd>Telescope git_files<CR>", desc = "Telescope: Recent Git files" },
		},
	},
}
