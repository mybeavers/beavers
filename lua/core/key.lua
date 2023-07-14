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


-- 1 =============一键分割窗口============= 
map ("n", "vs", ":vs<CR>", opt)
map ("n", "pl", ":split<CR>", opt)



-- 2 =======一键退出/保存/保存退出=========
map ("n", "w", ":silent wall<CR>", opt)
map ("n", "q", ":q<CR>", opt)



-- 3 ===========一键保存退出=================
map("i", "<F22>", "<ESC>:call Wq_txt()<CR>", opt)
map("n", "<F22>", ":call Wq_txt()<CR>", opt)



-- 4 ============一键编译运行================

map("i", "<F24>", "<ESC>:call RunCode()<CR>", opt)
map("n", "<F24>", ":call RunCode()<CR>", opt)




-- 5 ==============括号补全=================
-- 补全括号和引号
vim.cmd([[
    inoremap ( ()<LEFT>
    inoremap [ []<LEFT>
    inoremap { {}<LEFT>
    inoremap ' ''<LEFT>
    inoremap " ""<LEFT>
]])
--inoremap { {}<Esc>i<CR><Esc>koi<Esc>j<C-S-v><S-%>=j<S-$>xa

-- 外侧退出括号
vim.cmd([[
    inoremap <expr> ) getline('.')[col('.')-1] == ')' ? "\<Right>" : ")"
    inoremap <expr> ] getline('.')[col('.')-1] == ']' ? "\<Right>" : "]"
    inoremap <expr> } getline('.')[col('.')-1] == '}' ? "\<Right>" : "}"
]])


-- 6 ===========文件搜索/函数预览==========
--   ====依赖于telescop和treesitter插件====
map ("n", "<C-f>", ':Telescop<CR>', opt)


-- 7 ==============标签页切换=============
map ("n", "1", ":BufferLineCyclePrev<CR>", opt)
map ("n", "2", ":BufferLineCycleNext<CR>", opt)
map ("n", "3", ":BufferLinePickClose<CR>", opt)


-- 8 ===============目录树==================
map("n", "<C-b>", ":NvimTreeToggle<CR>", opt)
map("i", "<C-b>", "<ESC>:NvimTreeToggle<CR>", opt)


-- 9 ==============函数预览================
map("n", "<C-s>", ":SymbolsOutline<CR>", opt)
map("i", "<C-s>", "<ESC>:SymbolsOutline<CR>", opt)

-- 10 =============主题切换================

-- +====================================+
-- |            快捷键函数              |
-- +====================================+


--一键保存退出函数
vim.cmd([[
    function! Wq_txt()
        execute 'silent wall'
        if &filetype == 'markdown'
            execute 'MarkdownPreviewStop'
        endif
        execute 'q'
    endfunction
]])


-- 一键编译运行函数
vim.cmd([[ 
    function! RunCode()
        execute 'w'

        if &filetype == 'java'
            if !isdirectory('.build')
                execute "!mkdir .build"
            endif
            execute "!javac % && java %< && mv %:h/*.class  ./.build/ "
        endif


        if &filetype == 'c'
            if !isdirectory('.build')
                execute "!mkdir .build"
            endif
            execute "!gcc % -o .build/%< && time ./.build/%<"
        endif

        if &filetype == 'python'
            execute "term python3 %"
        endif

        if &filetype == "markdown"
            execute "MarkdownPreview"
        endif

    endfunction
]])

