return {
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, _, _)
      return ""
    end,
    always_show_bufferline = true,
    show_close_icon = false,
    show_buffer_close_icons = true,
    separator_style = "thin",
    indicator = {
      style = "underline",
    },
    modified_icon = "●",
    buffer_close_icon = "×",
    close_icon = "×",
    max_name_length = 18,
    tab_size = 18,
    offsets = {
      {
        filetype = "neo-tree",
        text = " Neo-tree",
        text_align = "left",
        separator = true,
      },
    },
  },
}
