return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  enabled = vim.g.vscode == nil,
  event = "VeryLazy",
  opts = function(_, opts)
    opts = opts or {}
    opts.indent = opts.indent or {}
    opts.indent.char = "▏"
    return require("indent-rainbowline").make_opts(opts)
  end,
  dependencies = {
    "TheGLander/indent-rainbowline.nvim",
  },
}
