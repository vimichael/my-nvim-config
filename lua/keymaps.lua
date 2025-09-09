local km = vim.keymap.set

-- remaps
vim.g.mapleader = " "
vim.g.maplocalleader = ","

km("n", "<C-h>", "<C-w>h")
km("n", "<C-j>", "<C-w>j")
km("n", "<C-k>", "<C-w>k")
km("n", "<C-l>", "<C-w>l")

-- because [e goes to the next error
-- for consistency
km("n", "[s", "]s")
km("n", "]s", "[s")

-- window manips
km("n", "=", [[<cmd>vertical resize +5<cr>]])
km("n", "-", [[<cmd>vertical resize -5<cr>]])
km("n", "+", [[<cmd>horizontal resize +5<cr>]])
km("n", "^", [[<cmd>horizontal resize +5<cr>]])

-- move selections
km("v", "J", ":m '>+1<CR>gv=gv") -- Shift visual selected line down
km("v", "K", ":m '<-2<CR>gv=gv") -- Shift visual selected line up
km("n", "<leader>t", "bv~")

-- colorscheme picker
km("n", "<C-n>", ":Telescope colorscheme<CR>")


km("n", "<C-d>", "<C-d>zz")
km("n", "<C-u>", "<C-u>zz")
km("n", "<C-f>", "<C-f>zz")
km("n", "<C-b>", "<C-b>zz")
km("n", "Y", "yy")

-- autocomplete in normal text
km("i", "<C-f>", "<C-x><C-f>", { noremap = true, silent = true })
km("i", "<C-n>", "<C-x><C-n>", { noremap = true, silent = true })
km("i", "<C-l>", "<C-x><C-l>", { noremap = true, silent = true })

-- spell check
km("n", "<leader>ll", ":setlocal spell spelllang=en_us<CR>")

-- lsp setup
km("n", "K", vim.lsp.buf.hover)
km("n", "gd", vim.lsp.buf.definition)
km("n", "gD", vim.lsp.buf.declaration)
km("n", "gr", function()
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
        km("n", "<Tab>", function()
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

        km("n", "<S-Tab>", function()
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

km({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

km({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})

-- see error
km("n", "<leader>e", vim.diagnostic.open_float)

-- go to errors
km("n", "[e", vim.diagnostic.goto_next)
km("n", "]e", vim.diagnostic.goto_next)
