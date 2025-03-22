-- this allows me to see images in the buffer
return {
  "3rd/image.nvim",
  config = function()
    require("image").setup({
      backend = "kitty",     -- Use "kitty" since Ghostty supports it
      kitty_method = 'normal', -- Required for kitty backend
      processor = "magick_cli",
      integrations = {
        markdown = { enabled = true },
        neorg = { enabled = true },
      },
      -- hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    })
  end
}
