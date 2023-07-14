vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
         hover = {
            enabled = true,
            delay = 200,
--            reveal = {'close'}
        },
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        --[[
        offsets = {{
            filetype = "NvimTree",
            text = "File Directory",
            --highlight = "Directory",
            text_align = "left"
        }},
        ]]

        --[[        groups = {
            options = {
                toggle_hidden_on_enter = true -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
            },
            items = {
                {
                    name = "Code", -- Mandatory
                    highlight = {underline = false, sp = blue}, -- Optional
                    priority = 2, -- determines where it will appear relative to other groups (Optional)
                    --icon = "", -- Optional
                    auto_close = false,
                    matcher = function(buf) -- Mandatory
                        return buf.filename:match('%.java') or buf.filename:match('%.py')
                    end,
                    separator = { -- Optional
                      style = require('bufferline.groups').separator.tab
                    },
                },
                {
                    name = "Note",
                    highlight = {underline = false, sp = "green"},
                    priority = 1,
                    auto_close = false,  -- whether or not close this group if it doesn't contain the current buffer
                    matcher = function(buf)
                        return buf.filename:match('%.md') or buf.filename:match('%.txt')
                    end,
                    separator = { -- Optional
                      style = require('bufferline.groups').separator.tab
                    },
                }
            }
        },
        ]]
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
