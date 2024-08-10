vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
         hover = {
            enabled = true,
            delay = 200,
        },
        diagnostics = "nvim_lsp",       -- 使用 nvim 内置lsp
        always_show_bufferline = true,  -- 显示bufferline
        show_close_icon = true,
        buffer_close_icon = "✗",
        separator_style="thin",        --separator_style = "slant" | "thick" | "thin" | {"any", "any"},
        left_trunc_marker = "",        -- 左边超过显示图标
        right_trunc_marker = "",       -- 右边超过显示图标
        max_name_length = 14,           -- 文件名大小
        max_prefix_length = 12,         -- tab大小
        tab_size = 15,
        modified_icon= "◍",
    },
}
