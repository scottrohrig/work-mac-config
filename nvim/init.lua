-- bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  require("config.vscode")
else
  require("config.lazy")
end
