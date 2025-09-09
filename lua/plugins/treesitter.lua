-- treesitter
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- treesitter config
    local config = require("nvim-treesitter.configs")
    config.setup({
      ignore_install = {},
      ensure_installed = {
        "typst",
        "purescript",
        "nim",
        "vimdoc",
        "go",
        "rust",
        "c",
        "lua",
        "python",
        "html",
        "css",
        "javascript",
        "typescript",
        "haskell",
        "zig",
        "gleam",
        "wgsl",
        "php",
        "nim",
        "sql",
        "markdown",
        "latex",
      },
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      modules = {},
      sync_install = true,
      auto_install = true,
    })
  end
}
