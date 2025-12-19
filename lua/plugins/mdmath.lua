-- return {}
return {
  -- dir = "~/dotfiles/.config/nvim/lua/plugins/mdmath.nvim",
  "Thiago4532/mdmath.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    filetypes = { "markdown" },
    foreground = "Normal",
    anticonceal = true,
    hide_on_insert = true,
    dynamic = true,
    dynamic_scale = 1.0,
    update_interval = 400,

    -- Internal scale of the equation images, increase to prevent blurry images when increasing terminal
    -- font, high values may produce aliased images.
    -- WARNING: This do not affect how the images are displayed, only how many pixels are used to render them.
    --          See `dynamic_scale` to modify the displayed size.
    -- internal_scale = 1.0,
  },
}
