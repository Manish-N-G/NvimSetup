-- pring('Base.lua')
-- vim.cmd 'autocmd!' -- Clear all autocommands in the current group

-- Set the file format
vim.opt.fileformats = { 'unix', 'dos' }

-- Set <space> as the leader key -- See ':help mapleader'
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--TODOM: Add the correct file path
vim.opt.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.local/state/nvim/undo'

--NOTE: not sure we need to add this. Have to see in the future
-- Set the script encoding
vim.scriptencoding = 'utf-8'
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'

-- Set to true if you have nerd font installed.
vim.g.have_nerd_font = true

-- Settings options. For help see :help vim.opt, :help option-list
vim.opt.number = true

vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes' --shows signs before line number column if exists

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--vim.opt.list = true
--vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

--To allow for transparency
vim.opt.termguicolors = true

vim.opt.title = true
vim.opt.hlsearch = true

vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
--vim.opt.backupskup = '/tmp/*,/private/tmp/*'
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
--vim.opt.tabstop = 2
vim.opt.wrap = false -- no wrap line
vim.opt.backspace = 'start,eol,indent'
vim.opt.path:append { '**' } --Finding files - search down into subfolders
-- vim.opt.wildignore:append {'*node_modules/*'} --ignore this

-- Turn of paste mode when leaving insert
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})
