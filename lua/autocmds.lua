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

vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.cmd("CsvViewEnable display_mode=border")
    vim.opt_local.wrap = false
  end,
})

-- snippet things

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
