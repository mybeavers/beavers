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
map('n', '<F5>', ':lua TermToggle()<CR>', opt)
map('t', '<F5>', '<Esc> <C-\\><C-n>', opt)

vim.cmd([[ 
    :tnoremap <Esc> <C-\><C-n>:bd!<CR>
]])


-- 2 =======一键退出/保存/保存退出=========
map ("n", "w", ":silent wall<CR>", opt)
map ("n", "q", ":q<CR>", opt)


-- 3 ===========一键保存退出=================
map("i", "<F22>", "<ESC>:call Wq_txt()<CR>", opt)
map("n", "<F22>", ":call Wq_txt()<CR>", opt)



-- 4 ============一键编译运行================

map("i", "<F24>", "<ESC>:call RunCode()<CR>", opt)
map("n", "<F24>", ":call RunCode()<CR>", opt)

-- 5 ============目录树======================
map('i', '<C-b>', '<ESC>:Ntree<CR>', opt)
map('n', '<C-b>', ':Ntree<CR>', opt)

-- 5 ==============加载更多配置=================
map("n", "<A-=>", ":source /home/mybeavers/.config/nvim/lua/plugins/HeavyInit.lua<CR>", opt)




-- 7 ==============标签页切换=============
map('n', '1', ':bprevious<CR>', opt)
map ("n", "2", ":bNext<CR>", opt)


-- 8  ==============主题切换=============
map('n', '-', "<cmd>lua Choosecolortheme()<CR>", opt)


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

-- 定义一个lua函数，用来切换打开或关闭一个终端
function TermToggle()
  -- 获取当前的缓冲区类型
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  -- 如果当前的缓冲区是终端，就强制删除它
  if buftype == 'terminal' then
    vim.cmd('bd!')
  -- 否则，就在新的水平分割窗口中打开一个终端
  else
    vim.cmd(':10split term://$SHELL')
  end
end

