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


