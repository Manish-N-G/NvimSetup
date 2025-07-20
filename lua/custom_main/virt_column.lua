-- This plugin shows a vertical bar so that we can try to keep code text
-- without a certain max character limit
-- This does not auto break line but its meant only for visual appeal
-- For auto break line, we could set this
-- :set wrap linebreak breakindent textwidth=100
return {
  "lukas-reineke/virt-column.nvim",
  opts = {
    -- char = "╎",
    -- char = ".",
    char = "ˈ",
    -- char = "│",
    -- char = "┊",
    virtcolumn = "100"
  },
  event = "BufReadPre",
}
