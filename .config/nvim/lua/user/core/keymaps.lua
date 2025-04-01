vim.g.mapleader = ","

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with JK" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Config reloading
keymap.set("n", "<leader>ve", function()
	local builtin = require("telescope.builtin")
	builtin.find_files({ search_dirs = { vim.fn.stdpath("config") } })
end, { desc = "Open vim config" })

keymap.set("n", "<space>", "za")
