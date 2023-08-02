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
    inoremap < <><LEFT>
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

