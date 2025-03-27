return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',
    "theHamsta/nvim-dap-virtual-text",

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add all you debuggers you want here
  },

  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = 'Debug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = 'Debug: Step Out',
    },
  },

  config = function()
    local dap = require('dap')
    local dapui = require('dapui')


    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- for more information, see |:help nvim-dap-ui|
    -- dap ui setup
    require('dapui').setup(
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      -- icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      -- controls = {
      --   icons = {
      --     pause = '⏸',
      --     play = '▶',
      --     step_into = '⏎',
      --     step_over = '⏭',
      --     step_out = '⏮',
      --     step_back = 'b',
      --     run_last = '▶▶',
      --     terminate = '⏹',
      --     disconnect = '⏏',
      --   },
      -- },

    )
    -- require('dap...') -- all respective dubug adapters setups here

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.attach['dapui_config'] = dapui.open
    dap.listeners.before.launch['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close


    -- -- Install golang specific config
    -- require('dap-go').setup {
    --   delve = {
    --     -- On Windows delve must be run attached or it crashes.
    --     -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
    --     detached = vim.fn.has 'win32' == 0,
    --   },
    -- }

    -- vim.fn.sign_define('DapBreakpoint', { text='#', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint'})

    vim.keymap.set('n', '<leader>dt', ":DapUiToggle<CR>", { noremap = true, desc = "[D]apUi [T]oggle"})
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { noremap = true, desc = "[D]ap [B]reakpoint toggle"})
    vim.keymap.set('n', '<leader>dc', ":DapContinue<CR>", { noremap = true, desc = "[D]ap [C]ontinue"})
    vim.keymap.set('n', '<leader>dr', ":lua require('dapui').open({reset=true})<CR>", { noremap = true, desc = "[D]ap [R]eset"})
  end
}





