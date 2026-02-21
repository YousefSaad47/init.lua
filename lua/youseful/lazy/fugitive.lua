return {
  "tpope/vim-fugitive",
  enabled = vim.g.vscode == nil,
  config = function()
    local map = vim.keymap.set

    map("n", "<leader>gs", vim.cmd.Git)

    local youseful_fugitive = vim.api.nvim_create_augroup("Youseful_Fugitive", {})

    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      group = youseful_fugitive,
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = { buffer = bufnr, remap = false }
        map("n", "<leader>p", function()
          vim.cmd.Git("push")
        end, opts)

        map("n", "<leader>P", function()
          vim.cmd.Git({ "pull", "--rebase" })
        end, opts)

        map("n", "<leader>t", ":Git push -u origin ", opts)
      end,
    })

    map("n", "gu", "<cmd>diffget //2<CR>")
    map("n", "gh", "<cmd>diffget //3<CR>")
  end,
}
