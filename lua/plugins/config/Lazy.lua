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

vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

local map = vim.api.nvim_set_keymap
local opt = {noremap = true, silent = true }

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
            map("n", "<C-b>", ":NvimTreeToggle<CR>", opt)
            map("i", "<C-b>", "<ESC>:NvimTreeToggle<CR>", opt)
        end,

    },

    -- 文件搜索
   {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config=function ()
            map("n", "to", ":Telescope oldfiles<CR>", opt)
            map("n", "tf", ":Telescope find_files<CR>", opt)
            map("n", "tb", ":Telescope buffers<CR>", opt)
            map("n", "ts", ":Telescope lsp_document_symbols<CR>", opt)
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
            vim.cmd([[colorscheme onedark]])
        end,

    },
    --开始页
    {

        'glepnir/dashboard-nvim',
            commit = "f7d623457d6621b25a1292b24e366fae40cb79ab",

        },
    -- 标签页
    {
        "akinsho/bufferline.nvim",
        config = function ()
            map ("n", "0", ":BufferLineCloseLeft<CR>:BufferLineCloseRight<CR>", opt)
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
    },
    -- lsp服务器配置插件
    "neovim/nvim-lspconfig",

    -- +==================================+
    -- |          cmp代码补全             |
    -- +==================================+
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "SirVer/ultisnips",
            "quangnguyen30192/cmp-nvim-ultisnips",
        },
    },

})