-- Written from scratch by likalium :)
-- But thx so much to ThePrimegean's video: https://www.youtube.com/watch?v=w7i4amO_zaE

vim.g.mapleader=","
vim.keymap.set("n","<leader>s",vim.cmd.so)
vim.keymap.set("n","<leader>c",vim.cmd.CHADopen)
vim.keymap.set("n","<leader>ps",vim.cmd.PackerSync)
