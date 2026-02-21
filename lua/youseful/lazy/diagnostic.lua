return {
  "rachartier/tiny-inline-diagnostic.nvim",
  enabled = vim.g.vscode == nil,
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      preset = "amongus",
      options = {
        multilines = {
          enabled = true,
        },
        show_source = {
          enabled = true,
        },
      },
    })
    vim.diagnostic.config({ virtual_text = false, underline = false })
  end,
}
