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


-- 目录关闭
vim.api.nvim_create_user_command("MakeDirectory", function()
    ---@diagnostic disable-next-line: missing-parameter
    local path = vim.fn.expand("%")
    local dir = vim.fn.fnamemodify(path, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    else
        vim.notify("Directory already exists", "WARN", { title = "Nvim" })
    end
end, { desc = "Create directory if it doesn't exist" })




