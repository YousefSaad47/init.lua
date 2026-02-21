return {
  {
    "akinsho/toggleterm.nvim",
    enabled = vim.g.vscode == nil,
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-`>]],
        direction = "horizontal",
      })
    end,
  },
}
