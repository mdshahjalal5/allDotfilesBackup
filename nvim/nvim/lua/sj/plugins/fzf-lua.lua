return {
	"ibhagwan/fzf-lua",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("fzf-lua").setup({})

		vim.keymap.set("n", "<leader>ag", function()
			-- Run `gh repo list` to fetch repositories and use fzf-lua for selection
			local repos =
				vim.fn.systemlist("gh repo list Apollo-Level2-Web-Dev --json name --jq '.[].name' --limit 200")
			if #repos == 0 then
				print("No repositories found.")
				return
			end

			-- Use fzf-lua to select a repository
			require("fzf-lua").fzf_exec(repos, {
				prompt = "Select a repo: ",
				actions = {
					-- Default action: Copy repo name to clipboard
					["default"] = function(selected)
						vim.fn.system("echo -n " .. selected[1] .. " | xclip -selection clipboard")
					end,
					-- Ctrl-o: Open the repo in the browser
					["ctrl-o"] = function(selected)
						vim.fn.system("gh repo view Apollo-Level2-Web-Dev/" .. selected[1] .. " --web")
					end,
					-- Ctrl-r: Clone the selected repo
					["ctrl-r"] = function(selected)
						vim.fn.system("git clone https://github.com/Apollo-Level2-Web-Dev/" .. selected[1])
					end,
				},
			})
		end, { desc = "Open GitHub Repo Manager" })
	end,
}
