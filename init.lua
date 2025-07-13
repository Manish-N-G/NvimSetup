--[[ From: Kickstart
  If you don't know anything about Lua, a guide 10-15 minutes:
  - https://learnxinyminutes.com/docs/lua/

  After understanding a bit more about Lua, you can use :help lua-guide as a reference for how
  Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

   TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
  which is very useful when you're not exactly sure of what you're looking for.

  If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
-- NOTE: From here Manish, has added this changes
require 'custom_main.base'
-- This is for General Keymaps (loads keymaps that in file and not in function)
local keymap_file = require 'custom_main.keymaps_general'

-- Testing and seems that this is working properly
require 'custom_main.tj_floatterm'
-- TODOM: have to see online file perhaps. this looks like a good one. also have to have something
-- that allows me to fold files

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
--  this will help load highlighting and setup lazy package manager
require 'custom_main.lazy_additionals'

-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function,
  -- forcing the plugin to be loaded.
  -- NOTE: loaded from keymaps
  { config = keymap_file.Mymethod() }, -- Here config is a callback function

  require 'custom_main.gitstuff_file', -- gitsigns block

  -- this create a vertical line so that we can stay without the limit of code text characters
  require 'custom_main.virt_column', -- Added ventical line for text limin on page

  -- This allows me to use note taking here.
  require 'custom_main.vim_wiki_file', -- vim wiki, not taking

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  -- OR: Then, because we use the config key, the configuration only runs
  -- after the plugin has been loaded
  --  config = function() ... end

  require 'custom_main.which_key', -- which key block
  -- NOTE: Plugins can specify dependencies.

  -- this just maximized and mimimized the current buffer you are on currently
  require 'custom_main.maximizer_split_file',

  -- This plugin is simple to open a tree to see all undos that you have made
  require 'custom_main.undotree_file',

  -- This is to simple add plugin that can toggle scopes
  require 'custom_main.togglescope_ufo_file',

  -- { config = keymap_file.() }, -- Here config is a callback function
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin
  -- TODO: Some dependencies can work with telescope. Check how you can add them.
  -- Dont know as of now what have to be done.
  require 'custom_main.telescope_file', -- telescope block

  -- All LSP stuff here. Important file
  require 'custom_main.lsp_file', -- All Lsp configs

  -- Autoformat
  require 'custom_main.auto_format', -- autoformat block

  -- Autocompletion
  require 'custom_main.auto_completion', -- auto completion block

  -- ColorScheme all
  require 'custom_main.color_scheme_file.all',              -- ColorScheme all for download
  require 'custom_main.color_scheme_file.color_tokyonight', -- Color Scheme that is setup
  require 'custom_main.colorizer_file',                     -- Add color in hash for and rgb and other formats
  'HiPhish/rainbow-delimiters.nvim',                        -- Add different colors for delimiters
  -- { 'tribela/vim-transparent' }, -- Transparency

  -- Highlight todo, notes, etc in comments
  require 'custom_main.todo_comment', -- todocomment block

  -- Collection of various small independent plugins/modules
  require 'custom_main.mini_dependencies', -- mini dependencies block

  -- Treesitter. Highlight, edit, and navigate code
  require 'custom_main.treesitter_file', -- treesitter block

  -- This can activate auto sessions save and restore for the editor
  require 'custom_main.auto_session_save', -- auto_sessions block

  -- This plugin allows us to see images in the buffer
  require 'custom_main.3rd_image',

  -- NvimTree setup
  { -- Nvim tree taking from file
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("custom_main.nvim_tree_file")
    end
  },

  -- This is similar to autopairs. I will try this to see if its lighter
  require 'custom_main.mini_pairs',

  -- This is a debugger that can dubug code depending on what debugger adapters you have installed
  require 'custom_main.debugging_file', -- Debug code

  --NOTE: need to fix eventually
  --For Ghostty, we can add syntax highlighting
  -- require 'custom_main.ghostty_file',

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- added from custom_main

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from
  -- `lua/custom/plugins/*.lua`. This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
