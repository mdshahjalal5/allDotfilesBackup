return {
	{
		"tpope/vim-dadbod",
		lazy = true,
		cmd = { "DB" }, -- Load only when the :DB command is invoked
		config = function()
			-- Optional: Set a default database URL or other configurations here
			-- vim.g.dadbod_manage_dbext = 1 -- Example for dbext interop
		end,
	},
}
