require('core.Basic')
require('core.Utils') -- 该文件应该先加载以便其他文件调用函数
require('core.Keymaps')
require("core.UI")


require('plugins.Lazy')
require('plugins.dashboard')
require("plugins.nvimtree")


--  LSP 
require("plugins.CmpNvim")
require("mason").setup{}
require("plugins.LspConfig").setup()

-- my code
vim.cmd('let g:UltiSnipsSnippetDirectories = ["./lua/UltiSnips/"]')
vim.cmd('let g:UltiSnipsExpandTrigger="<leader>y"')
vim.cmd('let g:UltiSnipsExpandTrigger="<tab>"')

-- icons: 
--"＞◡❛", " " ," ", " ", " ", " ", " ", " ", " ", ''
--"",""," ,"ﰊ","", "", "", "", ""

--  根据时间加载主题
local hour = tonumber(os.date("%H"))

if hour >= 10 and hour < 16 then
    vim.cmd("color onelight")
else
    vim.cmd("color onedark")
end


