-- To have guide lines when we indent
return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable lukas-reineke/indent-blankline.nvim
    -- See :help ibl
    main = 'ibl',
    opts = {},
    config = function()
      local highlight = {
        "RainbowRed",
        "RainbowYellow",
        "RainbowBlue",
        "RainbowOrange",
        "RainbowGreen",
        "RainbowViolet",
        "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
      local indent_setup = {}

      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      indent_setup.setup = function()
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#875b5b", bg = "NONE", nocombine = true})
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#665a43", bg = "NONE", nocombine = true})
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#335c7d", bg = "NONE", nocombine = true})
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#8a4504", bg = "NONE", nocombine = true})
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#455936", bg = "NONE", nocombine = true})
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#704b7a", bg = "NONE", nocombine = true})
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#286870", bg = "NONE", nocombine = true})

          -- Transparent highlights for indent-blankline and nvim-tree
          -- vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#444444", bg = "NONE", nocombine = true })
          -- vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#444444", bg = "NONE", nocombine = true })
          -- vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#444444", bg = "NONE" })
        end)


        -- This only allows for certain files to have indent active and default other files will not show
        -- It some are missing, we have to manually add it to this list here
        hooks.register(hooks.type.ACTIVE, function(bufnr)
          return vim.tbl_contains(
            { "lua", "pascal", "c", "python", "json", "vim", "rust", "go" },
            vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          )
        end)

        require("ibl").setup {
          indent = { highlight = highlight, char = '▏'},
          whitespace = {
            highlight = highlight,
            remove_blankline_trail = false,
          },
          scope = {
            enabled = false,
            exclude = {
              -- language = {
              --   -- "lua"
              -- },
            },
          },
        }
        -- require "ibl".overwrite {
        --   exclude = { 
        --     filetypes = {
        --       '' 
        --     },
        --   },
        -- }

        -- This is general indentation, not blankline, to have specific indentation settings for different file types:
        local set_indent = function(filetype, opts)
          -- Function to set indentation for specific file types
          vim.api.nvim_create_autocmd('FileType', {
            pattern = filetype,
            callback = function()
              for k, v in pairs(opts) do
                vim.bo[k] = v
              end
            end
          })
        end
        -- Set indentation for Pascal files
        set_indent('pascal', { shiftwidth = 3 })
      end
      indent_setup.setup()
    end
  },
}
