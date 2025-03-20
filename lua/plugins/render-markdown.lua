return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	opts = {
		heading = {
			icons = {},
		},
		html = {
			comment = {
				conceal = false,
			},
		},
		render_modes = true,
	},
}
