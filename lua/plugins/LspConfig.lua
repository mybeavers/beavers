-- -------------------------------------------
-- lsp keymap lspconifg
-- -------------------------------------------
local opts = { noremap=true, silent=true }
-- 查看代码诊断信息
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- 查看所有错误
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)


local lspconfig = require("lspconfig")
local function on_attach(client, bufnr) -- set up buffer keymaps, etc.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', '<space>d', vim.lsp.buf.declaration, bufopts)    -- 查看函数声明
    vim.keymap.set('n', '<space>g', vim.lsp.buf.definition, bufopts)    -- 查看函数实现
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)    --重命名函数
    vim.keymap.set('n', '<space>s', vim.lsp.buf.references, bufopts)    -- 查看函数手册
    vim.keymap.set({ 'n', 'v' }, '<space>c', vim.lsp.buf.code_action, opts)    -- 修改建议
end



-- --------------------------------------------
-- start lsp server --启动语言服务器
-- --------------------------------------------
local lsp_flags = {
  debounce_text_changes = 100,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())-- Setup lspconfig.


local servers = {"pyright", "clangd", "bashls", "lua_ls"}


for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
  }
end

local function on_language_status(_, result)
  -- Ignore nil messages.
  if result.message == nil then
      return
  end
  local command = vim.api.nvim_command
  command 'echohl ModeMsg'
  command(string.format('echo "%s"', result.message))
  command 'echohl None'
end


lspconfig.jdtls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    handlers = {
        ["$/progress"] = vim.schedule_wrap(on_language_status),
    },
})




-- --------------------------------------------------------
-- Configure lsp information display style
-- --------------------------------------------------------
local M = {}

M.setup = function()
    -- replace the lsp info symbol
    local signs = {
        { name = "DiagnosticSignError", text = "┃" },
        { name = "DiagnosticSignWarn",  text = "┃" },
        { name = "DiagnosticSignHint",  text = "┃" },
        { name = "DiagnosticSignInfo",  text = "┃" },
    }
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
    -- set the style of lsp info
    local config = {
        -- disable virtual text
        -- the message show after the current line.
        virtual_text = false,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)
    -- set the popup window border
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

return M



