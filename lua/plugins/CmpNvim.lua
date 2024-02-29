local kind_icons = {
    Text = " Text",
    Method = " Method",
    Function = " Function",
    Constructor = " Constructor",
    Field = " Field",
    Variable = " Variable",
    Class = " Class",
    Interface = " Interface",
    Module = "  Module",
    Property = " Property",
    Unit = " Unit",
    Value = " Value",
    Enum = " Enum",
    Keyword = " Keyword",
    Snippet = " Snippet",
    Color = " Color",
    File = " Fi",
    Reference = " Reference",
    Folder = " Folder",
    EnumMember = "  EnumMember",
    Constant = " Constant",
    Struct = "  Struct",
    Event = " Event",
    Operator = " Operator",
    TypeParameter = " TypeParameter",
    Tag = "",
    Array = "[]",
    Boolean = "",
    Number = "",

}



local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local cmp = require('cmp')

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end,
    },
    -- 映射
    mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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

----显示顺序: 图标 补全字符 类
    formatting = {
        fields = {"kind", "abbr", "menu" },

        format = function(entry, vim_item)
            local strings = vim.split(string.format("%s ", kind_icons[vim_item.kind]), " ")
            vim_item.kind = strings[1]
            vim_item.menu = strings[2]
            return vim_item
        end,
    },

    sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'ultisnips' },
        },
        {
            { name = 'buffer' },
            { name = 'path' },
        })
}

-- autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
