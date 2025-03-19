-- This loads nvim from a saved point.
return {
  {
    'rmagatti/auto-session', -- Plugin for managing sessions
    lazy = false,            -- Load the plugin immediately

    opts = {
      auto_restore_enabled = false,                                                 -- Disable automatic session restoration
      auto_session_suppress_dirs = { '/Desktop', '/Documents', '/Downloads', '/' }, -- Suppress sessions for these directories( security reasons )
      log_level = 'error',                                                          -- Suppress non-critical errors
    },

    config = function(_, opts)
      local auto_session = require('auto-session')
      auto_session.setup(opts)

      -- Keymaps for session management
      local keymap = vim.keymap
      keymap.set('n', '<leader>ar', function()
        pcall(vim.cmd, 'SessionRestore') -- Gracefully handle errors during session restore
      end, { desc = '[A]uto session [R]estore' })
      keymap.set('n', '<leader>as', '<cmd>SessionSave<CR>', { desc = '[A]uto session [S]ave' })

      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end,

  },
}
