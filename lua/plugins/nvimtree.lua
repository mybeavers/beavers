vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    my_on_attach = on_attach,
    filters = {
        dotfiles = true,
        custom = { "^.git$", "*.class" }, --过滤.git和.class文件
    },
    disable_netrw = false,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
    },
    view = {
        width = 25,
        preserve_window_proportions = true,
    },
    renderer = {
        root_folder_label = false,
        highlight_git = true,
        indent_markers = { enable = false },
    },

})
