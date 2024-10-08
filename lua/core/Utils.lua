MyKeymap = vim.api.nvim_set_keymap
MyKeymapOpt = { noremap = true, silent = true }
api = vim.api
cmd = vim.cmd
highlight = vim.api.nvim_set_hl
autocmd = vim.api.nvim_create_autocmd

---------------------------------
-- NOTE  AUTOCMD CODE
---------------------------------

-- 将wsl中的nvim复制内容复制到windows粘贴板
if vim.fn.has('wsl') then
    cmd [[
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


-- 离开窗口时,关闭qf文件
autocmd({ "WinLeave" }, {
    pattern = '*',
    callback = function()
        local buftype = vim.bo.buftype
        if buftype == 'quickfix' then
            vim.cmd('cclose')
        end
    end,
})

-- 恢复光标位置
autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            cmd("silent! foldopen")
        end
    end,
    nested = true
})

-- 创建Java Maven项目目录
cmd('command MvnJavaSE :execute "!cp -r ~/.config/templates/javaSE/* ./"')
cmd('command MvnJavaMVC :execute "!cp -r ~/.config/templates/javaMVC/* ./"')
cmd('command MvnJavaSpringBoot :execute "!cp -r ~/.config/templates/javaSpringBoot/* ./"')


---------------------------
-- NOTE  TOOL METHOD
---------------------------
-- 主题切换
local keyCountColors = 0;
function ThemeToggle()
    local colorthemes = { 'onelight', 'retrobox', "onedark", 'retrobox', 'randomhue', 'minicyan', 'minischeme' }
    keyCountColors = keyCountColors + 1;
    if keyCountColors > #colorthemes then keyCountColors = 1 end

    cmd("color " .. colorthemes[keyCountColors]);
    OnedarkPlus()
end

-- 自动保存所以已经打开的文件
function SaveAllFiles()
    cmd('silent wall')
    cmd('q')
end

-- 一键运行程序: c/java/python
function RunCode()
    cmd('w')
    if not vim.fn.isdirectory('.build') then
        vim.fn.mkdir('.build')
    end
    if vim.bo.filetype == 'java' then
        cmd('!javac % && java %< && mv %:h/*.class ./.build/')
    elseif vim.bo.filetype == 'c' then
        cmd('!gcc % -o .build/%< && time ./.build/%<')
    elseif vim.bo.filetype == 'python' then
        cmd('!python3 %')
    end
end

-- 终端打开与关闭
function TermToggle()
    local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
    if buftype == 'terminal' then
        cmd('bd!')
    else
        cmd(':10split term://$SHELL')
    end
end

-- NOTE  注释的添加与删除
function CommentToggle()
    local filetype = vim.bo.filetype
    local cursorLineString = vim.api.nvim_get_current_line()
    local cursorLineFirstChar = string.sub(cursorLineString, 1, 1)

    if cursorLineString == "" then
        print("nil")
        return
    end

    if filetype == 'lua' and cursorLineFirstChar ~= '-' then
        cmd(":'<,'>s/^/--")
    elseif filetype == 'lua' and cursorLineFirstChar == '-' then
        cmd(":'<,'>s/--/")
    elseif (filetype == 'java' or filetype == 'c') and cursorLineFirstChar ~= '/' then
        cmd(":'<,'>s/^/\\/\\//")
    elseif (filetype == 'java' or filetype == 'c') and cursorLineFirstChar == '/' then
        cmd(":'<,'>s/\\/\\///")
    elseif filetype == 'python' and cursorLineFirstChar ~= '#' then
        cmd(":'<,'>s/^/#")
    elseif filetype == 'python' and cursorLineFirstChar == '#' then
        cmd(":'<,'>s/#/")
    else
        print('error:\t', cursorLineFirstChar)
    end
end

-- 对默认主题的修改增强
function VimPlus()
    cmd("highlight! CursorLine guibg=bg")
    cmd("highlight! SignColumn guibg=bg")
    highlight(0, '@lsp.type.modifier.java', { link = "Special" })   -- 枚举常量
    highlight(0, '@lsp.type.class.java', { link = "javaOperator" }) -- 枚举常量

    highlight(0, 'markdownH4', { link = "Special" })
    highlight(0, 'markdownH5', { link = "Special" })
    highlight(0, 'markdownBold', { link = "htmlTag" })
    highlight(0, 'markdownItalic', { link = "Constant" })
end

function OnedarkPlus()
    highlight(0, 'javaType', { fg = CoreUIColorGroup.magenta })                    -- 数据类型
    highlight(0, '@lsp.type.modifier', { link = 'javaType' })                      -- 关键字
    highlight(0, '@lsp.type.method', { fg = CoreUIColorGroup.SoftBlue })           -- 方法/函数
    highlight(0, '@lsp.type.property', { fg = CoreUIColorGroup.SoftRed })          --变量
    highlight(0, '@lsp.type.parameter', { fg = CoreUIColorGroup.SoftRed })         -- 变量
    highlight(0, '@lsp.type.class', { fg = CoreUIColorGroup.SoftOrange })          -- 类
    highlight(0, 'javaClassDecl', { link = 'javaType' })                           -- 实现
    highlight(0, '@lsp.type.annotationMember', { fg = CoreUIColorGroup.SoftBlue }) -- 注解方法
    highlight(0, '@lsp.type.enumMember', { fg = CoreUIColorGroup.ModerateOrange }) -- 枚举常量
end

function RetroboxPlus()
    cmd("highlight! CursorLine guibg=bg")
end

function MyStatusLine()
    return '%9*%=%-7.(%l,%c%V%) %t  '
end

-- 获取当前目录分支
function GetGitBranch()
    local handle = io.popen("git rev-parse --abbrev-ref HEAD 2> /dev/null")
    if handle == nil then
        return ""
    end

    local branch = handle:read("*a")
    handle:close()
    if branch == "" or branch == nil then
        return "NotGit"
    end
    return branch:gsub("%s+", "")
    -- "",   "
end

-- 获取当前git项目名称
function GetGitRepertoryName()
    local handle = io.popen("git rev-parse --show-toplevel 2> /dev/null")
    if handle == nil then
        return ""
    end


    local repo_path = handle:read("*a")
    handle:close()

    if repo_path == "" or repo_path == nil then
        return getPWD()
    end
    return repo_path:match("([^/]+)$"):gsub("%s+", "")
end

-- 获取打开neovim目录位置
function getPWD()
    local handle = io.popen("pwd")

    if handle == nil then
        return ""
    end

    local path = handle:read("*a")
    handle:close()

    if path == "" or path == nil then
        return "NvimTree"
    end

    splitstr = vim.split(path, "/")
    return splitstr[#splitstr]:gsub("%s+", "")
end

-- 获取显示组的bg 以合适的格式返回
function get_highlight_group_bg(group_name)
    local hl = vim.api.nvim_get_hl_by_name(group_name, true)
    local str = vim.inspect(hl)
    local table = assert(loadstring("return" .. str))()
    local backgroundValue = table.background
    return "#" .. string.format("%x", backgroundValue)
end
