local autocmd = vim.api.nvim_create_autocmd


-- ///////////////////////////////////////////////////////////////////////
--                            自动程序
-- //////////////////////////////////////////////////////////////////////

-- 将wsl中的nvim复制内容复制到windows粘贴板
if vim.fn.has('wsl') then
    vim.cmd [[
        augroup Yank
        autocmd!
        autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
        augroup END
    ]]
end


-- 自动保存
autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    command = "silent! wall",
    nested = true,
})


-- 恢复光标位置
autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            vim.cmd("silent! foldopen")
        end
    end,
    nested=true
})



-- 目录关闭
vim.api.nvim_create_user_command("MakeDirectory", function()
    ---@diagnostic disable-next-line: missing-parameter
    local path = vim.fn.expand("%")
    local dir = vim.fn.fnamemodify(path, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    else
        vim.notify("Directory already exists", "WARN", { title = "Nvim" })
    end
end, { desc = "Create directory if it doesn't exist" })


-- 创建Java Maven项目目录
vim.cmd('command MvnJavaSE :execute "!cp -r ~/.config/templates/javaSE/* ./"')
vim.cmd('command MvnJavaMVC :execute "!cp -r ~/.config/templates/javaMVC/* ./"')
vim.cmd('command MvnJavaSpringBoot :execute "!cp -r ~/.config/templates/javaSpringBoot/* ./"')



-- ///////////////////////////////////////////////////////////////////////
--                                  Keymap快捷键函数              
-- //////////////////////////////////////////////////////////////////////
-- 主题切换
local chooseColorthemeCount = 0;
function ChooseColorTheme()
    local colorthemes = {'onelight', 'retrobox', 'onedark', 'retrobox', "vim"}; --retrobox
    chooseColorthemeCount = chooseColorthemeCount + 1;
    if chooseColorthemeCount > #colorthemes then
        chooseColorthemeCount = 1;
    end

    vim.cmd("color "..colorthemes[chooseColorthemeCount]);

    if chooseColorthemeCount == 5 then
        vim.cmd("highlight! SignColumn guibg=bg")
    end

    if chooseColorthemeCount == 1 or chooseColorthemeCount ==3 then
        vim.cmd('highlight! CursorLine guibg=Normal')
        vim.api.nvim_set_hl(0, 'javaType', {fg = CoreUIColorGroup.magenta})                           -- 数据类型
        vim.api.nvim_set_hl(0, '@lsp.type.modifier.java', {link='javaType'})                          -- 关键字
        vim.api.nvim_set_hl(0, '@lsp.type.method.java', {fg = CoreUIColorGroup.SoftBlue})             -- 方法/函数
        vim.api.nvim_set_hl(0, '@lsp.type.property.java', {fg = CoreUIColorGroup.SoftRed}) --变量
        vim.api.nvim_set_hl(0, '@lsp.type.parameter.java', {fg = CoreUIColorGroup.SoftRed})-- 变量
        vim.api.nvim_set_hl(0, '@lsp.type.class.java', {fg = CoreUIColorGroup.SoftOrange})            -- 类
        vim.api.nvim_set_hl(0, 'javaClassDecl', {link='javaType'})                                    -- 实现
        vim.api.nvim_set_hl(0, '@lsp.type.annotationMember.java', {fg = CoreUIColorGroup.SoftBlue})   -- 注解方法
        vim.api.nvim_set_hl(0, '@lsp.type.enumMember.java', {fg = CoreUIColorGroup.ModerateOrange})   -- 枚举常量
    end

    if chooseColorthemeCount == 5 then
        vim.api.nvim_set_hl(0, '@lsp.type.modifier.java', {link = "Special"})   -- 枚举常量
        vim.api.nvim_set_hl(0, '@lsp.type.class.java', {link = "javaOperator"})   -- 枚举常量

        vim.api.nvim_set_hl(0, 'markdownH4', {link="Special"})
        vim.api.nvim_set_hl(0, 'markdownH5', {link="Special"})
        vim.api.nvim_set_hl(0, 'markdownBold', {link="htmlTag"})
        vim.api.nvim_set_hl(0, 'markdownItalic', {link="Constant"})
        -- Special

    end
end

-- 自动保存所以已经打开的文件
function SaveAllFiles()
    vim.cmd('silent wall')
    if vim.bo.filetype == 'markdown' then
        vim.cmd('MarkdownPreviewStop')
    end
    vim.cmd('q')
end



-- 一键运行程序: c/java/python
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



-- 终端打开与关闭
function TermToggle()
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  if buftype == 'terminal' then
    vim.cmd('bd!')
  else
    vim.cmd(':10split term://$SHELL')
  end
end



-- 注释的添加与删除
function CommentToggle()
    local filetype = vim.bo.filetype
    local cursorLineString = vim.api.nvim_get_current_line()
    local cursorLineFirstChar = string.sub(cursorLineString,1,1)

    if cursorLineString == "" then print("nil") return end

    if filetype == 'lua' and cursorLineFirstChar ~= '-' then
        vim.cmd(":'<,'>s/^/--")
    elseif filetype == 'lua' and cursorLineFirstChar == '-' then
        vim.cmd(":'<,'>s/--/")
    elseif (filetype == 'java' or filetype == 'c') and cursorLineFirstChar ~= '/' then
        vim.cmd(":'<,'>s/^/\\/\\//")
    elseif (filetype == 'java' or filetype == 'c') and cursorLineFirstChar == '/' then
        vim.cmd(":'<,'>s/\\/\\///")
    elseif filetype == 'python' and cursorLineFirstChar ~= '#' then
        vim.cmd(":'<,'>s/^/#")
    elseif filetype == 'python' and cursorLineFirstChar == '#' then
        vim.cmd(":'<,'>s/#/")
    else
        print('error:\t', cursorLineFirstChar)
    end

end


