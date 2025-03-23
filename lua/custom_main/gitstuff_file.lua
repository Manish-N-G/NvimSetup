-- Alternatively, use `config = function() ... end` for full control over the configuration.
-- Here is a more advanced example wher we pass config
-- options to 'gitsigns.nvim'. This is equivalent to the following Lua:
--   require('gitsigns').setup({})

-- See ':help gitsigns' to understand what the configuration keys do
-- If you prefer to call `setup` explicitly, use:
-- return {
--   'lewis6991/gitsigns.nvim',
--   config = function()
--     require('gitsigns').setup {
--       -- Your gitsigns configuration here
--     }
--   end,
-- }
--
-- NOTE: for more info, you can check out kickstart/plugin/gitsigs to see full config

return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '▏' },
        change = { text = '▏' },
        delete = { text = '▏' },
        topdelete = { text = '▏' },
        changedelete = { text = '▏' },
      },
      on_attach = function()
        -- Set highlight colors for Git signs
        vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#8BC34A' }) -- Green for added lines
        vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#E5D96F' }) -- Yellow for changes
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#D35954' }) -- Red for deletions
      end,
    },
    -- to preview hunk shortcut 
    vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk_inline<CR>", { noremap = true, silent = true, desc = "[G]it [P]review" }),
    vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { noremap = true, silent = true, desc = "[G]it [S]tage hunk" }),
    vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true, desc = "[G]it [R]eset hunk" }),
    vim.keymap.set("n", "<leader>gi", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true, desc = "[G]it hunk previous" }),
    vim.keymap.set("n", "<leader>go", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true, desc = "[G]it hunk next" }),
  },
  -- This is diffview, for visual effects for gitdiff
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("diffview.actions") -- Load actions inside config

      require("diffview").setup({
        diff_binaries = false,    -- Show diffs for binariesdiff_binaries = false, 
        use_icons = true, -- Set to false if you want to disable icons
        enhanced_diff_hl = true, -- See |diffview-config-enhanced_diff_hl|
        show_help_hints = true,   -- Show hints for how to open the help panel
        -- git_cmd = { "git" },      -- The git executable followed by default args.
        -- hg_cmd = { "hg" },        -- The hg executable followed by default args.
        watch_index = true,       -- Update views and index buffers when the git index changes.

        file_panel = {
          listing_style = "list",             -- One of 'list' or 'tree'
          win_config = {                      -- See |diffview-config-win_config|
            position = "left",
            width = 35,
          },
        },

        keymaps = {
          disable_defaults = true, -- Disable the default keymaps
          view = { -- This is the main buffer, were we can see the files text
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            { "n", "<tab><tab>",     actions.select_next_entry,              { desc = "Open the diff for the next file" } },
            { "n", "<s-tab><s-tab>", actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
            { "n", "<c-w>s",      actions.goto_file_split,                { desc = "Open the file in a new split" } },
            { "n", "ss",         ':diffsplit<CR>',                        { desc = "Open the file in a new split" } },
            { "n", "<leader>gf",  actions.goto_file_tab,                  { desc = "Open the file in a new tabpage" } },
            { "n", "<leader>e",   actions.toggle_files,                   { desc = "Toggle the file panel." } },
            { "n", "gx",          actions.cycle_layout,                   { desc = "Cycle through available layouts." } },
            { "n", "g?",          actions.help("view"),                   { desc = "Open the help panel" } },
            -- have to see why ? does not work anymore for search
            { "n", "[x",          actions.prev_conflict,                  { desc = "In the merge-tool: jump to the previous conflict" } },
            { "n", "]x",          actions.next_conflict,                  { desc = "In the merge-tool: jump to the next conflict" } },
            { "n", "<leader>co",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
            { "n", "<leader>ct",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
            { "n", "<leader>cb",  actions.conflict_choose("base"),        { desc = "Choose the BASE version of a conflict" } },
            { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
            { "n", "dx",          actions.conflict_choose("none"),        { desc = "Delete the conflict region" } },
            { "n", "<leader>cO",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
            { "n", "<leader>cT",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
            { "n", "<leader>cB",  actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
            { "n", "<leader>cA",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
            { "n", "dX",          actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
          },
          diff1 = {
            -- Mappings in single window diff layouts
            { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
          },
          diff2 = {
            -- Mappings in 2-way diff layouts
            { "n", "?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
          },
          diff3 = {
            -- Mappings in 3-way diff layouts
            { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
            { "n",          "g?",   actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            { { "n", "x" }, "1do",  actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
            { { "n", "x" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "x" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
            { "n",          "g?",   actions.help({ "view", "diff4" }),  { desc = "Open the help panel" } },
          },
          file_panel = { -- This is for the explorer part
            { "n", "j",              actions.next_entry,                     { desc = "Bring the cursor to the next file entry" } },
            { "n", "k",              actions.prev_entry,                     { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<cr>",           actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
            { "n", "o",              actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
            { "n", "<2-LeftMouse>",  actions.select_entry,                   { desc = "Open the diff for the selected entry" } },
            { "n", "-",              actions.toggle_stage_entry,             { desc = "Stage / unstage the selected entry" } },
            { "n", "ss",             actions.toggle_stage_entry,             { desc = "stage selected file/ unstage" } },
            { "n", "SS",             actions.stage_all,                      { desc = "Stage all entries" } },
            { "n", "UU",             actions.unstage_all,                    { desc = "Unstage all entries" } },
            { "n", "L",              actions.open_commit_log,                { desc = "Open the commit log panel" } },
            { "n", "<c-b>",          actions.scroll_view(-0.25),             { desc = "Scroll the view up" } },
            { "n", "<c-f>",          actions.scroll_view(0.25),              { desc = "Scroll the view down" } },
            { "n", "<tab><tab>",        actions.select_next_entry,              { desc = "Open the diff for the next file" } },
            -- { "n", "<tab>",        actions.select_next_entry,              { desc = "Open the diff for the next file" } },
            { "n", "<s-tab><s-tab>",    actions.select_prev_entry,              { desc = "Open the diff for the next file" } },
            -- { "n", "<s-tab>",        actions.select_prev_entry,              { desc = "Open the diff for the previous file" } },
            { "n", "i",              actions.listing_style,                  { desc = "Toggle between 'list' and 'tree' views" } },
            { "n", "R",              actions.refresh_files,                  { desc = "Update stats and entries in the file list" } },
            { "n", "<leader>e",      actions.toggle_files,                   { desc = "Toggle the file panel" } },
            { "n", "gx",             actions.cycle_layout,                   { desc = "Cycle available layouts" } },
            -- { "n", "[x",             actions.prev_conflict,                  { desc = "Go to the previous conflict" } },
            -- { "n", "]x",             actions.next_conflict,                  { desc = "Go to the next conflict" } },
            { "n", "?",              actions.help("file_panel"),             { desc = "Open the help panel" } },
            -- { "n", "<leader>cO",     actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
            -- { "n", "<leader>cT",     actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
            -- { "n", "<leader>cB",     actions.conflict_choose_all("base"),    { desc = "Choose the BASE version of a conflict for the whole file" } },
            -- { "n", "<leader>cA",     actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
            -- { "n", "dX",             actions.conflict_choose_all("none"),    { desc = "Delete the conflict region for the whole file" } },
          },
-- This is for getting like ref logs :todom: 
          file_history_panel = {
            -- This one is inside list for reglog type data, not in buffer
            { "n", "g!",            actions.options,                     { desc = "Open the option panel" } },
            { "n", "<C-A-d>",       actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
            { "n", "y",             actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
            { "n", "L",             actions.open_commit_log,             { desc = "Show commit details" } },
            { "n", "X",             actions.restore_entry,               { desc = "Restore file to the state from the selected entry" } },
            { "n", "zo",            actions.open_fold,                   { desc = "Expand fold" } },
            { "n", "zc",            actions.close_fold,                  { desc = "Collapse fold" } },
            { "n", "h",             actions.close_fold,                  { desc = "Collapse fold" } },
            { "n", "za",            actions.toggle_fold,                 { desc = "Toggle fold" } },
            { "n", "zR",            actions.open_all_folds,              { desc = "Expand all folds" } },
            { "n", "zM",            actions.close_all_folds,             { desc = "Collapse all folds" } },
            { "n", "j",             actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>",        actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
            { "n", "k",             actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<up>",          actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<cr>",          actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "o",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "l",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "<2-LeftMouse>", actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "<c-b>",         actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
            { "n", "<c-f>",         actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
            { "n", "<tab>",         actions.select_next_entry,           { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>",       actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
            { "n", "[F",            actions.select_first_entry,          { desc = "Open the diff for the first file" } },
            { "n", "]F",            actions.select_last_entry,           { desc = "Open the diff for the last file" } },
            { "n", "gf",            actions.goto_file_edit,              { desc = "Open the file in the previous tabpage" } },
            { "n", "<C-w><C-f>",    actions.goto_file_split,             { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf",       actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
            { "n", "<leader>e",     actions.focus_files,                 { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b",     actions.toggle_files,                { desc = "Toggle the file panel" } },
            { "n", "g<C-x>",        actions.cycle_layout,                { desc = "Cycle available layouts" } },
            { "n", "?",             actions.help("file_history_panel"),  { desc = "Open the help panel" } },
          },
          option_panel = {
            { "n", "<tab>", actions.select_entry,          { desc = "Change the current option" } },
            { "n", "q",     actions.close,                 { desc = "Close the panel" } },
            { "n", "g?",    actions.help("option_panel"),  { desc = "Open the help panel" } },
          },
          help_panel = {
            { "n", "q",     actions.close,  { desc = "Close help menu" } },
            { "n", "<esc>", actions.close,  { desc = "Close help menu" } },
          },
        },
      })

      -- Function to toggle Diffview
      local function toggle_diffview()
        local view = require("diffview.lib").get_current_view()
        if view then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen")
        end
      end

      -- Function to toggle Diffviewhistory
      local function toggle_diffviewhistory()
        local view = require("diffview.lib").get_current_view()
        if view then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewFileHistory")
        end
      end

      -- Keybinding for toggling Diffview
      vim.keymap.set("n", "<leader>gv", toggle_diffview, { noremap = true, silent = true, desc = "Toggle Git Diff[V]iew" })
      vim.keymap.set("n", "<leader>gh", toggle_diffviewhistory, { noremap = true, silent = true, desc = "Toggle Git File[H]istory" })

    end,
  },
}
