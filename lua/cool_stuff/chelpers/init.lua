local M = {}

M.insert_protos = function()
  local filepath = vim.fn.expand("%:p")
  if filepath == nil then
    return
  end
  local cmd = "ctags -o - --kinds-C=f --kinds-C++=f -x --_xformat='%{typeref} %{name} %{signature};' " ..
      filepath .. " | tr ':' ' ' | sed -e 's/^typename //'"
  vim.notify("cmd = " .. cmd)
  local output = vim.fn.system(cmd)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = cursor_pos[1]

  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, vim.split(output, '\n'))
end

M.setup = function()
  vim.api.nvim_create_user_command("CProtos", M.insert_protos, {})
end

return M
