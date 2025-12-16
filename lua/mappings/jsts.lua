vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
    local co = vim.api.nvim_replace_termcodes("<c-o>", true, false, true)
    local cr = vim.api.nvim_replace_termcodes("<CR>", true, false, true)

    vim.g.maplocalleader = ","
    -- console log the variable
    vim.keymap.set("n", "<localleader>cl", function()
      vim.cmd("normal! diwiconsole.log(`" .. co .. "p: ${" .. co .. "p}`);")
    end)
    vim.keymap.set("n", "<localleader>nl", function()
      vim.cmd("normal! diwiif (" .. co .. "p == null) {" .. cr .. cr .. "}" .. co .. "k")
    end)
    vim.keymap.set("n", "<localleader>rc", function()
      vim.cmd(
        "normal! diwiinterface " ..
        co ..
        "pProps {" ..
        cr ..
        "}" ..
        cr ..
        cr ..
        "export const " .. co .. "p = ({}: " .. co .. "pProps) => {" .. cr .. "}"
      )
    end)
    -- generate useState
    vim.keymap.set("n", "<localleader>us", function()
      vim.cmd(
        "normal! diwiconst [" .. co .. "p, set" .. co .. "p] = useState()"
      )
    end)
  end
})
