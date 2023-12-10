-----------------------------------
--          基础设置
-----------------------------------
vim.o.number=true -- 开启行号


-- -------------------------------------------------------------
--          配置加载 [状态栏/底栏/缩进线/git显示]
-- -------------------------------------------------------------
require("plugins.config.bufferline")
require("plugins.config.lualine")
require('plugins.IndentLine').setup({char='│',}) -- 说明: 此缩进线功能全部截取自: nvimdev/indentmini.nvim 插件



-- ---------------------------------
--          根据时间加载主题
-- ---------------------------------
local hour = tonumber(os.date("%H"))

if hour >= 16 or hour < 10 then
    vim.cmd("color onedark")
else
    vim.cmd("color onelight")
end



-- gitsigns标记配置
require('gitsigns').setup({
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },

    numhl = true,         -- 当前行号是否修改
    linehl = false,       -- 当前行颜色是否修改
    signcolumn = false,
})
local highlight = vim.api.nvim_set_hl
highlight(0, 'GitSignsAdd', {fg=CoreUIColorGroup.green})
highlight(0, 'GitSignsDelete', {fg=CoreUIColorGroup.red})
highlight(0, 'GitSignsChange',{fg=CoreUIColorGroup.orange})


vim.cmd([[ 
let g:terminal_color_1 = '#ff0000'
let g:terminal_color_2 = 'green'
]])
