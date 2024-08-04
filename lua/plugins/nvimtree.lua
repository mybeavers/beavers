require("nvim-tree").setup({
  my_on_attach = on_attach,
  filters = {
    dotfiles = true,
    custom = {"^.git$","*.class"},--过滤.git和.class文件
  },
   disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    width = 30,
    preserve_window_proportions = true,
  },
  renderer = {
    root_folder_label = false,
    highlight_git = true,
    indent_markers = { enable = true },
  },

})





