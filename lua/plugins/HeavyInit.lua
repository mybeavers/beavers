-----------------------------------
--          基础设置
-----------------------------------
vim.o.number=true -- 开启行号


-- ---------------------------------
--          配置加载
-- ---------------------------------
require("plugins.config.bufferline")
require("plugins.config.lualine")
require('plugins.IndentLine').setup({char='│',}) -- 说明: 此缩进线功能全部截取自: nvimdev/indentmini.nvim 插件



-- ---------------------------------
--          gitsigns配置
-- ---------------------------------

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


-- ---------------------------------
--          根据时间加载主题
-- ---------------------------------
local hour = tonumber(os.date("%H"))
if hour >= 16 or hour < 10 then
    vim.cmd("color onedark")
else
    require("onedarkpro").setup({
        colors= {
            light = {
                bg= "#fdf6e3",
            }
        }
    })
    vim.cmd("color onelight")
end



