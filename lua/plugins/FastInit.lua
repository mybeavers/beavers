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
    {'glepnir/dashboard-nvim',
        commit = "f7d623457d6621b25a1292b24e366fae40cb79ab",
    },
    -- 标签页
    "akinsho/bufferline.nvim",
    -- 底栏
    "nvim-lualine/lualine.nvim",
    -- git标记
    "lewis6991/gitsigns.nvim";

    "lukas-reineke/indent-blankline.nvim",
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

require("plugins.dashboard")
require("plugins.nvimtree")
require("plugins.markdown")

-- lsp
require("lsp")
require("lsp.cmp")

-- 加载我的代码片段--路径
vim.cmd('let g:UltiSnipsSnippetDirectories = ["~/.config/nvim/lua/ulits/"]')
-- 选中触发
vim.cmd('let g:UltiSnipsExpandTrigger="<leader>y"')
vim.cmd('let g:UltiSnipsExpandTrigger="<tab>"')
