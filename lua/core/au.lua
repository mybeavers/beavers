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
vim.api.nvim_command("autocmd InsertLeave *.java,*.py,*.md,*.c,*.txt,*.sql silent wall")



-- 恢复光标位置
vim.cmd ([[
autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
]])


-- 切换主题时生效
vim.cmd([[
augroup MyColors
  autocmd!
  autocmd ColorScheme * highlight @lsp.type.modifier.java guifg=#C678DD
  autocmd ColorScheme * highlight StorageClass guifg=#C678DD
  autocmd ColorScheme * highlight Type guifg=#C678DD
augroup END
]])

