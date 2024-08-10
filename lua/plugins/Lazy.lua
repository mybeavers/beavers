local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)




require("lazy").setup({

    -- +==================================+
    -- |               功能               |
    -- +==================================+
    -- 目录
    {
        "nvim-tree/nvim-tree.lua",
        event = "VimEnter",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            require("plugins.nvimtree")
            MyKeymap("n", "<C-b>", ":NvimTreeToggle<CR>", MyKeymapOpt)
            MyKeymap("i", "<C-b>", "<ESC>:NvimTreeToggle<CR>", MyKeymapOpt)
        end,

    },

    {
        'nvim-treesitter/nvim-treesitter',
        event = "VimEnter",
    },
-- 文件搜索
    {
        "nvim-telescope/telescope.nvim",
        event = "VimEnter",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            MyKeymap("n", "<leader>t", ":Telescope<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>o", ":Telescope oldfiles<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>f", ":Telescope find_files<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>b", ":Telescope buffers<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", MyKeymapOpt)
        end,
    },

-- 括号自动补齐
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')
            local cmp = require('cmp')
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )
        end
    },


-- +==================================+
-- |               UI                 |
-- +==================================+
-- 主题colorscheme
    {
        "olimorris/onedarkpro.nvim",
        priority = 1000,
        config = function()
            require("onedarkpro").setup({
                options = {
                    transparency = true
                }
            })

            vim.cmd("colorscheme onedark")
        end,

    },

-- 主页
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
        config = function()
            require("plugins.dashboard")
        end,
    },


-- 标签页
    {
        "akinsho/bufferline.nvim",
        event = "InsertEnter",
        config = function()
            MyKeymap("n", "3", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", MyKeymapOpt)
        end,
    },

-- 底栏
    {
        "nvim-lualine/lualine.nvim",
        event = "InsertEnter",
    },
-- git标记
    {
        "lewis6991/gitsigns.nvim",
        event = "InsertEnter",
    },


-- +==================================+
-- |          lsp服务器               |
-- +==================================+
-- lsp服务器按照插件
    {
        "williamboman/mason.nvim",
        event = "InsertEnter",
    },

-- lsp服务器配置插件
    {
        "neovim/nvim-lspconfig",
        event = "InsertEnter",
    },


-- +==================================+
-- |          cmp代码补全             |
-- +==================================+
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",

            {
                'L3MON4D3/LuaSnip',
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
                    require("luasnip.loaders.from_snipmate").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
                end
            },
            {
                'saadparwaiz1/cmp_luasnip',
                build = "make install_jsregexp"
            },
        },
    
    config = function()
        require('plugins.CmpNvim')
        require('mason').setup()
        require('plugins.LspConfig')
    end
}
})


