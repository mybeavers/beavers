-- -------------------------------------------
-- lsp keymap lspconifg
-- -------------------------------------------
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, MyKeymapOpt) -- 查看代码诊断信息
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, MyKeymapOpt) -- 查看所有错误
MyKeymap('n', '<space>y', ':lua PrintDiagnostics()<CR>', MyKeymapOpt) -- 复制诊断信息到寄存器



local lspconfig = require("lspconfig")
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }                                        --  NOTE  说明
        vim.keymap.set('n', '<space>g', vim.lsp.buf.definition, opts)           -- go to 方法/变量...定义
        vim.keymap.set('n', '<space>r', vim.lsp.buf.rename, opts)               -- 重命名
        vim.keymap.set({ 'n', 'v' }, '<space>c', vim.lsp.buf.code_action, opts) -- 代码修改建议
        vim.keymap.set('n', '<space>f', function()                              -- 代码格式化
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', '<space>d', vim.lsp.buf.declaration, opts)              -- 查看: method textDocument/declaration
        vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, opts)                    -- 查看: 代码的Tip悬浮展示
        vim.keymap.set('n', '<space>i', vim.lsp.buf.implementation, opts)           -- 查看: 当前代码(主要是函数方法/变量)的实现定位
        vim.keymap.set('n', '<space>h', vim.lsp.buf.signature_help, opts)           -- 查看: 签名帮助
        vim.keymap.set('n', '<space>a', vim.lsp.buf.type_definition, opts)          -- 查看: 类型定义
        vim.keymap.set('n', '<space>s', vim.lsp.buf.references, opts)               -- 查看: 当前代码符号的引用查询

        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)    -- 添加工作区折叠
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts) -- 删除工作区折叠
        vim.keymap.set('n', '<space>wl', function()                                 -- 查看工作区折叠
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
    end,
})



-- --------------------------------------------
-- start lsp server
-- --------------------------------------------
local lsp_flags = {
    debounce_text_changes = 100,
}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) -- Setup lspconfig.


local servers = { "pyright", "clangd", "bashls", "lua_ls" ,"vtsls"}


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
    --on_attach = on_attach,
    capabilities = capabilities,
    flags = lsp_flags,
    handlers = {
        ["$/progress"] = vim.schedule_wrap(on_language_status),
    },
})







-- --------------------------------------------------------
-- LSP UI
-- --------------------------------------------------------
-- 更改显示的诊断符号
local signs = { Error = "┃", Warn = "┃", Hint = "┃", Info = "┃" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- 自定义诊断的显示方式
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
})

-- 诊断配置
vim.diagnostic.config({
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

})

-- set the popup window border
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
})



-- 打印诊断信息到消息区域
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    opts = opts or { ['lnum'] = line_nr }

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    if vim.tbl_isempty(line_diagnostics) then return end

    local Mydiagnostic_message = ""
    for i, diagnostic in ipairs(line_diagnostics) do
        Mydiagnostic_message = Mydiagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
        --print(Mydiagnostic_message) -- 输出
        if i ~= #line_diagnostics then
            Mydiagnostic_message = Mydiagnostic_message .. "\n"
        end
    end

    vim.fn.setreg('@"', Mydiagnostic_message) --复制到寄存器
    if vim.fn.has('wsl') then --复制到Windows粘贴板
        vim.cmd([[
        call system('/mnt/c/windows/system32/clip.exe ',@")
    ]])
    end
end
