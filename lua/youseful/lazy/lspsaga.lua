if true then
  return {}
end

return {
  "glepnir/lspsaga.nvim",
  enabled = vim.g.vscode == nil,
  event = "LspAttach", -- load when LSP attaches
  config = function()
    local saga = require("lspsaga")
    saga.setup({})

    vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
    vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { silent = true })
    vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
    vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
    vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
  end,
}
