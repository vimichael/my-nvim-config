local utils = require("utils")

local M = {}

M.opts = {}

local default_opts = {
	root_dir = "~/notes",
}

local function create_note(args)
	local loc = "."
	if args["fargs"] then
		loc = args["fargs"][1] or "."
	end
	vim.ui.input({ prompt = "title: " }, function(input)
		if input == "" then
			vim.notify("no title provided.")
			return
		end
		local cmd = "!nts note " .. M.opts.root_dir .. "/" .. loc .. " " .. input
		vim.cmd(cmd)
	end)
end

function M.setup(opts)
	opts = opts or {}
	M.opts = vim.tbl_deep_extend("force", default_opts, opts)
	M.opts.root_dir = utils.expand_path(M.opts.root_dir)

	vim.api.nvim_create_user_command("Nts", create_note, { nargs = "*" })
end

return M
