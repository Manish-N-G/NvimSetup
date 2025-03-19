-- return { -- Autoformat (old code)
--   {
--     'stevearc/conform.nvim',
--     event = { 'BufWritePre' },
--     cmd = { 'ConformInfo' },
--     keys = {
--       {
--         '<leader>f',
--         function()
--           print('yesss conformed')
--           require('conform').format({
--             async = true,
--             lsp_fallback = true, -- Use 'lsp_fallback' instead of 'lsp_format'
--           })
--         end,
--         mode = '',
--         desc = '[F]ormat buffer',
--       },
--       -- {
--       --   '<leader>v', -- Keybinding for visual block formatting
--       --   function()
--       --     -- Get the range of the visual selection
--       --     local start_pos = vim.fn.getpos "'<"
--       --     local end_pos = vim.fn.getpos "'>"
--       --     -- Convert to 0-indexed row and column
--       --     local start_row = start_pos[2] - 1
--       --     local start_col = start_pos[3] - 1
--       --     local end_row = end_pos[2] - 1
--       --     local end_col = end_pos[3] - 1
--       --     -- Format the selected range
--       --     require('conform').format {
--       --       async = true,
--       --       range = {
--       --         start = { start_row, start_col },
--       --         ['end'] = { end_row, end_col },
--       --       },
--       --     }
--       --   end,
--       --   mode = 'v', -- Only in visual mode
--       --   desc = '[F]ormat visual selection',
--       -- },
--     },
--     opts = {
--       notify_on_error = false,
--
--       -- NOTE: Uncomment to add format file when file is saved
--       -- format_on_save = function(bufnr)
--       --   -- Disable "format_on_save lsp_fallback" for languages that don't
--       --   -- have a well standardized coding style. You can add additional
--       --   -- languages here or re-enable it for the disabled ones.
--       --   local disable_filetypes = { c = true, cpp = true }
--       --   local lsp_format_opt
--       --   if disable_filetypes[vim.bo[bufnr].filetype] then
--       --     lsp_format_opt = 'never'
--       --   else
--       --     lsp_format_opt = 'fallback'
--       --   end
--       --   return {
--       --     timeout_ms = 500,
--       --     lsp_format = lsp_format_opt,
--       --   }
--       -- end,
--
--       formatters_by_ft = {
--         lua = {
--           {
--             command = 'stylua',
--             args = { '--preserve-line-break' },
--             stop_after_first_option = true, -- Use this to stop after the first formatter (needs to be added to all)
--           },
--         },
--         python = {
--            "black", "isort", stop_after_first_option = true },
--         javascript = { "prettierd", "prettier", stop_after_first_option = true },
--         -- Conform can also run multiple formatters sequentially
--         -- python = { "isort", "black" },
--
--         -- You can use 'stop_after_first' to run the first available formatter from the list
--         -- javascript = { "prettierd", "prettier", stop_after_first = true },
--       },
--     },
--   },
-- }

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fa',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat [A]ll in buffer',
      },
      --NOTE: This is already implemented by the plugin.
      --NOTE: Also, we can use '==' to auto indent code for a specific line or visual selection of lines
      --   {
      --     '<leader>v', -- Keybinding for visual block formatting
      --     function()
      --       -- Get the range of the visual selection
      --       local start_pos = vim.fn.getpos "'<"
      --       local end_pos = vim.fn.getpos "'>"
      --       -- Convert to 0-indexed row and column
      --       local start_row = start_pos[2] - 1
      --       local start_col = start_pos[3] - 1
      --       local end_row = end_pos[2] - 1
      --       local end_col = end_pos[3] - 1
      --       -- Format the selected range
      --       require('conform').format {
      --         async = true,
      --         range = {
      --           start = { start_row, start_col },
      --           ['end'] = { end_row, end_col },
      --         },
      --       }
      --     end,
      --     mode = 'v', -- Only in visual mode
      --     desc = '[F]ormat [A]ll visual selection',
      --   },
    },
    opts = {
      notify_on_error = false,
      -- NOTE: Uncomment to add format file when file is saved
      -- format_on_save = function(bufnr)
      --   -- Disable "format_on_save lsp_fallback" for languages that don't
      --   -- have a well standardized coding style. You can add additional
      --   -- languages here or re-enable it for the disabled ones.
      --   local disable_filetypes = { c = true, cpp = true }
      --   local lsp_format_opt
      --   if disable_filetypes[vim.bo[bufnr].filetype] then
      --     lsp_format_opt = 'never'
      --   else
      --     lsp_format_opt = 'fallback'
      --   end
      --   return {
      --     timeout_ms = 500,
      --     lsp_format = lsp_format_opt,
      --   }
      -- end,
      formatters_by_ft = {
        lua = {
          command = 'stylua',
          args = { '--preserve-line-break' },
          -- stop_after_first_option = true, -- Use this to stop after the first formatter (needs to be added to all)
        },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
}
