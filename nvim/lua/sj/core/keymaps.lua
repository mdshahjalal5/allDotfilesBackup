-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Remap : to ; in normal, visual, and operator-pending modes
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("o", ";", ":", { noremap = true })
-- Increase/decrease split width with Alt+h and Alt+l
vim.api.nvim_set_keymap("n", "<A-l>", ":vertical resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-h>", ":vertical resize +2<CR>", { noremap = true, silent = true })

-- Increase/decrease split height with Alt+j and Alt+k
vim.api.nvim_set_keymap("n", "<A-j>", ":resize -2<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-k>", ":resize +2<CR>", { noremap = true, silent = true })
-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jj", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Remap : to ' in normal, visual, and operator-pending modes
vim.api.nvim_set_keymap("n", "'", ":", { noremap = true })
vim.api.nvim_set_keymap("v", "'", ":", { noremap = true })
vim.api.nvim_set_keymap("o", "'", ":", { noremap = true })
-- -- Increase/decrease split width with Alt+h and Alt+l
-- vim.api.nvim_set_keymap("n", "<A-l>", ":vertical resize -2<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<A-h>", ":vertical resize +2<CR>", { noremap = true, silent = true })
--
-- -- Increase/decrease split height with Alt+j and Alt+k
-- vim.api.nvim_set_keymap("n", "<A-j>", ":resize -2<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<A-k>", ":resize +2<CR>", { noremap = true, silent = true })
-- Resize splits with arrow keys in normal mode
vim.api.nvim_set_keymap("n", "<Up>", ":resize +2<CR>", { noremap = true, silent = true }) -- Increase height
vim.api.nvim_set_keymap("n", "<Down>", ":resize -2<CR>", { noremap = true, silent = true }) -- Decrease height
vim.api.nvim_set_keymap("n", "<Left>", ":vertical resize -2<CR>", { noremap = true, silent = true }) -- Decrease width
vim.api.nvim_set_keymap("n", "<Right>", ":vertical resize +2<CR>", { noremap = true, silent = true }) -- Increase width

-- Resize splits with arrow keys in visual mode
vim.api.nvim_set_keymap("x", "<Up>", ":resize +2<CR>", { noremap = true, silent = true }) -- Increase height
vim.api.nvim_set_keymap("x", "<Down>", ":resize -2<CR>", { noremap = true, silent = true }) -- Decrease height
vim.api.nvim_set_keymap("x", "<Left>", ":vertical resize -2<CR>", { noremap = true, silent = true }) -- Decrease width
vim.api.nvim_set_keymap("x", "<Right>", ":vertical resize +2<CR>", { noremap = true, silent = true }) -- Increase width
--funtion for calling utility it's understanding imp search in chatgpt
--function map(mode, key, cmd, opts)
--	vim.api.nvim_set_keymap(mode, key, cmd, opts or options)
--end
--map("n", "<C-r>", "<cmd>lua reload_nvim_conf()<CR>")

-- Map Alt+i to :wqa! in normal mode
vim.api.nvim_set_keymap("n", "<M-i>", ":wqa!<CR>", { noremap = true, silent = true })
