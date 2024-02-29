-----------------------------------
--          基础设置
-----------------------------------
vim.o.number=true -- 开启行号

-- -------------------------------------------------------------
--          配置加载 [状态栏/底栏/缩进线/git显示]
-- -------------------------------------------------------------
require("plugins.bufferline")
require("plugins.lualine")
require('plugins.IndentLine').setup({char='│',}) -- 说明: 此缩进线功能全部截取自: nvimdev/indentmini.nvim 插件



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

