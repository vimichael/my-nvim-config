return {
  "echasnovski/mini.misc",
  config = function()
    local misc = require("mini.misc")
    misc.setup({})

    misc.setup_termbg_sync()
  end
}
