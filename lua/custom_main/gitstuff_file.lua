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
    vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { noremap = true, silent = true, desc = "[G]it [P]review" }),
    vim.keymap.set("n", "<leader>gl", ":Gitsigns preview_hunk_inline<CR>", { noremap = true, silent = true, desc = "[G]it [P]review" }),
    vim.keymap.set("n", "<leader>gs", ":Gitsigns stage_hunk<CR>", { noremap = true, silent = true, desc = "[G]it [S]tage hunk" }),
    vim.keymap.set("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", { noremap = true, silent = true, desc = "[G]it [R]eset hunk" }),
    vim.keymap.set("n", "<leader>gi", ":Gitsigns prev_hunk<CR>", { noremap = true, silent = true, desc = "[G]it hunk previous" }),
    vim.keymap.set("n", "<leader>go", ":Gitsigns next_hunk<CR>", { noremap = true, silent = true, desc = "[G]it hunk next" }),
    vim.keymap.set("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { noremap = true, silent = true, desc = "[G]it toggle [B]lame line" }),
    -- vim.keymap.set("n", "<leader>gb", function() package.loaded.gitsigns.blame_line{full=true} end,
    --                { noremap = true, silent = true, desc = "[G]it [B]lame line" }),
  },

  --TODO: I can use also gitblame that could be better for seeing blame stuff
  --for this perhape "APZelos/blamer.nvim"

  -- This is diffview, for visual effects for gitdiff
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("diffview.actions") -- Load actions inside config
      -- local lib = require("diffview.lib") -- load liv inside config
      -- local view = lib.get_current_view()

      local function toggle_diffviewhistorypanal()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match("diffview:///panels/") then
          actions.toggle_files() -- If inside the file panel, close it
        else
          actions.focus_files() -- If inside DiffviewFileHistory, open the file panel
        end
      end

      -- local function safe_cycle_layout()
      --   local bufname = vim.api.nvim_buf_get_name(0)
      --   vim.bo[bufname].modifiable = true
      --   -- Try cycling the layout
      --   actions.cycle_layout()
      --   -- Restore original modifiable state
      --   vim.bo[bufname].modifiable = false
      -- end

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
            { "n", "<tab><tab>",     actions.select_next_entry,           { desc = "Open the diff for the next file" } },
            { "n", "<s-tab><s-tab>", actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
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
            { { "n", "xx" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "xx" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
            { "n",          "g?",   actions.help({ "view", "diff3" }),  { desc = "Open the help panel" } },
          },
          diff4 = {
            -- Mappings in 4-way diff layouts
            { { "n", "xx" }, "1do",  actions.diffget("base"),            { desc = "Obtain the diff hunk from the BASE version of the file" } },
            { { "n", "xx" }, "2do",  actions.diffget("ours"),            { desc = "Obtain the diff hunk from the OURS version of the file" } },
            { { "n", "xx" }, "3do",  actions.diffget("theirs"),          { desc = "Obtain the diff hunk from the THEIRS version of the file" } },
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
            { "n", "<c-s>",          actions.stage_all,                      { desc = "Stage all entries" } },
            { "n", "UU",             actions.unstage_all,                    { desc = "Unstage all entries" } },
            { "n", "L",              actions.open_commit_log,                { desc = "Open the commit log panel" } },
            { "n", "<c-b>",          actions.scroll_view(-0.25),             { desc = "Scroll the view up" } },
            { "n", "<c-f>",          actions.scroll_view(0.25),              { desc = "Scroll the view down" } },
            { "n", "<tab><tab>",        actions.select_next_entry,           { desc = "Open the diff for the next file" } },
            -- { "n", "<tab>",        actions.select_next_entry,             { desc = "Open the diff for the next file" } },
            { "n", "<s-tab><s-tab>",    actions.select_prev_entry,           { desc = "Open the diff for the next file" } },
            -- { "n", "<s-tab>",        actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
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
          -- This is for getting like ref logs, its the File History Log panal 
          file_history_panel = {
            -- This one is inside list for reglog type data, not in buffer
            { "n", "g!",            actions.options,                     { desc = "Open the option panel" } },
            { "n", "<C-A-d>",       actions.open_in_diffview,            { desc = "Open the entry under the cursor in a diffview" } },
            { "n", "y",             actions.copy_hash,                   { desc = "Copy the commit hash of the entry under the cursor" } },
            { "n", "L",             actions.open_commit_log,             { desc = "Show commit details" } },
            { "n", "XX",            actions.restore_entry,               { desc = "CAUTION: Restore file to the state from the selected entry(revert and removes untracked files)" } },
            -- { "n", "zo",            actions.open_fold,                   { desc = "Expand fold" } },
            -- { "n", "zc",            actions.close_fold,                  { desc = "Collapse fold" } },
            -- { "n", "W",            actions.toggle_fold,                 { desc = "Toggle fold" } },
            { "n", "O",             actions.open_all_folds,              { desc = "Expand all folds" } },
            { "n", "W",             actions.close_all_folds,             { desc = "Collapse all folds" } },
            { "n", "j",             actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>",        actions.next_entry,                  { desc = "Bring the cursor to the next file entry" } },
            { "n", "k",             actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<up>",          actions.prev_entry,                  { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<cr>",          actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "o",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "l",             actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "<2-LeftMouse>", actions.select_entry,                { desc = "Open the diff for the selected entry" } },
            { "n", "<c-p>",         actions.scroll_view(-0.25),          { desc = "Scroll the view up" } },
            { "n", "<c-n>",         actions.scroll_view(0.25),           { desc = "Scroll the view down" } },
            { "n", "<tab>",         actions.select_next_entry,           { desc = "Open the diff for the next file" } },
            { "n", "<s-tab>",       actions.select_prev_entry,           { desc = "Open the diff for the previous file" } },
            -- { "n", "[F",            actions.select_first_entry,          { desc = "Open the diff for the first file" } },
            -- { "n", "]F",            actions.select_last_entry,           { desc = "Open the diff for the last file" } },
            -- { "n", "gf",            actions.goto_file_edit,              { desc = "Open the file in the previous tabpage" } },
            { "n", "gss",           actions.goto_file_split,             { desc = "Open the file in a new split" } },
            { "n", "gf",            actions.goto_file_tab,               { desc = "Open the file in a new tabpage" } },
            -- { "n", "<leader>e",     actions.focus_files,                 { desc = "Bring focus to the file panel" } },
            -- { "n", "<leader>b",     actions.toggle_files,                { desc = "Toggle the file panel" } },
            -- { "n", "gx",            safe_cycle_layout,                   { desc = "Cycle available layouts", noremap = true, silent = true } },
            { "n", "?",             actions.help("file_history_panel"),  { desc = "Open the help panel" } },
            -- to check for toggle in historyfilepanal
            { "n", "<leader>e", toggle_diffviewhistorypanal, { desc = "Toggle or Open File Panel in Diffview History", noremap = true, silent = true } },

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

  -- this is the setup we have for neogit to use it
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    -- config = true,
    config = function()
      local neogit = require("neogit")
      neogit.setup {
        -- git_services = {
        --   ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
        --   ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
        --   ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
        --   ["azure.com"] = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
        -- },

        -- -- Table of settings to never persist. Uses format "Filetype--cli-value"
        -- ignored_settings = {
        --   "NeogitPushPopup--force-with-lease",
        --   "NeogitPushPopup--force",
        --   "NeogitPullPopup--rebase",
        --   "NeogitCommitPopup--allow-empty",
        --   "NeogitRevertPopup--no-edit",
        -- },

        -- Configure highlight group features
        highlight = {
          italic = true,
          bold = true,
          underline = true
        },

        -- Set to false if you want to be responsible for creating _ALL_ keymappings
        use_default_keymaps = false,
        -- Change the default way of opening neogit
        kind = "tab", -- floation as option too
        notification_icon = "󰊢",
        status = {
          show_head_commit_hash = true,
          recent_commit_count = 10,
          HEAD_padding = 10,
          HEAD_folded = false,
          mode_padding = 3,
          mode_text = {
            M = "Mod:",
            N = "New:",
            A = "Added:",
            D = "Del:",
            C = "Copi:",
            U = "Updated:",
            R = "Renamed:",
            DD = "Unmerged",
            AU = "Unmerged",
            UD = "Unmerged",
            UA = "Unmerged",
            DU = "Unmerged",
            AA = "Unmerged",
            UU = "Unmerged",
            ["?"] = "",
          },
        },
        commit_editor = {
          kind = "tab",
          show_staged_diff = true,
          -- Accepted values:
          -- "split" to show the staged diff below the commit editor
          -- "vsplit" to show it to the right
          -- "split_above" Like :top split
          -- "vsplit_left" like :vsplit, but open to the left
          -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
          staged_diff_split_kind = "split",
          spell_check = true,
        },
        commit_select_view = {
          kind = "tab",
        },
        commit_view = {
          kind = "vsplit",
          verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
        },
        log_view = {
          kind = "tab",
        },
        rebase_editor = {
          kind = "auto",
        },
        reflog_view = {
          kind = "tab",
        },
        merge_editor = {
          kind = "auto",
        },
        description_editor = {
          kind = "auto",
        },
        tag_editor = {
          kind = "auto",
        },
        preview_buffer = {
          kind = "floating_console",
        },
        popup = {
          kind = "split",
        },
        stash = {
          kind = "tab",
        },
        refs_view = {
          kind = "tab",
        },
        signs = {
          -- { CLOSED, OPENED }
          hunk = { "", "" },
          item = { " ▸", " ▾" },
          section = { ">", "v" },
        },

        -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
        integrations = {
          -- If enabled, use telescope for menu selection rather than vim.ui.select.
          -- Allows multi-select and some things that vim.ui.select doesn't.
          telescope = nil,
          -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
          -- The diffview integration enables the diff popup.
          --
          -- Requires you to have `sindrets/diffview.nvim` installed.
          diffview = nil,

          -- If enabled, uses fzf-lua for menu selection. If the telescope integration
          -- is also selected then telescope is used instead
          -- Requires you to have `ibhagwan/fzf-lua` installed.
          fzf_lua = nil,
        },
        sections = {
          -- Reverting/Cherry Picking
          sequencer = {
            folded = false,
            hidden = false,
          },
          untracked = {
            folded = false,
            hidden = false,
          },
          unstaged = {
            folded = false,
            hidden = false,
          },
          staged = {
            folded = false,
            hidden = false,
          },
          stashes = {
            folded = true,
            hidden = false,
          },
          unpulled_upstream = {
            folded = true,
            hidden = false,
          },
          unmerged_upstream = {
            folded = false,
            hidden = false,
          },
          unpulled_pushRemote = {
            folded = true,
            hidden = false,
          },
          unmerged_pushRemote = {
            folded = false,
            hidden = false,
          },
          recent = {
            folded = true,
            hidden = false,
          },
          rebase = {
            folded = true,
            hidden = false,
          },
        },

        -- Powerfull and use with caution
        mappings = {
          commit_editor = {
            ["q"] = "Close",
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
            ["<m-p>"] = "PrevMessage",
            ["<m-n>"] = "NextMessage",
            ["<m-r>"] = "ResetMessage",
          },
          commit_editor_I = {
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
          },
          rebase_editor = {
            ["p"] = "Pick",
            ["r"] = "Reword",
            ["e"] = "Edit",
            ["s"] = "Squash",
            ["f"] = "Fixup",
            ["x"] = "Execute",
            ["d"] = "Drop",
            ["b"] = "Break",
            ["q"] = "Close",
            ["<cr>"] = "OpenCommit",
            ["gk"] = "MoveUp",
            ["gj"] = "MoveDown",
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
            ["[c"] = "OpenOrScrollUp",
            ["]c"] = "OpenOrScrollDown",
          },
          rebase_editor_I = {
            ["<c-c><c-c>"] = "Submit",
            ["<c-c><c-k>"] = "Abort",
          },
          finder = {
            ["<cr>"] = "Select",
            ["<c-c>"] = "Close",
            ["<esc>"] = "Close",
            ["<c-n>"] = "Next",
            ["<c-p>"] = "Previous",
            ["<down>"] = "Next",
            ["<up>"] = "Previous",
            ["<tab>"] = "InsertCompletion",
            ["<space>"] = "MultiselectToggleNext",
            ["<s-space>"] = "MultiselectTogglePrevious",
            ["<c-j>"] = "NOP",
            ["<ScrollWheelDown>"] = "ScrollWheelDown",
            ["<ScrollWheelUp>"] = "ScrollWheelUp",
            ["<ScrollWheelLeft>"] = "NOP",
            ["<ScrollWheelRight>"] = "NOP",
            ["<LeftMouse>"] = "MouseClick",
            ["<2-LeftMouse>"] = "NOP",
          },
          -- Setting any of these to `false` will disable the mapping.
          popup = {
            ["?"] = "HelpPopup",
            ["A"] = "CherryPickPopup",
            ["dd"] = "DiffPopup",
            ["M"] = "RemotePopup",
            ["P"] = "PushPopup",
            ["X"] = "ResetPopup",
            ["Z"] = "StashPopup",
            ["ii"] = "IgnorePopup",
            ["tt"] = "TagPopup",
            ["bb"] = "BranchPopup",
            ["B"] = "BisectPopup",
            ["ww"] = "WorktreePopup",
            ["cc"] = "CommitPopup",
            ["ff"] = "FetchPopup",
            ["L"] = "LogPopup",
            ["mm"] = "MergePopup",
            ["pp"] = "PullPopup",
            ["rr"] = "RebasePopup",
            ["vv"] = "RevertPopup",
          },
          status = {
            ["j"] = "MoveDown",
            ["k"] = "MoveUp",
            ["O"] = "OpenTree",
            ["q"] = "Close",
            ["<Esc>"] = "Close",
            ["I"] = "InitRepo",
            ["1"] = "Depth1",
            ["2"] = "Depth2",
            ["3"] = "Depth3",
            ["4"] = "Depth4",
            ["Q"] = "Command",
            ["<tab><tab>"] = "Toggle",
            ["<CR>"] = "Toggle",
            ["xx"] = "Discard",
            ["ss"] = "Stage",
            ["S"] = "StageUnstaged",
            ["<c-s>"] = "StageAll",
            ["uu"] = "Unstage",
            ["K"] = "Untrack",
            ["U"] = "UnstageStaged",
            ["y"] = "ShowRefs",
            ["$"] = "CommandHistory",
            ["Y"] = "YankSelected",
            ["<c-r>"] = "RefreshBuffer",
            ["<cr>"] = "GoToFile",
            ["o"] = "GoToFile",
            ["<c-f>"] = "PeekFile",
            ["<c-v>"] = "VSplitOpen",
            ["<c-x>"] = "SplitOpen",
            ["<c-t>"] = "TabOpen",
            ["{"] = "GoToPreviousHunkHeader",
            ["}"] = "GoToNextHunkHeader",
            ["[c"] = "OpenOrScrollUp",
            ["]c"] = "OpenOrScrollDown",
            ["<c-k>"] = "PeekUp",
            ["<c-j>"] = "PeekDown",
            ["<c-n>"] = "NextSection",
            ["<c-p>"] = "PreviousSection",
          },
        },
      }
    -- setting mapping for neogit
    vim.keymap.set("n", "<leader>gn", ":Neogit<CR>", { noremap = true, silent = true, desc = "[G]it [N]eogit" })
    vim.keymap.set("n", "<leader>gc", ":NeogitCommit<CR>", { noremap = true, silent = true, desc = "[G]it [C]ommit Neogit" })

    end,
  },
}
