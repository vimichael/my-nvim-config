local utils = require("utils")

require("options")
require("custom_filetypes")
require("lazynvim")
require("keymaps")
require("cool_stuff")
require("mappings")
require("autocmds")

utils.color_overrides.setup_colorscheme_overrides()

vim.cmd.colorscheme("custom")

utils.fix_telescope_parens_win()
utils.dashboard.setup_dashboard_image_colors()
