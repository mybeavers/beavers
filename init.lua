
require("core.Basic")
require('core.Utils') -- 该文件应该先加载以便其他文件调用函数
require('core.Keymaps')
require('core.UI')


require('plugins.Lazy')

-- -------------------------------
--          新功能
-- -------------------------------
vim.lsp.inlay_hint.enable() --嵌入提示 NeoVim-0.10.0


-- -----------------------------
-- 自动命令
-- -----------------------------
-- 当打开文件大于2时, 开启
autocmd("BufNew", {
    pattern = "*",
    callback = function()
        local buffer_count = #vim.fn.getbufinfo({ buflisted = 1 })
        if buffer_count >= 3 and buffer_count < 4 then
            vim.o.number = true -- 开启行号
            require("core.statuline")
            require("plugins.bufferline")
            require("mini.indentscope").setup()
            require('gitsigns').setup ({
                signs        = {
                    add    = { text = '│' },
                    change = { text = '│' },
                },
                signs_staged = {
                    add    = { text = '│' },
                    change = { text = '│' },
                },
                signcolumn   = false,
                numhl        = true,
            })
            MyKeymap("n", "<leader>d", ":Gitsigns diffthis<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>h", ":Gitsigns toggle_linehl<CR>", MyKeymapOpt)
        end
    end,
    nested = true
})


