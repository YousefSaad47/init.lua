return {
  "Mofiqul/vscode.nvim",
  enabled = vim.g.vscode == nil,
  priority = 1000,
  lazy = false,
  config = function()
    require("vscode").setup({
      style = "dark",
      disable_nvimtree_bg = false,
    })
    require("vscode").load()
  end,
}
