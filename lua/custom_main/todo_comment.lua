return {
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = false, -- diable signs icons
      keywords = {
        -- Define your custom type
        TODOM = {
          -- icon = "🔍", -- choose an icon for the custom type
          color = "#EDCB40",                                -- assign a color
          -- other aliases or synonyms
          alt = { "todomanish", "Todomanish", "TODOMANISH", "TodoManish", "todom", "Todom" }
        },
        -- TODOM: or todomanish, there are custom types.
      },
      merge_keywords = true, -- merge the custom types with existing ones
    },
    config = function(_, opts)
      require('todo-comments').setup(opts)

      -- Add key mappings for todo-comments
      local map = vim.keymap.set
      local opts_new = { noremap = true, silent = true }
      local todo = require('todo-comments')

      -- Search for TODOs in the current file
      map('n', '<leader>ft', ':TodoTelescope<CR>', opts_new)

      -- Search for TODOs in the current buffer
      map('n', '<leader>tt', ':TodoQuickFix<CR>', opts_new)

      -- Highlight all TODOs in the current buffer
      map('n', '<leader>th', ':TodoLocList<CR>', opts_new)

      -- Set keymaps
      local keymap = vim.keymap
      keymap.set('n', '<leader>tn', function()
        todo.jump_next()
      end, { desc = 'Next todo comment' })

      keymap.set('n', '<leader>tp', function()
        todo.jump_prev()
      end, { desc = 'Previous todo comment' })
    end,
  },
}
--[[
-- This function allows you to find special comments that we need
-- in order to find and change parts of the code. The tage we can use are
local todofile = {}

todofile.setup = function()
  local todo = require('todo-comments')

  -- Configure todo-comments
  todo.setup({
    keywords = {
      FIX = {
        icon = "", -- icon used for the sign, and in search results
        color = "info", -- info color
        alt = { "FIXME", "ISSUE" }, -- todomanish for all
        signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },

      -- Define your custom type
      TODOM = {
        icon = "🔍", -- choose an icon for the custom type
        color = "hint", -- assign a color
        alt = { "todomanish", "Todomanish", "TODOMANISH"} -- other aliases or synonyms
      },
      -- TODOM: or todomanish, there are custom types.
    },
    merge_keywords = true, -- merge the custom types with existing ones
  })

end

return todofile
-- TODO, BUG, HACK
--]]
