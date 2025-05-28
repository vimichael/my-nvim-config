local function startswith(str, pref)
  return str:sub(1, #pref) == pref
end

local function triml(s)
  return s:match("^%s*(.*)")
end

local function toggle_todo()
  local line = vim.api.nvim_get_current_line()
  local trimmed_line = triml(line)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  vim.cmd("noa")

  if startswith(trimmed_line, "- [x") then
    local replacement = string.gsub(line, "%[x%]", "[ ]")
    print(replacement)
    vim.api.nvim_buf_set_lines(0, row - 1, row, true, { replacement })
  elseif startswith(trimmed_line, "- [ ]") then
    local replacement = string.gsub(line, "%[ %]", "[x]")
    print(replacement)
    vim.api.nvim_buf_set_lines(0, row - 1, row, true, { replacement })
  end

  vim.api.nvim_win_set_cursor(0, { row, col })

  vim.cmd("redraw")
end

vim.api.nvim_create_augroup("MarkdownKeymaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "MarkdownKeymaps",
  pattern = "Markdown",
  callback = function()
    vim.keymap.set("n", "<leader>a", toggle_todo, { silent = true })
  end,
})
