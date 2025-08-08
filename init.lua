local utils = require("utils")

local colorscheme = "custom"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- vim opts
require("vimopts")

-- lazy.nvim setup
require("lazy").setup("plugins", {
  defaults = {
    lazy = false,
  },
})

vim.api.nvim_create_augroup("ConjureRemoveSponsor", { clear = true })

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "conjure-log-*",
  group = "ConjureRemoveSponsor",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    vim.schedule(function()
      vim.api.nvim_buf_call(buf, function()
        vim.cmd("silent! %s/; Sponsored by @.*//e")
      end)
    end)
  end,
})



vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { llvm = "ll" } })
vim.filetype.add({ extension = { purs = "purescript" } })
vim.filetype.add({
  extension = { nim = "nim" },
  filename = { ["Nim"] = "nim" },
})

-- stop zig qf list from opening >:(
vim.g.zig_fmt_parse_errors = 0

-- treesitter config
local config = require("nvim-treesitter.configs")
config.setup({
  ignore_install = {},
  ensure_installed = {
    "typst",
    "purescript",
    "nix",
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
    "prisma",
    "haskell",
    "zig",
    "gleam",
    "wgsl",
    "php",
    "nim",
    "sql",
    "markdown",
    "latex",
    "gdscript",
    "gdshader",
  },
  highlight = {
    enable = true,
  },
  indent = { enable = true },
  modules = {},
  sync_install = true,
  auto_install = true,
})

-- language specific mappings go here
require("cool_stuff")
require("mappings")

utils.color_overrides.setup_colorscheme_overrides()

-- theme
vim.cmd("colorscheme " .. colorscheme)

utils.fix_telescope_parens_win()
utils.dashboard.setup_dashboard_image_colors()

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.cmd("CsvViewEnable display_mode=border")
    vim.opt_local.wrap = false
  end,
})
