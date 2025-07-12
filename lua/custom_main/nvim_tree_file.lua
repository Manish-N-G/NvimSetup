-- Disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Enable 24-bit colors
vim.opt.termguicolors = true

-- open explorer on the side
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle NvimTree" })

-- Ensure nvim-tree is installed before setting up
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  vim.notify("nvim-tree not found! Install it first.", vim.log.levels.ERROR)
  return
end
-- Custom on_attach function for key mappings
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  -- api.config.mappings.default_on_attach(bufnr)
  -- Set custom keybindings
  vim.keymap.set('n', '?',       api.tree.toggle_help,                opts('Help'))
  vim.keymap.set('n', 'o',       api.node.open.edit,                  opts('Open'))
  vim.keymap.set('n', '<CR>',    api.node.open.edit,                  opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  vim.keymap.set('n', 'rr',      api.fs.rename,                       opts('Rename'))
  vim.keymap.set('n', 'Y',       api.fs.copy.relative_path,           opts('Copy Relative Path'))
  vim.keymap.set('n', 'y',       api.fs.copy.filename,                opts('Copy Name'))
  vim.keymap.set('n', 'dd',      api.fs.remove,                       opts('Delete'))
  vim.keymap.set('n', 'aa',      api.fs.create,                       opts('Create File Or Directory'))
  vim.keymap.set('n', 'W',       api.tree.collapse_all,               opts('Collapse'))
  vim.keymap.set('n', 'M',       api.tree.toggle_no_bookmark_filter,  opts('Toggle Filter: No Bookmark'))
  vim.keymap.set('n', 'm',       api.marks.toggle,                    opts('Toggle Bookmark'))
  vim.keymap.set('n', '<Tab>p',  api.node.open.preview,               opts('Open Preview'))
  vim.keymap.set('n', '<C-v>',   api.node.open.vertical,              opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>',   api.node.open.horizontal,            opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<C-u>',   api.tree.change_root_to_parent,      opts('Change root DIR 1 UP'))
  vim.keymap.set('n', '<BS>',    api.node.navigate.parent_close,      opts('Close Directory'))
  vim.keymap.set('n', 'cc',      api.fs.copy.node,                    opts('Copy'))
  vim.keymap.set('n', 'xx',      api.fs.cut,                          opts('Cut'))
  vim.keymap.set('n', 'pp',      api.fs.paste,                        opts('Paste'))
  vim.keymap.set('n', 'P',       api.node.navigate.parent,            opts('Parent Directory'))
  vim.keymap.set('n', '<C-o>',   api.tree.change_root_to_node,        opts('CD root'))
  vim.keymap.set('n', '.',       api.tree.toggle_hidden_filter,       opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', '<tab>l',  ':wincmd l<CR>:tabnext<CR>',         opts('tab change next'))
  vim.keymap.set('n', '<tab>h',  ':wincmd h<CR>:tabprev<CR>',         opts('tab change prev'))

end

--TODOM: I need to see how to remove the stars on nvim tree. this perhaps doesnt look good?
-- Setup nvim-tree
nvim_tree.setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
    relativenumber = true, -- Enable relative line numbers
  },
  renderer = {
    -- group_empty = true,
    indent_markers = {
      enable = true,
    },
  },
  filters = {
    dotfiles = false,
  },
  on_attach = my_on_attach, -- Attach custom key mappings
  git = {
    ignore = false,
  },
  -- actions = {
  --   open_file = {
  --     window_picker = {
  --       enable = false,
  --     },
  --   },
  -- },
})

-- Transparent nvim-tree highlights In the following
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    local highlights = {
      "NvimTreeNormal",
      "NvimTreeNormalNC",
      "NvimTreeEndOfBuffer",
      "NvimTreeWinSeparator",
    }
    for _, hl in ipairs(highlights) do
      vim.api.nvim_set_hl(0, hl, { bg = "NONE" })
    end
  end,
})

-- Apply once immediately in case theme already loaded
local highlights = {
  "NvimTreeNormal",
  "NvimTreeNormalNC",
  "NvimTreeEndOfBuffer",
  "NvimTreeWinSeparator",
}
for _, hl in ipairs(highlights) do
  vim.api.nvim_set_hl(0, hl, { bg = "NONE" })
end
