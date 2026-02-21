return {
  "nvim-tree/nvim-tree.lua",
  enabled = vim.g.vscode == nil,
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      update_focused_file = {
        enable = true,
      },
      filters = {
        git_ignored = false,
      },
    })

    vim.keymap.set(
      "n",
      "<leader>te",
      ":NvimTreeToggle<CR>",
      { noremap = true, silent = true, desc = "Toggle file tree" }
    )
    vim.keymap.set("n", "<leader>fe", ":NvimTreeFocus<CR>", { noremap = true, silent = true, desc = "Focus file tree" })
  end,
}
