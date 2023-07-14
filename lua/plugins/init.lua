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

require("lazy").setup({
    -- +==================================+
    -- |               功能               |
    -- +==================================+
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        priority = 1000,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    -- 文件搜索
   {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
    },

    -- markdown预览
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]() end,
    },
    -- 缩进线
    "lukas-reineke/indent-blankline.nvim",
    -- +==================================+
    -- |               UI                 |
    -- +==================================+

    -- 主题colorscheme
    {
        "olimorris/onedarkpro.nvim",
        priority = 900,
        config = function()
            vim.cmd([[colorscheme onedark]])
        end,

    },

    --开始页
    {'glepnir/dashboard-nvim',
        commit = "f7d623457d6621b25a1292b24e366fae40cb79ab",
    },

    -- 函数预览
    "simrat39/symbols-outline.nvim",
    -- 标签页
    "akinsho/bufferline.nvim",
    -- 底栏
    "nvim-lualine/lualine.nvim",
    -- +==================================+
    -- |          lsp服务器               |
    -- +==================================+
    
    {"williamboman/mason.nvim",
        build = ":MasonUpdate",
    },

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
 
