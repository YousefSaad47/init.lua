local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

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
    map("n", "gd", function()
      vim.lsp.buf.definition()
    end, { buffer = e.buf, desc = "Go to definition" })
    map("n", "K", function()
      vim.lsp.buf.hover()
    end, { buffer = e.buf, desc = "Hover" })
    map("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, { buffer = e.buf, desc = "Workspace symbols" })
    map("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, { buffer = e.buf, desc = "Diagnostics" })
    map("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, { buffer = e.buf, desc = "Code actions" })
    map("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, { buffer = e.buf, desc = "References" })
    map("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, { buffer = e.buf, desc = "Rename" })
    map("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, { buffer = e.buf, desc = "Signature help" })
    map("n", "[d", function()
      vim.diagnostic.goto_next()
    end, { buffer = e.buf, desc = "Next diagnostic" })
    map("n", "]d", function()
      vim.diagnostic.goto_prev()
    end, { buffer = e.buf, desc = "Previous diagnostic" })
  end,
})
