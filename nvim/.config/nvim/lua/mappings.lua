require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local telescope = require "telescope.builtin"
local dotfiles_root = vim.fn.expand "~/dotfiles"

local function find_files()
  local cwd = vim.fn.getcwd()
  local opts = {}

  -- This repo stores real files under dot-paths like .config and .zshrc.
  if cwd == dotfiles_root or vim.startswith(cwd, dotfiles_root .. "/") then
    opts.hidden = true
    opts.find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
  end

  telescope.find_files(opts)
end

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-f>", find_files, { desc = "telescope find files" })
map("n", "<C-n>", "<cmd>Neotree toggle left<CR>", { desc = "neo-tree toggle window" })
map("n", "<leader>e", "<cmd>Neotree focus left<CR>", { desc = "neo-tree focus window" })
map("n", "<M-Left>", "<cmd><C-U>TmuxNavigateLeft<CR>", { desc = "tmux navigate left" })
map("n", "<M-Down>", "<cmd><C-U>TmuxNavigateDown<CR>", { desc = "tmux navigate down" })
map("n", "<M-Up>", "<cmd><C-U>TmuxNavigateUp<CR>", { desc = "tmux navigate up" })
map("n", "<M-Right>", "<cmd><C-U>TmuxNavigateRight<CR>", { desc = "tmux navigate right" })
map("n", "<leader>ff", find_files, { desc = "find files" })
map("n", "<C-z>", "u", { desc = "undo" })
map("i", "<C-z>", "<C-o>u", { desc = "undo" })

-- Select all: Ctrl+A (normal mode)
map("n", "<C-a>", "ggVG", { noremap = true, silent = true })

-- Copy to system clipboard: Ctrl+C
map("n", "<C-c>", '"+yy', { noremap = true, silent = true })  -- copy current line
map("v", "<C-c>", '"+y',  { noremap = true, silent = true })  -- copy selection

-- Delete the current selection with Backspace without clobbering yanks
map("x", "<BS>", '"_d', { noremap = true, silent = true })
map("s", "<BS>", '<C-o>"_c', { noremap = true, silent = true })

-- Reload Neovim config: Ctrl+R
map("n", "<C-r>", function()
  dofile(vim.env.MYVIMRC)
  vim.notify("Neovim config reloaded", vim.log.levels.INFO)
end, { noremap = true, silent = true })

-- cmd + alt + m to render markdown preview
map("n", "<D-M>", "<cmd>RenderMarkdown<CR>", { desc = "markdown preview" })

-- Save File: Ctrl+S
map({ "n", "i", "v" }, "<C-s>", function()
  vim.cmd.write()
  -- leave insert mode if in it
  if vim.api.nvim_get_mode().mode == "i" then
    vim.cmd.stopinsert()
  end 
end, { desc = "save file" })

-----------------------------------------------------------------------
-- Conservative "auto-insert on first open" behavior
-----------------------------------------------------------------------

-- Decide whether this buffer should start in insert mode
local function should_start_insert(bufnr)
  local bt = vim.bo[bufnr].buftype
  local ft = vim.bo[bufnr].filetype
  local modifiable = vim.bo[bufnr].modifiable
  local readonly = vim.bo[bufnr].readonly

  -- Only normal, modifiable file buffers
  if bt ~= "" then
    return false
  end
  if not modifiable or readonly then
    return false
  end

  -- Skip some special filetypes
  local skip = {
    help = true,
    qf = true,
    gitcommit = true,
    ["neo-tree"] = true,
    NvimTree = true,
    TelescopePrompt = true,
    lazy = true,
    mason = true,
    [""] = false, -- plain files are fine
  }

  if skip[ft] then
    return false
  end

  return true
end

-- Track which buffers we've already auto-inserted into
local seen = {}

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(args)
    local bufnr = args.buf

    -- Only do this once per buffer
    if seen[bufnr] then
      return
    end
    seen[bufnr] = true

    if should_start_insert(bufnr) then
      -- Only start insert if we're currently in normal mode,
      -- so we don't fight with commands that intentionally left us in another mode.
      local mode = vim.api.nvim_get_mode().mode
      if mode == "n" then
        vim.cmd("startinsert")
      end
    end
  end,
})
