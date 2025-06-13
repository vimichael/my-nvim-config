local utils = require("utils")

local M = {}

M.opts = {}

local default_opts = {
	root_dir = "~/notes",
	journal_dir = "~/notes/dailies",
}

local function create_note(args)
	vim.ui.input({ prompt = "title: " }, function(input)
		if input == nil or input == "" then
			return
		end

		if not args["fargs"] or not args["fargs"][1] then
			vim.ui.input({ prompt = "loc (default .):" }, function(loc_input)
				local loc = "."
				if loc_input == nil then
					return
				end
				if loc_input ~= "" then
					loc = loc_input
				end

				-- vim.notify("creating note at: " .. loc)

				local cmds = { "note", M.opts.root_dir .. "/" .. loc }
				for word in input:gmatch("%S+") do
					table.insert(cmds, word)
				end

				local output = vim.system(cmds):wait()

				vim.cmd("edit " .. output.stdout)
			end)
		end

		local loc = args["fargs"][1] or "."

		local cmd = "silent!note " .. M.opts.root_dir .. "/" .. loc .. " " .. input
		vim.cmd(cmd)
	end)
end

local function open_journal(opts)
	local date = os.date("%Y-%m-%d")
	local note_file = "journal-" .. date .. ".md"
	local full_path = opts.journal_dir .. "/" .. note_file

	-- if cannot open file, try generating it
	if vim.fn.filereadable(vim.fn.expand(full_path)) == 0 then
		vim.cmd("silent!nts journal")
	end

	vim.cmd("edit " .. full_path)
end

function M.setup(opts)
	opts = opts or {}
	M.opts = vim.tbl_deep_extend("force", default_opts, opts)
	M.opts.root_dir = utils.expand_path(M.opts.root_dir)

	vim.api.nvim_create_user_command("Nts", create_note, { nargs = "*" })
	vim.api.nvim_create_user_command("NtsJournal", function()
		open_journal(M.opts)
	end, { nargs = "*" })
end

return M
