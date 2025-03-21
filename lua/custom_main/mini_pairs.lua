return {
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- you can set command false is command mode causing problems
      -- skip autopairs when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopairs when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autoparis when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
      mapping = {
        ["`"] = false,
      },
    },
    config = function(_,opts)
      -- LazyVim.mini.pairs(opts)
      -- Since LazyVim is not a defined as global value
      -- we will use requre instead
      require("mini.pairs").setup(opts)
    end,
  }
}
