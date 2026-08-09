return {
  options = {
    theme = "aether",
    globalstatus = true,
    component_separators = { left = "│", right = "│" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = { "neo-tree", "dashboard", "alpha", "starter" },
    },
  },
  sections = {
    lualine_a = { { "mode", upper = true, padding = { left = 1, right = 1 } } },
    lualine_b = { { "branch", padding = { left = 1, right = 0 } }, "diff" },
    lualine_c = {
      {
        "filename",
        path = 1,
        padding = { left = 1, right = 1 },
        symbols = { modified = " ●", readonly = " 󰌾", unnamed = " [No Name]" },
      },
    },
    lualine_x = { { "diagnostics", padding = { left = 1, right = 1 } } },
    lualine_y = { { "filetype", colored = true } },
    lualine_z = { { "location", padding = { left = 1, right = 1 } } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { { "filename", path = 1 } },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
}
