return {
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
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
}
