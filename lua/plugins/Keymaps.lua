-- 保存本地变量\m\m\m
local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }


-- 6 ===========文件搜索/函数预览==========
--   ====依赖于telescop和treesitter插件====
map("n", "to", ":Telescope oldfiles<CR>", opt)
map("n", "tf", ":Telescope find_files<CR>", opt)
map("n", "tb", ":Telescope buffers<CR>", opt)
map("n", "ts", ":Telescope lsp_document_symbols<CR>", opt)



-- 7 ==============标签页切换=============
map ("n", "1", ":BufferLineCyclePrev<CR>", opt)
map ("n", "2", ":bNext<CR>", opt)



-- 8 ===============目录树==================
map("n", "<C-b>", ":NvimTreeToggle<CR>", opt)
map("i", "<C-b>", "<ESC>:NvimTreeToggle<CR>", opt)


-- 9 ==============函数预览================
map("n", "<C-s>", ":SymbolsOutline<CR>", opt)
map("i", "<C-s>", "<ESC>:SymbolsOutline<CR>", opt)


-- 10 =============主题切换================
vim.api.nvim_set_keymap("n", "0", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", {noremap = true, silent = true})
