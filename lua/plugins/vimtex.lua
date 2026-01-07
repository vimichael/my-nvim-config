return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		local os = require("utils").get_os()
		-- VimTeX configuration goes here, e.g.

		if os == "linux" then
			vim.g.vimtex_view_method = "mupdf"
		elseif os == "mac" then
			vim.g.vimtex_view_method = "skim"
		else
			vim.g.vimtex_view_method = "zathura"
		end
		vim.g.vimtex_view_mupdf_sync = 1
		vim.g.vimtex_view_mupdf_activate = 1
		vim.g.vimtex_quickfix_mode = 0
		-- vim.g.tex_conceal = "abdmg"
	end,
}
