return {
  "mrcjkb/rustaceanvim",
  version = "^6",
  lazy = false,
  config = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
      },
      -- LSP configuration
      server = {
        on_attach = function(client, bufnr)
          -- you can also put keymaps in here
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ['rust-analyzer'] = {
            debounce = 1000,
            check = {
              command = "clippy",
              allTargets = false,
              checkOnType = false,
            }
          },
        },
      },
      -- DAP configuration
      dap = {
      },
    }
  end
}
