-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local Keys = {} -- this is to load functions

--NOTE: in ghostty, ctrl+z will force quit all without saving if nvim is open
-------------------------------------------------------------------
-- NORMAL MODE::
-- Do not yank with n
keymap.set('n', 'x', '"_x')

-- Increment/Decrement --works over a number only
keymap.set('n', '+', '<C-a>')
keymap.set('n', '-', '<C-x>')

--Select all lines in the this buffer ( as windows)
-- keymap.set('n', '<C-a>', 'gg<S-v>G') -- Cant use this. This will override the increment function

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap.set('n', '<leader>hh', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Diagnostic keymaps
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--New tab and toggle tabs
keymap.set('n', 'te', ':tabedit<CR>', opts)
keymap.set('n', 'tx', ':tabclose<CR>', opts)
keymap.set('n', '<tab>l', ':tabnext<CR>', opts)
keymap.set('n', '<tab>h', ':tabprev<CR>', opts)

-- Split window
keymap.set('n', 'ss', ':split<CR><C-w>w', opts)
keymap.set('n', 'sv', ':vsplit<CR><C-w>w', opts)
keymap.set('n', 'sx', ':close<CR>') -- Close the current window
keymap.set('n', 'se', '<C-w>=', opts)

--  See `:help wincmd` for a list of all window commands
--keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', ':wincmd j<CR>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', ':wincmd k<CR>', { desc = 'Move focus to the upper window' })

-- Quick save without quitting
keymap.set('n', 'ZS', ':w<CR>', opts) -- Note: ZZ is save and quit. ZQ is to quit without saving

-- TODOM: need to see why i dont get is as I wish. Have to come back here.
-- Resize windows
keymap.set('n', '<C-left>', ':vertical resize -2<CR>', { desc = 'resize left add' })
keymap.set('n', '<C-right>', ':vertical resize +2<CR>', { desc = 'resize right add' })
keymap.set('n', '<C-up>', ':resize +2<CR>', { desc = 'resize top add' })
keymap.set('n', '<C-down>', ':resize -2<CR>', { noremap = true, silent = true, desc = 'resize bottom add' })
-- keymap.set('n', '<S-C-down>', ':resize -2<CR>', { desc = 'resize botton add' }) -- how to equalize all?

-- Navigate between buffers, or files in dir
keymap.set('n', '<S-l>', ':bnext<CR>', opts)
keymap.set('n', '<S-h>', ':bprevious<CR>', opts)

-- open explorer on the side
-- keymap.set('n', '<leader>e', ':Lex 20<CR>')

-- vim.api.nvim_set_keymap('n', '<leader>v', '<C-v>', opts)

-- Move text up and down in Normal mode
-- keymap.set('n', '<A-k>', ':m .-1<CR>=', opts)
-- keymap.set('n', '<A-j>', ':m .+1<CR>=', opts)

-- mapping the same for s with leader s
-- keymap.set('n', '<leader>s', 'cl', { noremap = true })

-- Remap for source
keymap.set('n', '<A-s>', ':source<CR>', { desc = 'Source current file' })

-- toggle text wrap in window -- line wrap
keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- Move commands between diagnostics
keymap.set('n', '<leader>dh', vim.diagnostic.goto_prev, { desc = '[D]iagnostics previous' })
keymap.set('n', '<leader>dl', vim.diagnostic.goto_next, { desc = '[D]iagnostics previous' })

-- Load Lazy
keymap.set('n', '<leader>ll', ':Lazy<CR>', { desc = '[D]iagnostics previous' })

-- Open nvim config from anywhere in nvim
keymap.set("n", "<leader>nc", ":tabnew | edit ~/.config/nvim/<CR>", { desc = "Edit Neovim Config" })
--------------------------------------------------------
-- INSERT MODE::
-- Remap for Esc keys
keymap.set('i', 'gj', '<Esc>', { silent = true }) -- typing gj to quickly escape to normal mod

-- Moving during insent mode -- Move with hjkl keys
keymap.set('i', '<S-A-h>', '<left>')
keymap.set('i', '<S-A-j>', '<down>')
keymap.set('i', '<S-A-k>', '<up>')
keymap.set('i', '<S-A-l>', '<right>')

--------------------------------------------------------
-- COMMAND MODE::
-- Remap for source
keymap.set('c', ':s<CR>', ':source<CR>', { desc = 'File source' })

keymap.set('c', 'gj', '<Esc>', { desc = 'Exit terminal', noremap = true, silent = true })
--------------------------------------------------------
-- TERMINAL MODE::
-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
--TODOMANISH: have to see here
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--------------------------------------------------------
-- VISUAL MODE::
keymap.set('v', 'gj', '<Esc>', { silent = true }) -- typing jl quickly now will escape from visual also
-- Indent in visual mode
keymap.set('v', '<', '<gv', opts) -- also available in normal mode
keymap.set('v', '>', '>gv', opts) -- also available in normal mode
-- NOTE: my pressing 'o', you can toggle between top and bottom positions

-- Move text up and down in Visual Mode -- needs some work
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", opts)
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", opts)

-- Keep register from changing when printed from yanked
keymap.set('v', 'p', '"_dP', opts)

--------------------------------------------------------
-- Visual Block Mode:
-- mode block up and down
keymap.set('x', 'gj', '<Esc>', { silent = true }) -- typing jl quickly now will escape from visual also

keymap.set('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap.set('x', 'K', ":move '<-2<CR>gv-gv", opts)
--------------------------------------------------------------
---- NOTE: This section is to local keymaps for specific functions based on where the values are called.

function Keys.Mymethod()
  keymap.set('n', '<A-l>', ':Lazy<CR>', opts)
end

function Keys.Myresize() -- Loading this to over write any function not working
  keymap.set('n', '<S-C-left>', ':vertical resize -2<CR>', { desc = 'resize left add' })
  keymap.set('n', '<S-C-right>', ':vertical resize +2<CR>', { desc = 'resize right add' })
  keymap.set('n', '<S-C-top>', ':resize +2<CR>', { desc = 'resize top add' })
  keymap.set('n', '<S-C-down>', ':resize -2<CR>', { desc = 'resize botton add' })
end

-- Return the table of functions
return Keys
