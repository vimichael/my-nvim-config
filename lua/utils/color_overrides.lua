-- some colorscheme overrides for colorschemes I use

local M = {}

-- sets the line colors for vague
function M.vague_line_colors()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#646477" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#646477" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#d6d2c8" })
end

function M.my_line_colors()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888", bg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888", bg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#d6d2c8" })
end

function M.zenbones_theme_overrides()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888", bg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888", bg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#d6d2c8" })
end

function M.cosec_twilight_overrides()
  local hl = vim.api.nvim_set_hl

  local literal_color = "#cccccc"
  local comment = "#6f7b68"
  local bg = "#222222"

  hl(0, "Float", { fg = literal_color })
  hl(0, "Number", { fg = literal_color })
  hl(0, "Boolean", { fg = literal_color })

  hl(0, "TSComment", { fg = comment, gui = nil })
  hl(0, "Comment", { fg = comment, gui = nil })
  hl(0, "Search", { bg = "#9b8d7f", fg = "#1e1e1e" })
  hl(0, "PmenuSel", { bg = "#9b8d7f", fg = "#1e1e1e" })
  hl(0, "WinSeparator", { bg = "#111111", fg = "#888888" })
  hl(0, "Normal", { bg = "#202020" })

  hl(0, "LineNrAbove", { fg = "#888888", bg = "#222222" })
  hl(0, "LineNrBelow", { fg = "#888888", bg = "#222222" })
  hl(0, "LineNr", { fg = "#d6d2c8" })

  hl(0, "Question", { bg = "#9b8d7f" })
  hl(0, "DiagnosticVirtualTextError", { fg = "#912222" })
end

function M.black_metal_theme_overrides()
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#912222" })
  vim.api.nvim_set_hl(0, "TSComment", { fg = "#6f7b68", gui = nil })
  vim.api.nvim_set_hl(0, "Comment", { fg = "#6f7b68", gui = nil })
  vim.api.nvim_set_hl(0, "Visual", { bg = "#9b8d7f", fg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "Search", { bg = "#9b8d7f", fg = "#1e1e1e" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#9b8d7f", fg = "#1e1e1e" })

  -- lighter bg
  -- bg_color = "#040404"
  -- vim.api.nvim_set_hl(0, "Normal", { bg = "#222222" })
  -- vim.api.nvim_set_hl(0, "NormalNC", { bg = bg_color })

  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888", bg = "#222222" })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888", bg = "#222222" })
  vim.api.nvim_set_hl(0, "LineNr", { fg = "#d6d2c8" })

  -- accent = "#9c9b98"
  -- vim.api.nvim_set_hl(0, "Statement", { fg = accent })
  -- vim.api.nvim_set_hl(0, "WarningMsg", { fg = accent })
  -- vim.api.nvim_set_hl(0, "TSVariable", { fg = accent })
  -- vim.api.nvim_set_hl(0, "Exception", { fg = accent })
  -- vim.api.nvim_set_hl(0, "Macro", { fg = accent })
  -- vim.api.nvim_set_hl(0, "VisualNOS", { fg = accent })
  -- vim.api.nvim_set_hl(0, "Character", { fg = accent })
  -- vim.api.nvim_set_hl(0, "TSCharacter", { fg = accent })
  -- vim.api.nvim_set_hl(0, "TSCharacterBuiltin", { fg = accent })
  -- vim.api.nvim_set_hl(0, "@namespace", { fg = accent })

  -- local function replace_color(old_color, new_color)
  -- 	local highlights = vim.api.nvim_get_hl(0, {})
  --
  -- 	for group, opts in pairs(highlights) do
  -- 		if opts.fg and string.format("#%06x", opts.fg) == old_color then
  -- 			opts.fg = new_color
  -- 		end
  -- 		if opts.bg and string.format("#%06x", opts.bg) == old_color then
  -- 			opts.bg = new_color
  -- 		end
  --
  -- 		vim.api.nvim_set_hl(0, group, opts)
  -- 	end
  -- end
  --
  -- -- Example: Replace `#ff0000` (red) with `#00ff00` (green)
  -- replace_color("#9b8d7f", "#CDb7d2")
end

function M.vague_status_colors()
  local custom_iceberk_dark = require("lualine.themes.iceberg_dark")
  -- custom_iceberk_dark.normal.c.bg = "#080808" -- archiving bc this is my term bg
  custom_iceberk_dark.normal.c.bg = nil
  custom_iceberk_dark.inactive.b.bg = nil
  custom_iceberk_dark.inactive.a.bg = nil
  custom_iceberk_dark.inactive.c.bg = nil
  custom_iceberk_dark.insert.a.bg = "#bc96b0"
  custom_iceberk_dark.visual.a.bg = "#787bab"
  custom_iceberk_dark.replace.a.bg = "#a1b3b9"

  require("lualine").setup({
    options = {
      theme = custom_iceberk_dark,
    },
  })
end

-- sets up custom colors dependent on themes
function M.setup_colorscheme_overrides()
  vim.api.nvim_create_autocmd("ColorScheme", {
    -- so it's fired when used in other autocmds
    nested = true,
    pattern = "*",
    callback = function()
      local colorscheme = vim.g.colors_name
      if colorscheme == nil then
        return
      end
      if string.find(colorscheme, "base16") then
        if string.find(colorscheme, "metal") then
          M.black_metal_theme_overrides()
        end
        M.my_line_colors()
      elseif colorscheme == "zenburn" then
        M.my_line_colors()
      elseif colorscheme == "zenbones" then
        M.zenbones_theme_overrides()
      elseif colorscheme == "cosec-twilight" then
        -- M.cosec_twilight_overrides()
      end
    end,
  })

  -- remove italics from zenburn and the such
  local grpid = vim.api.nvim_create_augroup('custom_highlights', {})
  vim.api.nvim_create_autocmd('ColorScheme', {
    group = grpid,
    pattern = 'zen*',
    command = 'hi Comment  gui=NONE |' ..
        'hi Constant gui=NONE'
  })
end

-- setup some commands for manually setting values
vim.api.nvim_create_user_command("MyLine", M.my_line_colors, {})
vim.api.nvim_create_user_command("VagueStatus", M.vague_status_colors, {})
vim.api.nvim_create_user_command("VagueLine", M.vague_line_colors, {})
vim.api.nvim_create_user_command("DefStatus", function()
  require("lualine").setup({ options = { theme = "auto" } })
end, {})

return M
