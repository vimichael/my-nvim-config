return {
  {
    "kdheepak/cmp-latex-symbols",
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = function()
          local luasnip = require("luasnip")

          luasnip.add_snippets("markdown", require("snippets.notes"))
          luasnip.add_snippets("text", require("snippets.notes"))
          luasnip.add_snippets("tex", require("snippets.latex"))
          luasnip.add_snippets("zig", require("snippets.zig"))
          luasnip.add_snippets("c", require("snippets.c"))
        end
      },
    },
    version = "1.*",

    ---@module 'blink.cmp'
    opts = {
      keymap = {
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<CR>"] = { "select_and_accept", "fallback" },
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
          auto_show = true,
          scrollbar = false,
          draw = {
            columns = {
              { "kind_icon" },
              { "label",             "label_description", gap = 1 },
              { "kind",              gap = 1 },
              { "label_description", gap = 1 },
              { "source_name",       gap = 1 },
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
}
