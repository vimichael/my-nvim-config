local M = {}

local get_file_protos = function(filepath)
  if filepath == nil then
    return
  end
  local cmd = "ctags -o - --kinds-C=f --kinds-C++=f -x --_xformat='%{typeref} %{name} %{signature};' " ..
      filepath .. " | tr ':' ' ' | sed -e 's/^typename //'"
  -- vim.notify("cmd = " .. cmd)
  local output = vim.fn.system(cmd)
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local line = cursor_pos[1]

  vim.api.nvim_buf_set_lines(0, line - 1, line - 1, false, vim.split(output, '\n'))
end

local insert_protos = function()
  local filepath = vim.fn.expand("%:p")
  get_file_protos(filepath)
end

local function proto_cb(args)
  if not args["fargs"] or not args["fargs"][1] then
    insert_protos()
  else
    local loc = args["fargs"][1]
    get_file_protos(loc)
  end
end

M.setup = function()
  vim.api.nvim_create_user_command("CProtos", proto_cb, { nargs = "*" })
end

return M
