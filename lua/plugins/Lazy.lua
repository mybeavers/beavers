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
    -- 目录树
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = function ()
            MyKeymap("n", "<C-b>", ":NvimTreeToggle<CR>", MyKeymapOpt)
            MyKeymap("i", "<C-b>", "<ESC>:NvimTreeToggle<CR>", MyKeymapOpt)
        end,

    },

    -- 文件搜索
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config=function ()
            MyKeymap("n", "<leader>t", ":Telescope<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>o", ":Telescope oldfiles<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>f", ":Telescope find_files<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>b", ":Telescope buffers<CR>", MyKeymapOpt)
            MyKeymap("n", "<leader>s", ":Telescope lsp_document_symbols<CR>", MyKeymapOpt)
        end,
    },

    -- markdown预览
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]() end,
            config =function ()
                vim.g["mkdp_path_to_chrome"] = ""   -- 浏览器路径 --本机默认浏览器
                vim.g["mkdp_open_to_the_world"] = 0 -- 默认监听127.0.0.1
            end,
        },


        -- +==================================+
        -- |               UI                 |
        -- +==================================+
        -- 主题colorscheme
        {
            "olimorris/onedarkpro.nvim",
            priority = 1000,
            config = function()
                vim.cmd("colorscheme onedark")
            end,

        },
        {
            'nvimdev/dashboard-nvim',
            event = 'VimEnter',
            dependencies = { {'nvim-tree/nvim-web-devicons'}}
        },
        -- 标签页
        {
            "akinsho/bufferline.nvim",
            config = function ()
                MyKeymap ("n", "<A-0>", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", MyKeymapOpt)
            end,
        },
        -- 底栏
        "nvim-lualine/lualine.nvim",
        -- git标记
        "lewis6991/gitsigns.nvim",

-- +==================================+
-- |          lsp服务器               |
-- +==================================+
-- lsp服务器按照插件
    {"williamboman/mason.nvim",
        build = ":MasonUpdate",
        event = 'VimEnter',
    },
    -- lsp服务器配置插件
    {
        "neovim/nvim-lspconfig",
        event = "VimEnter",
    },


    -- +==================================+
    -- |          cmp代码补全             |
    -- +==================================+
    {
        "hrsh7th/nvim-cmp",
        event = "VimEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "SirVer/ultisnips",
            "quangnguyen30192/cmp-nvim-ultisnips",
        },
    },

})
