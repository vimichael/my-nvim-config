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
