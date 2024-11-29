return {
	"frankroeder/parrot.nvim",
	dependencies = { "ibhagwan/fzf-lua", "nvim-lua/plenary.nvim" },
	config = function()
		require("parrot").setup({
			providers = {
				-- openai = { api_key = os.getenv("OPENAI_API_KEY") },
				openai = { api_key = "AIzaSyBV_arVEmBh63rNTkC8o9u-VjMqiuYOiIU" },
				-- add other providers here as needed
			},
		})
	end,
}
