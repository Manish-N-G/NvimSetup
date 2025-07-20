-- this file is to have additional rust features
-- the crates.nvim is used to get the crates version that are available online
return {
  {
    'saecki/crates.nvim',
    ft = {"rust", "toml"},
    config = function(_,opts)
      local crates = require('crates')
      crates.setup(opts)
      crates.show()
    end,
  },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^5',
  --   lazy = false,
  --   ["rust-analyzer"] = {
  --     cargo = {
  --       allFeatures = true,
  --     },
  --   },
  -- },
}
