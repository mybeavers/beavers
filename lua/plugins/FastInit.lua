-- ----------------------------------------
-- 基础配置 [插件管理器/开始页/目录树]
-- ----------------------------------------
require('plugins.config.Lazy')
require("plugins.config.dashboard")
require("plugins.config.nvimtree")

----------------------------------
--          LSP 
-- -------------------------------
require('plugins.config.Mason')
require('plugins.config.CmpNvim')



-------------------------------
-- 加载我的代码片段--路径
-------------------------------
vim.cmd('let g:UltiSnipsSnippetDirectories = ["~/.local/share/nvim/UltiSnips/"]')

-- 选中触发
vim.cmd('let g:UltiSnipsExpandTrigger="<leader>y"')
vim.cmd('let g:UltiSnipsExpandTrigger="<tab>"')





