-- lua/chadrc.lua
local M = {}

M.base46 = {
  theme = "tokyonight",
  transparency = true,
}

M.ui = {
  cmp = {
    style = "flat_dark",
    icons_left = true,
  },
  telescope = { style = "borderless" },
  statusline = { enabled = false },
  tabufline = { enabled = false },
}

M.nvdash = {
  load_on_startup = true,
}

return M
