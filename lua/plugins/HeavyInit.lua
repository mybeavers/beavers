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
require('plugins.config.gitsigns')



-- ---------------------------------
--          根据时间加载主题
-- ---------------------------------
local hour = tonumber(os.date("%H"))

if hour >= 16 or hour < 10 then
    vim.cmd("color onedark")
else
    vim.cmd("color onelight")
end




