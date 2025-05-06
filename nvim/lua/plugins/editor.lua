return {
  { "folke/flash.nvim", enabled = false },
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   version = "*",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --     "MunifTanjim/nui.nvim",
  --   },
  --   config = function(_, opts)
  --     opts.window.mappings = {
  --       ["o"] = { "open_drop", nowait = true, noremap = true, desc = "open node why does it lag?" },
  --       ["O"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
  --     }
  --     require("neo-tree").setup(opts)
  --   end,
  -- },
  -- { "tpope/vim-surround.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    -- branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-tree/nvim-web-devicons",
      "debugloop/telescope-undo.nvim",
    },
    keys = {
      { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      -- { "n", "<leader>sr", "<cmd>Telescope lsp_references<cr>", { noremap = true, silent = true } },
      -- { "n", "<leader>sc", "<cmd>Telescope lsp_code_actions<cr>", { noremap = true, silent = true } },
      -- { "n", "<leader>si", "<cmd>Telescope lsp_implementations<cr>", { noremap = true, silent = true } },
      { "<leader>uu", ":Telescope undo <cr>", { noremap = true, silent = true } },
    },

    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions
      local undo_actions = require("telescope").extensions.undo.actions
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        -- path_display = { "truncate" },
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        color_devicons = true,
        winblend = 0,
        mappings = {
          n = {},
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for _ = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
        undo = {
          theme = "ivy",
          layout_config = {
            preview_cutoff = 9999,
          },
          mappings = {
            i = {
              ["<s-cr>"] = undo_actions.yank_additions,
              ["<c-cr>"] = undo_actions.yank_deletions,
              ["<cr>"] = undo_actions.restore,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("undo")
    end,
  },
  {
    "folke/zen-mode.nvim",
    -- keys = {
    --   ["<leader>zz"] = { "n", "ZenMode<cr>", desc = "Zen Mode" },
    -- },
    opts = {
      window = {
        backdrop = 0.65, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 100, -- width of the Zen window
        height = 1, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = { -- this doesn't work...
          -- signcolumn = "no", -- disable signcolumn
          -- number = false, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false, -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0, -- turn off the statusline in zen mode
        },
        twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false }, -- disables the tmux statusline
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = false,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
        -- vim.wo.wrap = true
        -- vim.wo.number = false
        -- vim.wo.relativenumber = false
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
        -- vim.wo.wrap = true
        -- vim.wo.number = false
        -- vim.wo.relativenumber = false
      end,
    },
    config = function()
      vim.keymap.set("n", "<leader>zz", function()
        -- zen-mode options didn't work the recommended way...
        -- so call toggle and pass opts
        require("zen-mode").toggle({
          window = {
            backdrop = 0.65,
            width = 70,
            height = 1,
            options = {
              signcolumn = "no",
              number = false,
              relativenumber = false,
              cursorline = false,
              cursorcolumn = false,
              foldcolumn = "0",
              list = false,
              wrap = true,
            },
          },
          plugins = {
            gitsigns = { enabled = false },
            tmux = { enabled = false },
          },
        })
      end, { silent = true, noremap = true, desc = "ZenMode" })
    end,
  },
}
