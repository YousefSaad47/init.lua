return {
  "mbbill/undotree",
  enabled = vim.g.vscode == nil,
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end,
}
