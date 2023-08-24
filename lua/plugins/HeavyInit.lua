-----------------------------------
--          基础设置
-----------------------------------
vim.o.number=true -- 开启行号


-- ---------------------------------
--          配置加载
-- ---------------------------------
require("plugins.bufferline")
require("plugins.lualine")
require('gitsigns').setup({
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
})


