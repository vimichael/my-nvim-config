local function _1_()
  local todo = require("floatingtodo")
  todo.setup({target_file = "~/notes/todo.md", width = 0.9, position = "center"})
  return vim.keymap.set("n", "<leader>td", ":Td<CR>", {silent = true})
end
local function _2_()
  return vim.keymap.set("n", "<leader>zz", ":ZenMode<CR>")
end
return {{"vimichael/floatingtodo.nvim", config = _1_}, {"folke/zen-mode.nvim", config = _2_, opts = {window = {width = 83}}}}
