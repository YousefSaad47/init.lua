return {
  "nvim-lualine/lualine.nvim",
  enabled = vim.g.vscode == nil,
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local function copilot_status()
      local ok, copilot = pcall(require, "copilot.status")
      if not ok then
        return ""
      end
      local status = copilot.data.status
      local icon = "󰚩"
      if status == "InProgress" then
        return icon .. " pending"
      end
      if status == "Warning" then
        return icon .. " error"
      end
      return icon .. " ok"
    end

    local function copilot_color()
      local ok, copilot = pcall(require, "copilot.status")
      if not ok then
        return {}
      end
      local status = copilot.data.status
      if status == "InProgress" then
        return { fg = "#e5c07b" }
      end
      if status == "Warning" then
        return { fg = "#e06c75" }
      end
      return { fg = "#98c379" }
    end

    require("lualine").setup({
      options = {
        theme = "vscode",
      },
      sections = {
        lualine_x = {
          {
            copilot_status,
            color = copilot_color,
          },
        },
      },
    })
  end,
}
