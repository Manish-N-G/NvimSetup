-- This plugin creates a quick way to search and navigate in a buffer that is visible on the screen
-- NOTE: if we need to reload a package again without going out of nvim and restarting it again, we 
-- can try to set the cache back to zero. The way we can do this is by calling the command in the
-- command line as follows
-- :lua package.loaded["custom_main.flash_file"] = nil
-- This way we can reload it again by saying :lua require"custom_main.flash_file"
return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        -- Disable Flash from overriding f/F/t/T
        char = {
          enabled = false,
        },
      },
    },
    keys = {
      { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
      -- Remove or comment out T so it doesn't override native T
      -- You can also explicitly disable it like this:
      { "T", mode = { "n", "x", "o" }, false },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
    },
  },
}
