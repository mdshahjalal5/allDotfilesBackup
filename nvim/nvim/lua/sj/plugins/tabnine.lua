-- ~/.config/nvim/lua/plugins/tabnine.lua

return {
	{
		"codota/tabnine-nvim",
		build = function()
			vim.fn.system({
				"bash",
				"-c",
				"curl -fsSL https://raw.githubusercontent.com/codota/tabnine-nvim/master/dl_binaries.sh | TIMEOUT=1800 bash",
			})
		end,
		-- Load immediately instead of on InsertEnter to help with initialization
		lazy = false,
		priority = 1000,
		config = function()
			-- Enable debug logging
			vim.g.tabnine_debug = true

			local tabnine = require("tabnine")

			-- Add startup verification
			local function verify_tabnine_startup()
				local status = require("tabnine.status").status()
				if status:match(".*loading.*") then
					vim.defer_fn(verify_tabnine_startup, 1000)
				else
					vim.notify("Tabnine is ready: " .. status, vim.log.levels.INFO)
				end
			end

			tabnine.setup({
				disable_auto_comment = true,
				accept_keymap = "<Tab>",
				dismiss_keymap = "<C-]>",
				debounce_ms = 300, -- Reduced debounce time
				suggestion_color = { gui = "#808080", cterm = 244 },
				exclude_filetypes = { "TelescopePrompt", "NvimTree" },
				-- Enable logging to help debug
				log_file_path = vim.fn.stdpath("cache") .. "/tabnine.log",

				suggestion_position = "auto",
				show_numbers = true,
				show_language = true,
				show_engine = true,
				use_fallback = true, -- Enable fallback

				-- Enhanced status configuration
				statusline = {
					enabled = true,
					status = function()
						local status = require("tabnine.status").status()
						if status:match(".*loading.*") then
							return "TabNine Loading..."
						end
						return status
					end,
				},
			})

			-- Start verification after a short delay
			vim.defer_fn(verify_tabnine_startup, 3000)

			-- Add some keymaps to help with debugging
			vim.keymap.set("n", "<leader>tr", function()
				require("tabnine").restart()
				vim.notify("Tabnine restarted", vim.log.levels.INFO)
			end, { desc = "Restart Tabnine" })

			vim.keymap.set("n", "<leader>ts", function()
				local status = require("tabnine.status").status()
				vim.notify("Tabnine status: " .. status, vim.log.levels.INFO)
			end, { desc = "Check Tabnine Status" })
		end,
	},
}
