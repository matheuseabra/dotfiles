require "nvchad.autocmds"

local function clear_highlight_bg(group)
  if vim.fn.hlexists(group) == 1 then
    vim.cmd("highlight " .. group .. " guibg=NONE ctermbg=NONE")
  end
end

local function apply_transparent_ui()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "EndOfBuffer",
    "Pmenu",
    "TelescopeNormal",
    "TelescopeBorder",
    "TabLineFill",
    "WinBar",
    "WinBarNC",
  }

  for _, group in ipairs(groups) do
    clear_highlight_bg(group)
  end

  for _, group in ipairs(vim.fn.getcompletion("BufferLine", "highlight")) do
    clear_highlight_bg(group)
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = apply_transparent_ui,
})

vim.api.nvim_create_autocmd("User", {
  pattern = { "VeryLazy", "NvThemeReload" },
  callback = apply_transparent_ui,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    apply_transparent_ui()

    if vim.bo.filetype == "nvdash" then
      vim.schedule(function()
        vim.cmd("Neotree show left")
      end)
    end
  end,
})
