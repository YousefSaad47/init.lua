vim.g.mapleader = " "

local map = vim.keymap.set

map("n", "<leader>ex", vim.cmd.Ex, { desc = "Netrw explorer" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

vim.api.nvim_set_keymap(
  "n",
  "<leader>tf",
  "<Plug>PlenaryTestFile",
  { noremap = false, silent = false, desc = "Test file" }
)

map("n", "J", "mzJ`z", { desc = "Join lines" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up" })
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Previous search result" })
map("n", "=ap", "ma=ap'a", { desc = "Format paragraph" })

map("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })

map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

map("i", "<C-c>", "<Esc>", { desc = "Escape" })

map("n", "Q", "<nop>", { desc = "No-op" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word" })
map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make executable" })

map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<M-Left>", "<C-w>5<", { desc = "Resize window left" })
map("n", "<M-Right>", "<C-w>5>", { desc = "Resize window right" })
map("n", "<M-Up>", "<C-w>+", { desc = "Resize window up" })
map("n", "<M-Down>", "<C-w>-", { desc = "Resize window down" })

map("n", "<leader><leader>", function()
  vim.cmd("so")
end, { desc = "Source current file" })
