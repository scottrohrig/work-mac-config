-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local set = vim.keymap.set

set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

set("v", "<leader>y", '"+y')
set("n", "<leader>p", '"+p')

----------------------------------------
-- Motion mappings
----------------------------------------
-- move lines up/down
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")
-- indent/dedent
set("v", "<", "<gv")
set("v", ">", ">gv")

-- shift+j keeps cursor at start of line
set("n", "J", "mzJ`z")

-- center locate page jumping
set("n", "<C-d>", "<C-d>zz")
set("n", "<C-u>", "<C-u>zz")
set("n", "<PageUp>", "<C-u>zz")

-- search terms stay in center of screen
set("n", "n", "nzzzv")
set("n", "N", "Nzzzv")

-- Remap for dealing with word wrap
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
