-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--NOTE: added this group to specify the specific color
vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#CA6649', fg = '#EBEFDD', bold = true }) -- Yellow background, black text

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank {
      higroup = 'YankHighlight', -- I added this, if not working, can remove
      timeout = 200, -- I added this, if not working, can remove
    }
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
