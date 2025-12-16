vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    local co = vim.api.nvim_replace_termcodes("<c-o>", true, false, true)
    local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    local tab = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)

    vim.g.maplocalleader = ","
    -- console log the variable
    vim.keymap.set("n", "<localleader>nl", function()
      vim.cmd("normal! diwiif err != nil {" .. cr .. cr .. "}" .. co .. "k" .. tab)
    end)
  end
})
