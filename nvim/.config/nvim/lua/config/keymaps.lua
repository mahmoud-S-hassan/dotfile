local discipline = require("craftzdog.discipline")

discipline.cowboy()

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Do things without affecting the registers
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>c", '"_c')
keymap.set("n", "<Leader>C", '"_C')
keymap.set("v", "<Leader>c", '"_c')
keymap.set("v", "<Leader>C", '"_C')
--keymap.set("n", "<Leader>d", '"_d')
keymap.set("n", "<Leader>D", '"_D')
--keymap.set("v", "<Leader>d", '"_d')
keymap.set("v", "<Leader>D", '"_D')

-- Increment/decrement
-- keymap.set("n", "+", "<C-a>")
keymap.set("n", "=", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
-- keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("n", "<C-a>", function()
	if vim.fn.mode() == "v" then
		-- Exit visual mode
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
	else
		-- Select all text
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("ggVG", true, true, true), "n", true)
	end
end, { noremap = true, silent = true })

-- Prevent <C-a> from incrementing numbers
vim.keymap.set("v", "<C-a>", "<Esc>", { noremap = true, silent = true })

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
--keymap.set("n", "te", ":tabedit")
--keymap.set("n", "<tab>", ":tabnext<Return>", opts)
--keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-d>", function()
	vim.diagnostic.goto_next()
end, opts)

keymap.set("n", "<leader>r", function()
	require("craftzdog.hsl").replaceHexWithHSL()
end)

keymap.set("n", "<leader>i", function()
	require("craftzdog.lsp").toggleInlayHints()
end)

-- Copy the current line
keymap.set("n", "<S-A-j>", ":t.<CR>")
keymap.set("n", "<S-A-k>", ":t.<CR>")

keymap.set("n", "KK", "$")
keymap.set("n", "J", "^")
keymap.set("i", "jj", "<esc>")
keymap.set("i", "<A-s>", "<Esc>:w!<cr>")
keymap.set("n", "<A-s>", "<Esc>:w!<cr>")

--keymap.set("v", "yy", ":w !clip.exe<cr>")
keymap.set("n", "<C-\\>", ":ToggleTerm direction=float<cr>")

keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>")
keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>")
keymap.set("n", "<C-J>", ":TmuxNavigateDown<CR>")
keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>")
