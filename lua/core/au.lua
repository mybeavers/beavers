-- 将wsl中的nvim复制内容同步到windows粘贴板
if vim.fn.has('wsl') then
    vim.cmd [[
  augroup Yank
  autocmd!
  autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
  augroup END
    ]]   
end

--当退出插入模式则自动保存所有打开的文件
vim.cmd [[ 
    autocmd InsertLeave *.java,*.py,*.md,*.c,*.txt,*.sql silent wall
]]





--光标修改
vim.cmd[[ 
    autocmd VimLeave * set guicursor=n:ver50-ncvCursor
]]


-- 恢复光标位置
vim.cmd ([[
autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
]])
