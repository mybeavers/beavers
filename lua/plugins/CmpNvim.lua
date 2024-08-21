local kind_icons = {
    Namespace = "󰌗 ,Namespace",
    Text = "󰉿 ,Text",
    Method = "󰆧 ,Method",
    Function = "󰆧 ,Function",
    Constructor = " ,Constructor",
    Field = "󰜢 ,Field",
    Variable = "󰀫 ,Variable",
    Class = "󰠱 ,Class",
    Interface = " ,Interface",
    Module = " ,Method",
    Property = "󰜢 ,Property",
    Unit = "󰑭 ,Unit",
    Value = "󰎠 ,Value",
    Enum = " ,Enum",
    Keyword = "󰌋 ,Keyword",
    Snippet = " ,Snippet",
    Color = "󰏘 ,Color",
    File = "󰈚 ,File",
    Reference = "󰈇 ,Reference",
    Folder = "󰉋 ,Folder",
    EnumMember = " ,EnumMember",
    Constant = "󰏿 ,Constant",
    Struct = "󰙅 ,Struct",
    Event = " ,Event",
    Operator = "󰆕 ,Operator",
    TypeParameter = "󰊄 ,TypeParameter",
    Table = " ,Table",
    Object = "󰅩 ,Object",
    Tag = " ,Tag",
    Array = "[] ,Array",
    Boolean = " ,Boolean",
    Number = " ,Number",
    Null = "󰟢 ,Null",
    Supermaven = " ,Supermaven",
    String = "󰉿 ,String",
    Calendar = " ,Calendar",
    Watch = "󰥔 ,Watch",
    Package = " ,Package",
    Copilot = " ,Copilot",
    Codeium = " ,Codeium",
    TabNine = " ,TabNine",
}


local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup {
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    -- 映射
    mapping = cmp.mapping.preset.insert({
        -- ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { 'i' }),
        ["$"] = cmp.mapping(function(fallback)
            -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    cmp.confirm()
                end
            else
                fallback()
            end
        end, { "i", "s", "c", }),
        ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if luasnip.expandable() then
                    luasnip.expand()
                else
                    cmp.confirm({
                        select = true,
                    })
                end
            else
                fallback()
            end
        end),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    -- 窗口
    window = {
        documentation = cmp.config.window.bordered({
            winhighlight = "Normal:MyCmpNormal" --",FloatBorder:MyCmpFloatBorder",
        }),
        completion = cmp.config.window.bordered({
            winhighlight = "Normal:MyCmpNormal,CursorLine:MyCmpSel" --",FloatBorder:MyCmpFloatBorder",
        }),
    },

    formatting = {
        -- 显示顺序: 图标 补全字符 类
        fields = { "kind", "abbr", "menu" },
        --        fields = { 'abbr', 'kind'},
        format = function(entry, vim_item)
            local strings = vim.split(string.format("%s ", kind_icons[vim_item.kind]), ",")
            vim_item.kind = strings[1]
            vim_item.menu = strings[2]
            --           vim_item.kind = string.format("%s ", kind_icons[vim_item.kind])
            return vim_item
        end,
    },

    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },


        {
            { name = 'buffer' },
            { name = 'path' },
        })
}
