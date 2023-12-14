require('core.Basic')
require('core.Keymaps')
require("core.UI")

-- 鍩虹閰嶇疆 [鎻掍欢绠＄悊鍣?寮€濮嬮〉/鐩綍鏍慮
require('plugins.Lazy')
require('plugins.dashboard')
require("plugins.nvimtree")


--  LSP 
require("plugins.CmpNvim")
require("plugins.LspInit")


-- 鍔犺浇鎴戠殑浠ｇ爜鐗囨--璺緞
vim.cmd('let g:UltiSnipsSnippetDirectories = ["~/.local/share/nvim/UltiSnips/"]')

-- 閫変腑瑙﹀彂
vim.cmd('let g:UltiSnipsExpandTrigger="<leader>y"')
vim.cmd('let g:UltiSnipsExpandTrigger="<tab>"')
-- icons: 
    --"＞◡❛", " " ," ", " ", " ", " ", " ", " ", " ", ''
    --"",""," ,"ﰊ","", "", "", "", ""
