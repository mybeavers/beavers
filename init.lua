require('core.Basic')
require('core.Keymaps')
require("core.UI")


require('plugins.Lazy')
require('plugins.dashboard')
require("plugins.nvimtree")


--  LSP 
require("plugins.CmpNvim")
require("plugins.LspInit")

-- my code
vim.cmd('let g:UltiSnipsSnippetDirectories = ["./lua/UltiSnips/"]')
vim.cmd('let g:UltiSnipsExpandTrigger="<leader>y"')
vim.cmd('let g:UltiSnipsExpandTrigger="<tab>"')


-- icons: 
--"＞◡❛", " " ," ", " ", " ", " ", " ", " ", " ", ''
--"",""," ,"ﰊ","", "", "", "", ""

-- ---------------------------------
--          根据时间加载主题
-- ---------------------------------
local hour = tonumber(os.date("%H"))

if hour >= 16 or hour < 10 then
    vim.cmd("color onedark")
else
    vim.cmd("color onelight")
end



