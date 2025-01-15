return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			labels = "asdfghjklqwertyuiopzxcvbnm",
			search = {
				mode = "exact",
				forward = true,
				wrap = true,
				incremental = false,
				exclude = {
					"prompt",
					"tabline",
					"statusline",
					-- "cmdline",
				},
			},
			label = {
				uppercase = true,
				before = false,
				after = true,
				style = "overlay",
				reuse = "all",
				rainbow = {
					enabled = true,
					shade = 5,
				},
			},
			jump = {
				jumplist = true,
				pos = "start",
				autojump = false,
				inclusive = true,
				highlight = true,
			},
			modes = {
				char = {
					enabled = true,
					jump_labels = true,
					multi_line = true,
					autohide = false,
					keys = {
						"j", -- Forward search
						"k", -- Backward search
						"h", -- Forward till
						"l", -- Backward till
						";", -- Repeat
						",", -- Reverse
					},
				},
				treesitter = {
					labels = "abcdefghijklmnopqrstuvwxyz",
					jump = { pos = "range" },
					search = { incremental = true },
					label = { before = true, after = true, style = "inline" },
				},
			},
			window = {
				current = true,
				other = true,
			},
		},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<C-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
			{
				"<leader>j",
				mode = { "n" },
				function()
					require("flash").jump({ search = { mode = "search" } })
				end,
				desc = "Flash Search Mode",
			},
			{
				"<leader>t",
				mode = { "n" },
				function()
					require("flash").jump({ search = { mode = "treesitter" } })
				end,
				desc = "Flash Treesitter Mode",
			},
		},
	},
}
