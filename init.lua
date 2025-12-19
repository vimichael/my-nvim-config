local utils = require("utils")

-- stop annoying deprecation errors that i cant control
-- because i dont have access to the plugins that use
-- the deprecated functions
vim.deprecate = function() end

require("options")
local km = require("keymaps")
require("custom_filetypes")
require("lazynvim")
km.after_lazy_keymaps()
require("cool_stuff")
require("mappings")
require("autocmds")

utils.color_overrides.setup_colorscheme_overrides()

vim.cmd.colorscheme("custom")

utils.fix_telescope_parens_win()
utils.dashboard.setup_dashboard_image_colors()
