return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup({
        integrations = {

          markdown = {
            enabled = true,
            -- only_render_image_at_cursor = true,
            filetypes = { "markdown" },
            clear_in_insert_mode = true,
            only_render_image_at_cursor = true,
            -- only_render_image_at_cursor_mode = "popup",
          },
        },
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,    -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = true,  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      })
    end,
  },
}
