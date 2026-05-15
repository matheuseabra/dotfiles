return {
  close_if_last_window = false,
  popup_border_style = "NC",
  enable_git_status = true,
  enable_diagnostics = true,
  sources = { "filesystem", "buffers", "git_status" },
  default_component_configs = {
    container = { enable_character_fade = true },
    indent = {
      indent_size = 1,
      padding = 0,
      with_markers = false,
      with_expanders = true,
      expander_collapsed = "",
      expander_expanded = "",
      expander_highlight = "NeoTreeExpander",
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "󰜌",
      default = "",
    },
    modified = {
      symbol = "",
    },
    name = {
      use_git_status_colors = true,
    },
    git_status = {
      symbols = {
        added = "✚",
        deleted = "✖",
        modified = "",
        renamed = "󰁕",
        untracked = "",
        ignored = "",
        unstaged = "󰄱",
        staged = "",
        conflict = "",
      },
    },
  },
  window = {
    position = "left",
    width = 32,
    mappings = {
      ["<space>"] = "none",
      ["l"] = "open",
      ["h"] = "close_node",
      ["P"] = { "toggle_preview", config = { use_float = false } },
    },
  },
  filesystem = {
    follow_current_file = { enabled = true },
    hijack_netrw_behavior = "open_default",
    use_libuv_file_watcher = true,
    group_empty_dirs = true,
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_hidden = false,
      hide_gitignored = true,
      never_show = { ".DS_Store" },
    },
  },
}
