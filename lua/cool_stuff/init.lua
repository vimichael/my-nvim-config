require("cool_stuff.chelpers").setup()
require("cool_stuff.nts").setup()

-- keymaps for nts
vim.keymap.set("n", "[n", ":Nts<CR>")
vim.keymap.set("n", "[j", ":NtsJournal<CR>")
