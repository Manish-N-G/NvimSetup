-- This file can allow us to collapse folds and toggle them back open
return {
  {
    "kevinhwang91/promise-async", -- Required dependency
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    -- event = "BufRead", -- Load when a buffer is read (lazy loading)
    config = function()

      -- Function to modify virtual text in folds
      local function fold_text_handler(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰡏 ---- %d "):format(endLnum - lnum) -- Number of folded lines
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0

        -- Process existing virtual text
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)

            -- Add padding if needed
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end

        -- Append the number of folded lines
        table.insert(newVirtText, { suffix, "MoreMsg" }) -- "MoreMsg" controls highlight
        return newVirtText
      end

      -- Configure UFO
      require("ufo").setup({
        provider_selector = function(_, _, _)
          return { "lsp", "indent" } -- Use LSP and indent as fold providers
        end,
        fold_virt_text_handler = fold_text_handler, -- Attach the function here
      })

      -- Keymaps
      vim.keymap.set("n", "zA", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zC", require("ufo").closeAllFolds, { desc = "Close all folds" })

      -- Optional: Customize fold text display
      vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸]]
      vim.o.foldcolumn = "0"  -- Show fold column (1 char wide)
      vim.o.foldlevel = 99     -- Start with all folds open
      vim.o.foldlevelstart = 99
      vim.o.foldenable = false  -- Enable folding
    end
  }
}


-- local M = { "kevinhwang91/nvim-ufo" }
-- M.event = "VeryLazy"
-- M.dependencies = {
--   "kevinhwang91/promise-async",
--   "luukvbaal/statuscol.nvim",
-- }
--
-- M.config = function()
--   local builtin = require("statuscol.builtin")
--   local cfg = {
--     setopt = true,
--     relculright = true,
--     segments = {
--     { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa", hl = "Comment" },
--     { text = { "%s" }, click = "v:lua.ScSa" },
--     { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
--     },
--   }
--
--   require("statuscol").setup(cfg)
--   vim.o.foldcolumn = "0" -- '0' is not bad
--   vim.o.foldlevel = 99  -- Using ufo provider need a large value, feel free to decrease the value
--   vim.o.foldlevelstart = 99
--   vim.o.foldenable = true
--   vim.o.fillchars = [[eob: ,fold: ,foldopen:▾,foldsep: ,foldclose:▸]]
--
--   -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
--   vim.keymap.set("n", "zA", require("ufo").openAllFolds)
--   vim.keymap.set("n", "zC", require("ufo").closeAllFolds)
--
--   local handler = function(virtText, lnum, endLnum, width, truncate)
--     local newVirtText = {}
--     local suffix = (" 󰡏 ---- %d "):format(endLnum - lnum)
--     local sufWidth = vim.fn.strdisplaywidth(suffix)
--     local targetWidth = width - sufWidth
--     local curWidth = 0
--     for _, chunk in ipairs(virtText) do
--       local chunkText = chunk[1]
--       local chunkWidth = vim.fn.strdisplaywidth(chunkText)
--       if targetWidth > curWidth + chunkWidth then
--         table.insert(newVirtText, chunk)
--       else
--         chunkText = truncate(chunkText, targetWidth - curWidth)
--         local hlGroup = chunk[2]
--         table.insert(newVirtText, { chunkText, hlGroup })
--         chunkWidth = vim.fn.strdisplaywidth(chunkText)
--         -- str width returned from truncate() may less than 2nd argument, need padding
--         if curWidth + chunkWidth < targetWidth then
--           suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
--         end
--         break
--       end
--       curWidth = curWidth + chunkWidth
--     end
--     table.insert(newVirtText, { suffix, "MoreMsg" })
--     return newVirtText
--   end
--
--   local ftMap = {
--     -- typescriptreact = { "lsp", "treesitter" },
--     -- python = { "indent" },
--     -- git = "",
--   }
--
--   require("ufo").setup({
--     fold_virt_text_handler = handler,
--     close_fold_kinds = {},
--     -- close_fold_kinds = { "imports", "comment" },
--     -- provider_selector = function(bufnr, filetype, buftype)
--     --   -- if you prefer treesitter provider rather than lsp,
--     --   -- return ftMap[filetype] or {'treesitter', 'indent'}
--     --   return ftMap[filetype]
--     --   -- return { "treesitter", "indent" }
--     --
--     --   -- refer to ./doc/example.lua for detail
--     -- end,
--
--     provider_selector = function(_, _, _)
--       return { "lsp", "indent" } -- Use LSP and indent as fold providers
--     end,
--
--     preview = {
--       win_config = {
--         border = { "", "─", "", "", "", "─", "", "" },
--         winhighlight = "Normal:Folded",
--         winblend = 0,
--       },
--       mappings = {
--         scrollU = "<C-k>",
--         scrollD = "<C-j>",
--         jumpTop = "[",
--         jumpBot = "]",
--       },
--     },
--   })
--   vim.keymap.set("n", "zA", require("ufo").openAllFolds)
--   vim.keymap.set("n", "zC", require("ufo").closeAllFolds)
--   -- vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
--   -- vim.keymap.set("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
-- end
-- return M
