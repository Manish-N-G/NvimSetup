-- With Treesitter, we can highlight parts of a paragraph, or scope, We can see the whole
-- tree list that is being used.
return { -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'python', 'json', 'rust', 'go', 'pascal', 'bash', 'c', 'diff', 'html', 'lua', 'luadoc',
        'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Install parsers synchronously ( only applied ti 'ensure_installed'.
      sync_install = false,
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true, -- keeps Treesitter hghlighting enabled
        additional_vim_regex_highlighting = false, -- Prevent conflict with your colorscheme
        disable = {},  -- list of laungauges that will be disabled.
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      -- autotag = {
      --   enable = true,
      -- },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- We need to be in visual mode to use this
          -- command:InspectTree, this will allow you to see the tree
          -- this helps with highlighting the node, sentence, and the scope
          init_selection = '<C-m>',
          node_incremental = '<C-m>',
          scope_incremental = '<C-s>',
          node_decremental = '<bs>',
        },
      },
    },
    vim.api.nvim_set_keymap('n', '<leader>it', ':InspectTree<CR>',
      { noremap = true, silent = true, desc = "Inspect Tree" })
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
