return {
  -- colorschemes
  -- {
  --   "navarasu/onedark.nvim",
  --   config = function()
  --     local onedark = require("onedark")
  --     onedark.setup({
  --       style = "deep", -- dark, darker, cool, deep, warm, warmer, & light
  --       transparent = false,
  --       -- toggle theme style
  --       toggle_style_key = "<leader>ct",
  --       -- favs 'deep' then 'darker'
  --       -- toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" },
  --       toggle_style_list = { "darker", "deep", "warm", "light" },
  --       code_style = {
  --         comments = "italic",
  --         keywords = "italic",
  --         functions = "none",
  --       },
  --       -- highlights = {},
  --     })
  --     -- onedark.load()
  --   end,
  -- },
  {
    "talha-akram/noctis.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      -- vim.cmd.colorscheme("noctis_hibernus")
      vim.cmd("colorscheme noctis")
    end,
  },
  "rose-pine/neovim",
  "bluz71/vim-nightfly-colors",
  "sainnhe/sonokai",
  "sainnhe/gruvbox-material",
  "sainnhe/edge",
  "sainnhe/everforest",
  "folke/lsp-colors.nvim",
}
