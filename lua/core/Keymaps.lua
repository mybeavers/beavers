MyKeymap = vim.api.nvim_set_keymap
MyKeymapOpt = {noremap = true, silent = true }


-- 映射按键语法
-- map('模式','按键','映射为XX',opt)

-- <space>  代表: 空格
-- <leader> 代表: \
-- =        格式化代码,只能格式缩进

-- LSP快捷键: 
--      <space>+字母键
-- Telescope查找快捷键: 
--      <leader>+字母键


--+====================================+ |            快捷键                  |
--+====================================+


-- 一键分割窗口
MyKeymap("n", "vs", ":vs<CR>", MyKeymapOpt)
MyKeymap("n", "pl", ":split<CR>", MyKeymapOpt)


-- 一键保存退出
MyKeymap("n", "<ESC>", ":lua SaveAllFiles()<CR>", MyKeymapOpt)
MyKeymap('n', "q", ":bd<CR>", MyKeymapOpt)

-- 一键编译运行
MyKeymap("i", "<F24>", "<ESC>:lua RunCode()<CR>", MyKeymapOpt)
MyKeymap("n", "<F24>", ":lua RunCode()<CR>", MyKeymapOpt)


-- 目录树
MyKeymap('i', '<C-b>', '<ESC>:Ntree<CR>', MyKeymapOpt)
MyKeymap('n', '<C-b>', ':Ntree<CR>', MyKeymapOpt)


-- 标签页切换
MyKeymap('n', '1', ':bprevious<CR>', MyKeymapOpt)
MyKeymap("n", "2", ":bNext<CR>", MyKeymapOpt)

-- 快速移动
MyKeymap('n', '3', ':10k<CR>', MyKeymapOpt)
MyKeymap('n', '4', ':10j<CR>', MyKeymapOpt)

-- 主题切换
MyKeymap('n', '-', "<cmd>lua ChooseColorTheme()<CR>", MyKeymapOpt)


-- TermToggle
MyKeymap('n', '<F5>', ':lua TermToggle()<CR>', MyKeymapOpt)
MyKeymap('t', '<F5>', '<Esc> <C-\\><C-n>', MyKeymapOpt)


-- 括号补全
MyKeymap('i', '(', '()<Left>', MyKeymapOpt)
MyKeymap('i', '[', '[]<Left>', MyKeymapOpt)
MyKeymap('i', '{', '{}<Left>', MyKeymapOpt)
MyKeymap('i', '"', '""<Left>', MyKeymapOpt)
MyKeymap('i', "'", "''<Left>", MyKeymapOpt)


-- 快速注释
MyKeymap('v', '1', ':lua AddComment()<CR>', MyKeymapOpt)
MyKeymap('v', '2', ':lua DeleteComment()<CR>', MyKeymapOpt)


-- 外侧退出括号
vim.cmd([[
inoremap <expr> ) getline('.')[col('.')-1] == ')' ? "\<Right>" : ")"
inoremap <expr> ] getline('.')[col('.')-1] == ']' ? "\<Right>" : "]"
inoremap <expr> } getline('.')[col('.')-1] == '}' ? "\<Right>" : "}"
]])


-- 加载更多配置
MyKeymap("n", "<A-=>", ":source /home/mybeavers/.config/nvim/lua/HeavyInit.lua<CR>", MyKeymapOpt)



-- +====================================+
-- |            快捷键函数              |
-- +====================================+
local chooseColorthemeCount = 0;
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


function AddComment()
    if vim.bo.filetype == 'java' then
        vim.cmd(":'<,'>s/^/\\/\\//")
    elseif vim.bo.filetype == 'lua' then
        vim.cmd(":'<,'>s/^/--")
    elseif vim.bo.filetype == 'python' then
        vim.cmd(":'<,'>s/^/#")
    elseif vim.bo.filetype == 'c' then
        vim.cmd(":'<,'>s/^/\\/\\//")
    end
end

function DeleteComment()
    if vim.bo.filetype == 'java' then
        vim.cmd(":'<,'>s/\\/\\///")
    elseif vim.bo.filetype == 'c' then
        vim.cmd(":'<,'>s/\\/\\///")
    elseif vim.bo.filetype == 'lua' then
        vim.cmd(":'<,'>s/--/")
    elseif vim.bo.filetype == 'python' then
        vim.cmd(":'<,'>s/#/")
    end
end
