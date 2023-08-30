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




----------------------------------
--          更换主题
-- -------------------------------
local count = 0;
local function ChooseColorTheme()
    local ColorThemes = {'onelight', 'retrobox', 'habamax', 'retrobox', 'quiet', 'onedark'};
    count = count + 1;
    if count > #ColorThemes then
        count = 0;
    end
    vim.cmd("color "..ColorThemes[count]);
end

