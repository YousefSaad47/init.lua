return {
  "lewis6991/gitsigns.nvim",
  enabled = vim.g.vscode == nil,
  event = "BufReadPost",
  opts = {
    current_line_blame = true,
  },
}
