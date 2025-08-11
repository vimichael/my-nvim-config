return {
  {

    "nvim-neotest/nvim-nio",
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.adapters.codelldb = {
        type = "executable",
        port = "${port}",
        command = "codelldb",
        name = "codelldb",
        executable = {
          command = "$HOME/.local/share/nvim/mason/bin/codelldb",
          args = { "--port", "${port}" }
        }
      }

      dap.configurations.c = {
        {
          type = "codelldb",
          name = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("path to exe: ", vim.fn.getcwd() .. "/build", "file")
          end,
          cwd = function()
            return vim.fn.input("cwd: ", vim.fn.getcwd() .. "/build", "file")
          end,
          stopOnEntry = false
        }
      }

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
  { "rcarriga/nvim-dap-ui" }
}
