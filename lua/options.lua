-- general settings
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set ts=2")
vim.cmd("set cmdheight=0")
vim.cmd("set termguicolors")
vim.cmd("set scrolloff=5")
vim.cmd("autocmd FileType sql setlocal noautoindent")
vim.cmd("autocmd FileType sql setlocal nosmartindent")
vim.cmd("autocmd FileType sql setlocal nocindent")
vim.cmd("set signcolumn=no")
vim.cmd("set foldmethod=expr")
vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
vim.cmd("set foldlevel=99")
vim.cmd("set foldnestmax=1")
vim.cmd("set foldopen-=hor")

vim.g.python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.11/bin/python3"
vim.opt.exrc = true
vim.o.scrolloff = 5
vim.opt.ignorecase = true
vim.g.zig_fmt_parse_errors = 0

vim.diagnostic.config({
  virtual_text = true,
})

-- minor visual changes to panes
vim.opt.fillchars =
{ vert = " ", horiz = " ", horizup = " ", horizdown = " ", vertleft = " ", vertright = " ", verthoriz = " " }

vim.opt.guicursor = "n-v-c:block-blinkon1-CursorInsert,i:block-CursorInsert"

vim.api.nvim_create_user_command("Setwd", function()
  vim.cmd("cd " .. vim.fn.expand("%:p:h"))
end, {})

local utils = require("utils")
local os_name = utils.get_os()

if os_name == "windows" then
  vim.cmd("set shell=powershell")
else
  vim.cmd("set shell=/bin/zsh")
end
vim.cmd("set shellcmdflag=-c")
vim.cmd("set shellquote=")
vim.cmd("set shellxquote=")

-- stop right-shift when errors/warning appear
vim.o.signcolumn = "no"
vim.o.completeopt = "menuone,noselect,preview"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.bo.softtabstop = 2

vim.lsp.set_log_level("warn")

vim.cmd([[
autocmd! DiagnosticChanged * lua vim.diagnostic.setloclist({open = false}) ]])

function OpenInObsidian()
  local file = vim.fn.expand("<cfile>")
  if file:match("%.md$") then
    local vault = "notes"
    local vault_path = vim.fn.expand("~/path/to/vault/")
    local relative_path = file:gsub(vault_path, "")
    local obsidian_url = "obsidian://open?vault=" .. vault .. "&file=" .. vim.fn.fnameescape(relative_path)
    vim.fn.system({ "open", obsidian_url })
  else
    vim.cmd("silent open " .. file)
  end
end

vim.api.nvim_create_user_command("FormatDisable", function(_)
  vim.g.disable_autoformat = true
end, {
  desc = "Disable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

vim.api.nvim_command('autocmd VimResized * wincmd =')
