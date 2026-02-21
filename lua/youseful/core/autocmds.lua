local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local youseful_group = augroup("YousefulGroup", { clear = true })
local yank_group = augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 50,
    })
  end,
})

autocmd({ "BufWritePre" }, {
  group = youseful_group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
  group = youseful_group,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, { buffer = e.buf, desc = "Go to definition" })
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, { buffer = e.buf, desc = "Hover" })
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, { buffer = e.buf, desc = "Workspace symbols" })
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, { buffer = e.buf, desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, { buffer = e.buf, desc = "Code actions" })
    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, { buffer = e.buf, desc = "References" })
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, { buffer = e.buf, desc = "Rename" })
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, { buffer = e.buf, desc = "Signature help" })
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_next()
    end, { buffer = e.buf, desc = "Next diagnostic" })
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_prev()
    end, { buffer = e.buf, desc = "Previous diagnostic" })
  end,
})
