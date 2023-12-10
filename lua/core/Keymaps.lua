-- 保存本地变量\m\m\m
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

-- 之后就可以这样映射按键了
-- map('模式','按键','映射为XX',opt)
-- <space>  代表: 空格
-- <leader> 代表: \
-- =        格式化代码,只能格式缩进
-- gd       跳转道函数定义
-- \n       重命名
-- <

--+====================================+
--|            快捷键                  |
--+====================================+


-- 一键分割窗口
map ("n", "vs", ":vs<CR>", opt)
map ("n", "pl", ":split<CR>", opt)


-- 一键保存退出
map("n", "<ESC>", ":lua SaveAllFiles()<CR>", opt)
map('n', "q", ":bd<CR>", opt)

-- 一键编译运行
map("i", "<F24>", "<ESC>:lua RunCode()<CR>", opt)
map("n", "<F24>", ":lua RunCode()<CR>", opt)


-- 目录树
map('i', '<C-b>', '<ESC>:Ntree<CR>', opt)
map('n', '<C-b>', ':Ntree<CR>', opt)


-- 加载更多配置
map("n", "<A-=>", ":source /home/mybeavers/.config/nvim/lua/plugins/HeavyInit.lua<CR>", opt)


-- 标签页切换
map('n', '1', ':bprevious<CR>', opt)
map ("n", "2", ":bNext<CR>", opt)


-- 主题切换
map('n', '-', "<cmd>lua ChooseColorTheme()<CR>", opt)


-- TermToggle
map('n', '<F5>', ':lua TermToggle()<CR>', opt)
map('t', '<F5>', '<Esc> <C-\\><C-n>', opt)


-- +====================================+
-- |            快捷键函数              |
-- +====================================+

chooseColorthemeCount = 0;
function ChooseColorTheme()
    local colorthemes = {'onelight', 'retrobox', 'habamax', 'retrobox', 'onedark'};
    chooseColorthemeCount = chooseColorthemeCount + 1;
    if chooseColorthemeCount > #colorthemes then
        chooseColorthemeCount = 1;
    end
    vim.cmd("color "..colorthemes[chooseColorthemeCount]);
    vim.cmd('highlight! CursorLine guibg=Normal')
end




function SaveAllFiles()
    vim.cmd('silent wall')
    if vim.bo.filetype == 'markdown' then
        vim.cmd('MarkdownPreviewStop')
    end
    vim.cmd('q')
end




function RunCode()
    vim.cmd('w')

    if not vim.fn.isdirectory('.build') then
        vim.fn.mkdir('.build')
    end

    if vim.bo.filetype == 'java' then
        vim.cmd('!javac % && java %< && mv %:h/*.class ./.build/')

    elseif vim.bo.filetype == 'c' then
       vim.cmd('!gcc % -o .build/%< && time ./.build/%<')

    elseif vim.bo.filetype == 'python' then
        vim.cmd('!python3 %')

    elseif vim.bo.filetype == 'markdown' then
        vim.cmd('MarkdownPreview')
    end
end




function TermToggle()
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  if buftype == 'terminal' then
    vim.cmd('bd!')
  else
    vim.cmd(':10split term://$SHELL')
  end
end
