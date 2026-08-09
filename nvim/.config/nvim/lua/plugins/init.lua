return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        bg = "#060114",
        dark_bg = "#05010f",
        darker_bg = "#03010a",
        lighter_bg = "#1f1a2c",
        fg = "#D7DBE9",
        dark_fg = "#a1a4af",
        light_fg = "#dde0ec",
        bright_fg = "#e1e4ef",
        muted = "#66656b",
        red = "#9c8ba9",
        yellow = "#c4f6ff",
        orange = "#ab9cb6",
        green = "#a1c4e4",
        cyan = "#bad8ff",
        blue = "#757b9d",
        purple = "#aaa2ce",
        brown = "#675e6d",
        bright_red = "#b39fc5",
        bright_yellow = "#bcfbff",
        bright_green = "#aedcff",
        bright_cyan = "#caf0ff",
        bright_blue = "#898fb9",
        bright_purple = "#c1b6ee",
        accent = "#757b9d",
        cursor = "#D7DBE9",
        foreground = "#D7DBE9",
        background = "#060114",
        selection = "#1f1a2c",
        selection_foreground = "#D7DBE9",
        selection_background = "#1f1a2c",
      },
    },
    config = function(_, opts)
      require("aether").setup(opts)
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      return require "configs.neo_tree"
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require "configs.lualine"
    end,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      return require "configs.bufferline"
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
  },
  {
    "andrew-george/telescope-themes",
    lazy = false,
    config = function()
      require("telescope").load_extension("themes")
    end,
  },
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
  "alexpasmantier/tv.nvim",
  config = function()
    local h = require('tv').handlers

    require('tv').setup({
      -- per-channel configurations
      channels = {
        -- `files`: fuzzy find files in your project
        files = {
          keybinding = '<C-p>',               -- Launch the files channel
          -- what happens when you press a key
          handlers = {
            ['<CR>'] = h.open_as_files,         -- default: open selected files
            ['<C-q>'] = h.send_to_quickfix,     -- send to quickfix list
            ['<C-s>'] = h.open_in_split,       -- open in horizontal split
            ['<C-v>'] = h.open_in_vsplit,      -- open in vertical split
            ['<C-y>'] = h.copy_to_clipboard,   -- copy paths to clipboard
          },
        },
        -- `text`: ripgrep search through file contents
        text = {
          keybinding = '<leader><leader>',
          handlers = {
            ['<CR>'] = h.open_at_line,         -- Jump to line:col in file
            ['<C-q>'] = h.send_to_quickfix,    -- Send matches to quickfix
            ['<C-s>'] = h.open_in_split,       -- Open in horizontal split
            ['<C-v>'] = h.open_in_vsplit,      -- Open in vertical split
            ['<C-y>'] = h.copy_to_clipboard,   -- Copy matches to clipboard
          },
        },
      },
    })
  end,
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    opts = {},
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "kevinhwang91/promise-async",
    lazy = true,
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = {
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    keys = {
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        mode = { "n", "v" },
        desc = "Open yazi at the current file",
      },
      {
        "<leader>cw",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        "<C-Up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "kevinhwang91/promise-async" },
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
    },
    opts = {},
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  {
    "delphinus/md-render.nvim",
    version = "*",
    cmd = "MdRender",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<M-Left>", "<cmd><C-U>TmuxNavigateLeft<cr>", mode = "n" },
      { "<M-Down>", "<cmd><C-U>TmuxNavigateDown<cr>", mode = "n" },
      { "<M-Up>", "<cmd><C-U>TmuxNavigateUp<cr>", mode = "n" },
      { "<M-Right>", "<cmd><C-U>TmuxNavigateRight<cr>", mode = "n" },
      { "<M-Left>", "<Esc><cmd><C-U>TmuxNavigateLeft<cr>", mode = "i" },
      { "<M-Down>", "<Esc><cmd><C-U>TmuxNavigateDown<cr>", mode = "i" },
      { "<M-Up>", "<Esc><cmd><C-U>TmuxNavigateUp<cr>", mode = "i" },
      { "<M-Right>", "<Esc><cmd><C-U>TmuxNavigateRight<cr>", mode = "i" },
      { "<M-Left>", "<C-\\><C-n><cmd><C-U>TmuxNavigateLeft<cr>", mode = "t" },
      { "<M-Down>", "<C-\\><C-n><cmd><C-U>TmuxNavigateDown<cr>", mode = "t" },
      { "<M-Up>", "<C-\\><C-n><cmd><C-U>TmuxNavigateUp<cr>", mode = "t" },
      { "<M-Right>", "<C-\\><C-n><cmd><C-U>TmuxNavigateRight<cr>", mode = "t" },
    },
  }
}
