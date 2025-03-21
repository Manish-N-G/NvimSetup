-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>:q!<CR>]], { noremap = true, silent = true })

local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the position to center the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  -- It checks if the buffer (buf) is valid before creating a new one:
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal", -- No borders or extra UI elements
    border = "rounded",
  }

  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  -- Prevents invalid window access:-
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
      -- vim.fn.jobwait({vim.b.terminal_job_id}, 500) -- Wait up to 500ms for job to start
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
  vim.cmd('normal i')
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set({'n','t'}, '<C-/>', toggle_terminal)
