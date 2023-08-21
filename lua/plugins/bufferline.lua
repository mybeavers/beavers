vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
         hover = {
            enabled = true,
            delay = 200,
        },
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
       -- 显示bufferline
        always_show_bufferline = true,
        show_close_icon = false,
        buffer_close_icon = "",
        --separator_style = "slant" | "thick" | "thin" | {"any", "any"},
        separator_style="thin",
        -- 左边超过显示图标 
        left_trunc_marker = "",
        -- 右边超过显示图标
        right_trunc_marker = "",
        -- 文件名大小 
        max_name_length = 14,
        --显示栏大小 
        max_prefix_length = 12,
        -- tab大小
        tab_size = 15,
        -- 未保存图标 
        --modified_icon = "●",
        modified_icon= "◍",

    }
}
