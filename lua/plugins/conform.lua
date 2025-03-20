return {
	"stevearc/conform.nvim",
	config = function()
		vim.g.disable_autoformat = false
		require("conform").setup({
			formatters_by_ft = {
				purescript = { "purstidy", stop_after_first = true },
				lua = { "stylua", stop_after_first = true },
				ocaml = { "ocamlformat", stop_after_first = true },
				python = { "black" },
				rust = { "rustfmt" },
				javascript = { "prettier", stop_after_first = true },
				javascriptreact = { "prettier", stop_after_first = true },
				typescript = { "prettier", stop_after_first = true },
				typescriptreact = { "prettier", stop_after_first = true },
				astro = { "astro", stop_after_first = true },
				go = { "gofumpt", "golines", "goimports-reviser" },
				c = { "clang_format" },
				cpp = { "clang_format" },
				haskell = { "ormolu" },
				yaml = { "yamlfmt" },
				html = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				gleam = { "gleam" },
				asm = { "asmfmt" },
				css = { "prettier", stop_after_first = true },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat then
					return
				end
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				if vim.g.disable_autoformat then
					return
				end
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
