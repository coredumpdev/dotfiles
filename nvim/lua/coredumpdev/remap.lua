vim.g.mapleader = " "
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")


vim.opt.guicursor = "n-v-i-c:block-Cursor"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
