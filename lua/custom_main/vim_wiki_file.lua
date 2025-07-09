-- Note: general shortcut is leader ww for me
-- lobal variables to track the floating window and buffer
local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

-- Set terminal keymaps for closing the window using <Esc><Esc>
local function set_terminal_keymaps(bufnr)
  -- Only set the keymaps if we're in the floating window buffer
  if vim.api.nvim_get_current_buf() == bufnr then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<esc><esc>", [[<C-\><C-n>:q!<CR>]], { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(bufnr, "i", "<esc><esc>", "<Esc>:q!<CR>", { noremap = true, silent = true })
  end
end

-- Autocmd for setting terminal keymaps after opening VimwikiIndex or other Vimwiki files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    set_terminal_keymaps(bufnr)
  end,
})

-- Create floating window with provided options or defaults
local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create or reuse the buffer
  local buf
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    vim.bo[buf].bufhidden = "wipe" -- Set buffer to wipe when closed
  end

  -- Window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Open floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- Toggle terminal: open or hide the floating window with VimwikiIndex
local toggle_window = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    -- Create new floating window and open VimwikiIndex
    state.floating = create_floating_window { buf = state.floating.buf }
    vim.cmd("VimwikiIndex")
    set_terminal_keymaps(state.floating.buf)  -- Set keymaps after opening the floating window
  else
    -- Close the existing floating window
    vim.api.nvim_win_hide(state.floating.win)
  end
  vim.cmd('normal i')  -- Ensure we stay in insert mode after opening the terminal
end

-- Keymaps for opening and selecting Vimwiki files in the floating window
return {
  {
    'vimwiki/vimwiki',
  },

  -- Open Vimwiki Index in Floating Window
  vim.keymap.set('n', '<leader>ww', function()
    toggle_window()
  end, { desc = "Open Vimwiki Index in Floating Window" }),

  -- Select and Open a Vimwiki File
  vim.keymap.set('n', '<leader>wc', function()
    local wiki_path = vim.g.vimwiki_list[1].path or "~/vimwiki"
    local files = vim.fn.glob(wiki_path .. "/*.md", false, true)

    if #files == 0 then
      vim.notify("No Vimwiki files found!", vim.log.levels.WARN)
      return
    end

    -- Show a selection menu
    vim.ui.select(files, { prompt = "Select a Vimwiki file:" }, function(choice)
      if choice then
        -- Open the selected file inside the floating window
        state.floating = create_floating_window { buf = state.floating.buf }
        vim.cmd("edit " .. vim.fn.fnameescape(choice))

        -- Ensure keymaps are set after opening the file in the floating window
        -- This is important so that the terminal keymaps are applied for the new floating buffer
        vim.api.nvim_create_autocmd("BufEnter", {
          once = true,
          buffer = state.floating.buf,
          callback = function()
            set_terminal_keymaps(state.floating.buf)  -- Set keymaps after switching to the file
          end,
        })
      end
    end)
  end, { desc = "Choose and open a Vimwiki file in Floating Window" }),

  -- -- Close terminal with <Esc><Esc> in terminal mode for floating window only
  -- vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>:q!<CR>]], { noremap = true, silent = true }),
  -- vim.keymap.set("t", "<C-q>", [[<C-\><C-n>]], { noremap = true, silent = true }),
}

