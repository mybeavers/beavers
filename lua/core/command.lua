-- 创建maven项目目录
vim.cmd([[
command MavenTemplates :execute "! mkdir -p src/main/java/com && touch pom.xml && mkdir -p src/test/java && mkdir -p src/test && mkdir -p src/main/resources"
]])

vim.cmd([[
command Run :call Run()
]])



-- 一键编译运行函数
vim.cmd([[ 
    function! Run()
        execute 'silent w'

        if &filetype == 'java'
            execute "term java %"
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

    endfunction
]])

