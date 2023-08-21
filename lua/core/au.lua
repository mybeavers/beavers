-- 将wsl中的nvim复制内容同步到windows粘贴板
if vim.fn.has('wsl') then
    vim.cmd [[
        augroup Yank
        autocmd!
        autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
        augroup END
    ]]
end

-- 自动保存
vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = { "*" },
    command = "silent! wall",
    nested = true,
})


-- 恢复光标位置
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            vim.cmd("silent! foldopen")
        end
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    command = "highlight! MyCmpSel guibg=#61AFEF guifg=#000000",
    nested = true,
})




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

-- 自动补齐字符
vim.cmd([[
    inoremap ( ()<LEFT>
    inoremap [ []<LEFT>
    inoremap { {}<LEFT>
    inoremap " ""<LEFT>
    inoremap ' ''<LEFT>
]])

-- 外侧退出括号
vim.cmd([[
    inoremap <expr> ) getline('.')[col('.')-1] == ')' ? "\<Right>" : ")"
    inoremap <expr> ] getline('.')[col('.')-1] == ']' ? "\<Right>" : "]"
    inoremap <expr> } getline('.')[col('.')-1] == '}' ? "\<Right>" : "}"
]])

-- 快速注释
vim.cmd([[ 
    vnoremap <silent> 1 :s/^/\/\//<CR>
    vnoremap <silent> 2 :s/\/\//<CR>
]])

-- 语法高亮
vim.cmd([[
function! JavaHighlightLspTypes()
  highlight @lsp.type.modifier.java guifg=#C678DD           "关键字
  highlight @lsp.type.class.java guifg=#E5C07B              "类
  highlight @lsp.type.property.java guifg=#E06C75           "变量
  highlight @lsp.type.method.java guifg=#61AFEF             "方法
  highlight @lsp.type.annotationMember.java guifg=#61AFEF   "注解方法
  highlight @lsp.type.enumMember.java guifg=#D19A66         "枚举常量
endfunction

autocmd ColorScheme * call JavaHighlightLspTypes()
]])


vim.cmd([[ 
function! MyCmpColor()
    " gray
    highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
    " blue
    highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
    highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
    " light blue
    highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
    highlight! link CmpItemKindInterface CmpItemKindVariable
    highlight! link CmpItemKindText CmpItemKindVariable
    " pink
    highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
    highlight! link CmpItemKindMethod CmpItemKindFunction
    " front
    highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
    highlight! link CmpItemKindProperty CmpItemKindKeyword
    highlight! link CmpItemKindUnit CmpItemKindKeyword
    highlight! User1 guifg=#7f828e
endfunctio

autocmd ColorScheme * call MyCmpColor()
]])

