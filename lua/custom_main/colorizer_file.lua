-- This plugin allows you to see the colors in hex and other formats in nvim
return {
  {
    'norcalli/nvim-colorizer.lua',
    -- can you hipatters also, installed as lazy extra
    enabled = false,
    config = function()
      require('colorizer').setup()
    end,
  }
}
