return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
		"nvim-telescope/telescope-media-files.nvim",
	},
	config = function()
		require("telescope").setup({
			extensions = {
				media_files = {
					-- File types for preview
					filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mp4" },
					-- Use ripgrep for finding files
					find_cmd = "rg",
				},
			},
		})
		require("telescope").load_extension("media_files")
	end,
}
