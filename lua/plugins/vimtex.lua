return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
    vim.g.tex_flavour = "latex"
    vim.g.vimtex_quickfix_mode = 0
    vim.g.vimtex_compiler_latexmk = {
      continuous = 1,
      options = {
        "-f",
        "-file-line-error",
        "-interaction=nonstopmode"
      }
    }
    -- vim.g.tex_conceal = "abdmg"
  end,
}
