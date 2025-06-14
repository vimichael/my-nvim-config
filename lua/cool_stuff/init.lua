require("cool_stuff.chelpers").setup()
require("cool_stuff.ntsh").setup()
require("cool_stuff.game").setup()

-- keymaps for nts
vim.keymap.set("n", "[n", ":Nts<CR>")
vim.keymap.set("n", "[j", ":NtsJournal<CR>")

vim.api.nvim_create_user_command("Path", function()
  print(vim.fn.expand("%:p"))
end, {})
