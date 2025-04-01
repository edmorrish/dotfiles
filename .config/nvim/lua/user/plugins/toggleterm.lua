return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {--[[ things you want to change go here]]
		},
		config = function()
			require("toggleterm").setup({
				open_mapping = "<leader>t",
				direction = "horizontal",
			})
		end,
	},
}
