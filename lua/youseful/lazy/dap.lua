vim.api.nvim_create_augroup("DapGroup", { clear = true })

local function navigate(args)
  local buffer = args.buf

  local wid = nil
  local win_ids = vim.api.nvim_list_wins()
  for _, win_id in ipairs(win_ids) do
    local win_bufnr = vim.api.nvim_win_get_buf(win_id)
    if win_bufnr == buffer then
      wid = win_id
    end
  end

  if wid == nil then
    return
  end

  vim.schedule(function()
    if vim.api.nvim_win_is_valid(wid) then
      vim.api.nvim_set_current_win(wid)
    end
  end)
end

local function create_nav_options(name)
  return {
    group = "DapGroup",
    pattern = string.format("*%s*", name),
    callback = navigate,
  }
end

return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      local dap = require("dap")
      dap.set_log_level("DEBUG")

      vim.keymap.set("n", "<F5>", function()
        vim.fn.system({ "npm", "run", "build" })
        require("dapui").open()
        dap.continue()
      end, { desc = "Debug: Build then Continue" })
      vim.keymap.set("n", "<leader>dT", dap.terminate, { desc = "Debug: Stop" })
      vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Conditional Breakpoint" })

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Compiled (dist)",
          program = "${workspaceFolder}/dist/index.js",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
          console = "integratedTerminal",
        },
      }

      dap.configurations["dapui_console"] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "dapui console",
          console = "internalConsole",
        },
      }

      dap.configurations.dapui_console = {
        {
          type = "pwa-node",
          request = "launch",
          name = "dapui console",
          program = "",
          console = "internalConsole",
        },
      }

      dap.defaults.fallback.terminal = {
        console = "integratedTerminal",
      }
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        floating = {
          border = "rounded",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
            },
            size = 50,
            position = "right",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 10,
            position = "bottom",
          },
        },
      })

      vim.keymap.set("n", "<leader>da", function()
        dapui.open()
      end, { desc = "Debug: Open All UI" })
      vim.keymap.set("n", "<leader>dA", function()
        dapui.close()
        vim.cmd("wincmd =")
      end, { desc = "Debug: Close All UI" })

      vim.api.nvim_create_autocmd("BufEnter", {
        group = "DapGroup",
        pattern = "*dap-repl*",
        callback = function()
          vim.wo.wrap = true
        end,
      })

      vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("dap-repl"))
      vim.api.nvim_create_autocmd("BufWinEnter", create_nav_options("DAP Watches"))

      dap.listeners.after.initialized.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
        vim.cmd("wincmd =")
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
        vim.cmd("wincmd =")
      end

      dap.listeners.after.event_output.dapui_config = function(_, body)
        if body.category == "console" then
          dapui.eval(body.output)
        end
      end
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = {
          "delve",
          "js-debug-adapter",
        },
        automatic_installation = true,
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,
          delve = function(config)
            table.insert(config.configurations, 1, {
              args = function()
                return vim.split(vim.fn.input("args> "), " ")
              end,
              type = "delve",
              name = "file",
              request = "launch",
              program = "${file}",
              outputMode = "remote",
            })
            table.insert(config.configurations, 1, {
              args = function()
                return vim.split(vim.fn.input("args> "), " ")
              end,
              type = "delve",
              name = "file args",
              request = "launch",
              program = "${file}",
              outputMode = "remote",
            })
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })
    end,
  },
}
