--require("nvim-lsp-installer").setup{}

require("mason").setup{}
local opts = { noremap=true, silent=true }
-- 查看代码诊断信息
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
-- 跳转到上一个错误
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
-- 跳转到下一个错误
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- 查看所有错误
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local lspconfig = require("lspconfig")
local function on_attach(client, bufnr) -- set up buffer keymaps, etc.
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
    -- 查看函数声明
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    -- 查看函数实现
    vim.keymap.set('n', '<space>g', vim.lsp.buf.definition, bufopts)
    --重命名函数
    vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, bufopts)
    -- 查看函数手册
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    -- 修改建议
    vim.keymap.set({ 'n', 'v' }, '<space>t', vim.lsp.buf.code_action, opts)
end

-- 
local lsp_flags = {
  debounce_text_changes = 100,
}

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())


-- after local capabilities = ....
-- start server --启动语言服务器
local servers = {"pyright", "clangd", "bashls", "lua_ls"}

-- 遍历
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

require("lsp.lspconfig").setup()
