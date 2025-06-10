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
vim.g.python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.11/bin/python3"

vim.o.scrolloff = 5
vim.opt.ignorecase = true

-- hmmmmmmmmmmmmmmmmm not sure about this
-- vim.opt.colorcolumn = "80"

-- minor visual changes to panes
vim.opt.fillchars =
{ vert = " ", horiz = " ", horizup = " ", horizdown = " ", vertleft = " ", vertright = " ", verthoriz = " " }
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- because [e goes to the next error
-- for consistency
vim.keymap.set("n", "[s", "]s")
vim.keymap.set("n", "]s", "[s")

-- window manips
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]]) -- make the window biger vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]]) -- make the window smaller vertically

-- vim.cmd("set guicursor=n-v-c:block-blinkon1,i-ci:ver25")
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

-- move selections
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up
vim.keymap.set("n", "<leader>t", "bv~")

-- colorscheme picker
vim.keymap.set("n", "<C-n>", ":Telescope colorscheme<CR>")

-- remaps
vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")
vim.keymap.set("n", "Y", "yy")

-- autocomplete in normal text
vim.keymap.set("i", "<C-f>", "<C-x><C-f>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-n>", "<C-x><C-n>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<C-x><C-l>", { noremap = true, silent = true })

-- spell check
vim.keymap.set("n", "<leader>ll", ":setlocal spell spelllang=en_us<CR>")

-- lsp setup
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", function()
  -- Trigger the LSP references function and populate the quickfix list
  vim.lsp.buf.references()

  vim.defer_fn(function()
    -- Set up an autocmd to remap keys in the quickfix window
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "qf", -- Only apply this mapping in quickfix windows
      callback = function()
        -- Remap <Enter> to jump to the location and close the quickfix window
        vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>:cclose<CR>", { noremap = true, silent = true })
        vim.api.nvim_buf_set_keymap(0, "n", "q", ":cclose<CR>", { noremap = true, silent = true })

        -- Set up <Tab> to cycle through quickfix list entries
        vim.keymap.set("n", "<Tab>", function()
          local current_idx = vim.fn.getqflist({ idx = 0 }).idx
          local qflist = vim.fn.getqflist() -- Get the current quickfix list
          if current_idx >= #qflist then
            vim.cmd("cfirst")
            vim.cmd("wincmd p")
          else
            vim.cmd("cnext")
            vim.cmd("wincmd p")
          end
        end, { noremap = true, silent = true, buffer = 0 })

        vim.keymap.set("n", "<S-Tab>", function()
          local current_idx = vim.fn.getqflist({ idx = 0 }).idx
          if current_idx < 2 then
            vim.cmd("clast")
            vim.cmd("wincmd p")
          else
            vim.cmd("cprev")
            vim.cmd("wincmd p")
          end
        end, { noremap = true, silent = true, buffer = 0 })
      end,
    })
  end, 0)
end)

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

-- see error
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

-- go to errors
vim.keymap.set("n", "[e", vim.diagnostic.goto_next)
vim.keymap.set("n", "]e", vim.diagnostic.goto_next)

function leave_snippet()
  if
      ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
      and require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require("luasnip").session.jump_active
  then
    require("luasnip").unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua leave_snippet()
]])

-- make help and man open up on the side instead above
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "help", "man" },
  command = "wincmd L",
})

vim.lsp.set_log_level("warn")

vim.cmd([[
autocmd! DiagnosticChanged * lua vim.diagnostic.setloclist({open = false}) ]])

vim.api.nvim_create_augroup("CreateDirs", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "CreateDirs",
  pattern = "*",
  callback = function()
    local file_path = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(file_path) == 0 then
      vim.fn.mkdir(file_path, "p")
    end
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.md" },
  callback = function()
    vim.cmd("set linebreak")
    -- vim.cmd("colorscheme zenburn")
  end,
  nested = true,
})

vim.api.nvim_create_autocmd({ "FileType", "VimEnter", "BufReadPre" }, {
  pattern = { "*.md" },
  callback = function()
    vim.schedule(function()
      vim.keymap.set("n", "<space>md", ":lua OpenInObsidian()<CR>", { noremap = true, silent = true })
      vim.o.shiftwidth = 2
    end)
  end,
})

function OpenInObsidian()
  local file = vim.fn.expand("<cfile>")                  -- Get the file path under the cursor
  if file:match("%.md$") then
    local vault = "notes"                                -- Replace with your Obsidian vault name
    local vault_path = vim.fn.expand("~/path/to/vault/") -- Adjust to your vault path
    local relative_path = file:gsub(vault_path, "")      -- Get relative path from vault root
    local obsidian_url = "obsidian://open?vault=" .. vault .. "&file=" .. vim.fn.fnameescape(relative_path)
    vim.fn.system({ "open", obsidian_url })              -- macOS 'open' command to launch Obsidian
  else
    vim.cmd("silent open " .. file)                      -- Default behavior (for non-.md files)
  end
end

vim.api.nvim_create_user_command("FormatDisable", function(args)
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

vim.diagnostic.config({
  virtual_text = true,
})
