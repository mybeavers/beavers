vim.opt.termguicolors = true
highlight(0, 'MyBufferLineIcon1', { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.SoftRed })
local getGitRepertoryName = GetGitRepertoryName()
local getGitBranch = GetGitBranch()

require("bufferline").setup {
    options = {
        diagnostics = "nvim_lsp",      -- 使用 nvim 内置lsp
        always_show_bufferline = true, -- 显示bufferline
        show_close_icon = true,
        buffer_close_icon = "󰅖",
        --        separator_style = "thick", --separator_style = "slant" | "thick" | "thin" | {"any", "any"},
        left_trunc_marker = " ", -- 左边超过显示图标
        right_trunc_marker = " ", -- 右边超过显示图标
        max_name_length = 16, -- 文件名大小
        max_prefix_length = 13, -- tab大小
        tab_size = 16,
        modified_icon = "◍",
        custom_areas = {
            right = function()
                local result = {}
                table.insert(result, { text = "  " })
                table.insert(result, { text = " 󰅖 ", link = "MyBufferLineIcon1" })
                return result
            end,
        },
        offsets = {
            {
                filetype = "NvimTree",

                text = function()
                    if getGitBranch == "NotGit" then
                        return " " .. string.upper(getGitRepertoryName)
                    end
                    return " " .. string.upper(getGitRepertoryName) .. "/  " .. getGitBranch
                end,
                highlight = "Directory",
                text_align = "left"
            }
        }

    },
}
