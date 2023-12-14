require("core.Utils")
MyKeymap = vim.api.nvim_set_keymap
MyKeymapOpt = {noremap = true, silent = true }


-- 映射按键语法
-- map('模式','按键','映射为XX',opt)

-- <space>  代表: 空格
-- <leader> 代表: \
-- =        格式化代码,只能格式缩进

-- 光标跳转: 
--      1/2
-- LSP快捷键: 
--      <space>+字母键
-- Telescope查找快捷键: 
--      <leader>+字母键


--+====================================+
--|            快捷键                  |
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


-- 光标快速跳转快捷键 -> 1/2
MyKeymap('n', '1', '<S-{>', MyKeymapOpt)                -- 光标跳转到上一个段落
MyKeymap('n', '2', '<S-}>', MyKeymapOpt)                -- 光标跳转下一个段落
MyKeymap('n', '<A-1>', ':bprevious<CR>', MyKeymapOpt)   -- 跳转到上一个buffer
MyKeymap("n", "<A-2>", ":bNext<CR>", MyKeymapOpt)       -- 跳转到下一个buffer


-- 快速注释
MyKeymap('v','3',':lua CommentToggle()<CR>', MyKeymapOpt)

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


-- 外侧退出括号
vim.cmd([[
    inoremap <expr> ) getline('.')[col('.')-1] == ')' ? "\<Right>" : ")"
    inoremap <expr> ] getline('.')[col('.')-1] == ']' ? "\<Right>" : "]"
    inoremap <expr> } getline('.')[col('.')-1] == '}' ? "\<Right>" : "}"
]])


-- 加载更多配置
MyKeymap("n", "<A-=>", ":source /home/mybeavers/.config/nvim/lua/HeavyInit.lua<CR>", MyKeymapOpt)


