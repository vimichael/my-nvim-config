return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "mupdf"
    vim.g.vimtex_view_mupdf_sync = 1
    vim.g.vimtex_view_mupdf_activate = 1
    vim.g.vimtex_quickfix_mode = 0
    -- vim.g.tex_conceal = "abdmg"
  end,
}
