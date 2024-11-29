return {
	{
		"justinmk/vim-sneak",
		lazy = true, -- Loads the plugin on demand
		event = { "BufReadPost", "BufNewFile" }, -- Optional: Load on file events
		config = function()
			-- Optional configuration
			-- Enable label mode for an EasyMotion-like experience
			vim.g["sneak#label"] = 1
		end,
	},
}
