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
        event = "BufReadPost",
        build = ":TSUpdate",
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
            MyKeymap("n", "<leader>d", ":Telescope diagnostics<CR>", MyKeymapOpt)

--            -- 对lspconfig原始功能的替换
--            MyKeymap("n", "<space>g", ":Telescope lsp_definitions<CR>", MyKeymapOpt)
--            MyKeymap("n", "<space>s", ":Telescope lsp_references<CR>", MyKeymapOpt)
--            MyKeymap("n", "<space>i", ":Telescope lsp_implementations<CR>", MyKeymapOpt)
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = "BufReadPost",
        config = function()
            require("plugins.autopairs")
        end
    },
    -- 括号自动补齐
    {
        'echasnovski/mini.nvim',
        event = "BufReadPost",
    },
    {
        "MunifTanjim/nui.nvim",
        config = function()
            require("plugins.NuiConfig")
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
                    transparency = false
                },
                styles = {
                    comments = "italic",
                },
                colors = {
                    onelight = { bg = "#fffafa" }, -- 雪色
                }
            })
            local hour = tonumber(os.date("%H"))
            if hour >= 12 and hour < 15 then
                vim.cmd("colorscheme " .. "onelight")
            else
                vim.cmd("colorscheme " .. "onedark")
            end
        end

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
        event = "BufReadPost",
    },

    -- lsp服务器配置插件
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPost",
    },


    -- +==================================+
    -- |          cmp代码补全             |
    -- +==================================+
    {
        "hrsh7th/nvim-cmp",
        event = "BufReadPost",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",

            {
                'L3MON4D3/LuaSnip',
                dependencies = {
                    "rafamadriz/friendly-snippets" },
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load({ paths = "~/.config/nvim/lua/snippets" })
                end
            },

            {
                'saadparwaiz1/cmp_luasnip',
                build = "make install_jsregexp"
            },
        },

        config = function()
            require('mason').setup()
            require('plugins.CmpConfig')
            require('plugins.LspConfig')
        end
    }
})
