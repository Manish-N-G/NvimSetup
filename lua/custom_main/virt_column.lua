-- This plugin shows a vertical bar so that we can try to keep code text
-- without a certain max character limit
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
}
