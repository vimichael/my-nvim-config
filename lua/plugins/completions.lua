return {
	-- {
	--   "hrsh7th/cmp-nvim-lsp",
	-- },
	{
		"kdheepak/cmp-latex-symbols",
	},
	{
		"saghen/blink.cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				-- dependencies = {
				--   "saadparwaiz1/cmp_luasnip",
				--   {
				--     "rafamadriz/friendly-snippets",
				--     config = function()
				--       require('luasnip.loaders.from_vscode').lazy_load()
				--     end
				--   },
				--   "onsails/lspkind.nvim",
				-- },
			},
		},
		version = "1.*",

		---@module 'blink.cmp'
		opts = {
			keymap = {
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<C-e>"] = { "hide", "fallback" },
			},

			appearance = {
				nerd_font_variant = "mono",
			},
			signature = {
				enabled = true,
				window = {
					show_documentation = false,
				},
			},
			completion = {
				trigger = {
					show_on_insert_on_trigger_character = false,
					show_on_accept_on_trigger_character = false,
					show_on_blocked_trigger_characters = { "{", "(", "}", ")" },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 0,
				},
				menu = {
					scrollbar = false,
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind", gap = 1 },
							{ "label_description", gap = 1 },
							{ "source_name", gap = 1 },
						},
						components = {
							kind_icon = {
								ellipsis = false,
								width = { fill = true },
								text = function(ctx)
									local kind_icons = {
										Function = "λ", -- Lambda symbol for functions
										Method = "∂", -- Lambda symbol for methods
										Field = "󰀫", -- Lambda symbol for methods
										Variable = "󰀫", -- Lambda symbol for methods
										Property = "󰀫", -- Lambda symbol for methods
										Keyword = "k", -- Lambda symbol for methods
										Struct = "Π", -- Lambda symbol for methods
										Enum = "τ", -- Lambda symbol for methods
										EnumMember = "τ", -- Lambda symbol for methods
										Snippet = "⊂",
										Text = "τ",
										Module = "⌠",
										Constructor = "∑",
									}

									local icon = kind_icons[ctx.kind]
									if icon == nil then
										icon = ctx.kind_icon
									end
									return icon
								end,
							},
						},
					},
				},
			},
			snippets = {
				preset = "luasnip",
				-- Function to use when expanding LSP provided snippets
				expand = function(snippet)
					vim.snippet.expand(snippet)
				end,
				-- Function to use when checking if a snippet is active
				active = function(filter)
					return vim.snippet.active(filter)
				end,
				-- Function to use when jumping between tab stops in a snippet, where direction can be negative or positive
				jump = function(direction)
					vim.snippet.jump(direction)
				end,
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	-- {
	--   "hrsh7th/nvim-cmp",
	--   config = function()
	--     local lspkind = require("lspkind")
	--     local luasnip = require("luasnip")
	--
	--     luasnip.add_snippets("markdown", require("snippets.notes"))
	--     luasnip.add_snippets("text", require("snippets.notes"))
	--     luasnip.add_snippets("tex", require("snippets.latex"))
	--     luasnip.add_snippets("zig", require("snippets.zig"))
	--     -- Set up nvim-cmp.
	--     local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	--     local cmp = require("cmp")
	--     require("luasnip.loaders.from_vscode").lazy_load()
	--
	--     cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	--
	--     cmp.setup({
	--       preselect = cmp.PreselectMode.None,
	--       snippet = {
	--         -- REQUIRED - you must specify a snippet engine
	--         expand = function(args)
	--           require("luasnip").lsp_expand(args.body)
	--         end,
	--       },
	--       window = {
	--         completion = { border = "solid" },
	--         documentation = { border = "solid" },
	--       },
	--       mapping = cmp.mapping.preset.insert({
	--         ["<C-b>"] = cmp.mapping.scroll_docs(-4),
	--         ["<C-f>"] = cmp.mapping.scroll_docs(4),
	--         ["<C-Space>"] = cmp.mapping.complete(),
	--         ["<C-e>"] = cmp.mapping.abort(),
	--         -- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	--         ["<CR>"] = cmp.mapping.confirm({ select = false }),
	--
	--         ["<Tab>"] = cmp.mapping(function(fallback)
	--           if cmp.visible() then
	--             cmp.select_next_item()
	--           elseif luasnip.expand_or_jumpable() then
	--             luasnip.expand_or_jump()
	--           else
	--             fallback()
	--           end
	--         end, { "i", "s" }),
	--
	--         ["<S-Tab>"] = cmp.mapping(function(fallback)
	--           if cmp.visible() then
	--             cmp.select_prev_item()
	--           elseif luasnip.jumpable(-1) then
	--             luasnip.jump(-1)
	--           else
	--             fallback()
	--           end
	--         end, { "i", "s" }),
	--       }),
	--       sources = cmp.config.sources({
	--         {
	--           name = "nvim_lsp",
	--           entry_filter = function(entry, ctx)
	--             return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
	--           end,
	--         },
	--         {
	--           name = "luasnip",
	--         },                                    -- For luasnip users.
	--         { name = "nvim_lsp_signature_help" }, -- function arg popups while typing
	--       }, {
	--         { name = "buffer" },
	--         -- { name = "latex_symbols" },
	--       }),
	--       formatting = {
	--         fields = { "kind", "abbr", "menu" },
	--         format = function(entry, vim_item)
	--           local kind_icons = {
	--             Function = "λ", -- Lambda symbol for functions
	--             Method = "∂", -- Lambda symbol for methods
	--             Field = "󰀫", -- Lambda symbol for methods
	--             Property = "󰀫", -- Lambda symbol for methods
	--             Keyword = "k", -- Lambda symbol for methods
	--             Struct = "π", -- Lambda symbol for methods
	--             Struct = "Π", -- Lambda symbol for methods
	--             Enum = "τ", -- Lambda symbol for methods
	--             EnumMember = "τ", -- Lambda symbol for methods
	--             Snippet = "⊂",
	--             Text = "τ",
	--             Module = "⌠",
	--           }
	--
	--           local kind = lspkind.cmp_format({
	--             mode = "symbol_text",
	--
	--             symbol_map = kind_icons, -- Override default symbols
	--           })(entry, vim_item)
	--           local strings = vim.split(kind.kind, "%s", { trimempty = true })
	--           kind.kind = " " .. (strings[1] or "") .. " "
	--           kind.menu = "    " .. (strings[2] or "") .. ""
	--
	--           return kind
	--         end,
	--       },
	--     })
	--   end,
	-- },
}
