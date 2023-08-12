require("symbols-outline").setup({

    --是否突出显示当前悬停的符号
    highlight_hovered_item = true,
    -- 是否显示大纲参考线
    show_guides = false,

    auto_preview = false,
    -- 打开的位置:right or left
    position = 'left',
    --是否相对现有的窗口设置宽度
    relative_width = true,
    -- 宽度
    width = 25,
    --选择后是否自动关闭窗口
    auto_close = true,
    -- 显示带有轮廓的数字
    show_numbers = false,
    -- 显示带有轮廓的相对数字
    show_relative_numbers = false,
    -- 使用符号显示额外的详细信息
    show_symbol_details = true,
    -- 预览窗口的背景色
    preview_bg_highlight = 'Pmenu',
    autofold_depth = nil,
    auto_unfold_hover = true,
    -- 层级符号
    fold_markers = { '', '' },
    wrap = false,
    -- 键盘映射
    keymaps = { -- These keymaps can be a string or a table for multiple keys
        close = {"<Esc>", "q"},
        goto_location = "<Cr>",
        focus_location = "o",
        hover_symbol = "<C-space>",
        toggle_preview = "K",
        rename_symbol = "r",
        code_actions = "a",
        fold = "h",
        unfold = "l",
        fold_all = "W",
        unfold_all = "E",
        fold_reset = "R",
    },
    -- 需要忽略的符号
    lsp_blacklist = {
           },
    symbol_blacklist = {},
    symbols = {
        File = { icon = "", hl = "@text.uri" },
        Module = { icon = "", hl = "@namespace" },
        Namespace = { icon = "", hl = "@namespace" },
        Package = { icon = "", hl = "@namespace" },
        Class = { icon = "", hl = "@type" },
        Method = { icon = "", hl = "@method" },
        Property = { icon = "", hl = "@method" },
        Field = { icon = "", hl = "@field" },
        Constructor = { icon = "", hl = "@constructor" },
        Enum = { icon = "ℰ", hl = "@type" },
        Interface = { icon = "ﰮ", hl = "@type" },
        Function = { icon = "", hl = "@function" },
        Variable = { icon = "", hl = "@constant" },
        Constant = { icon = "", hl = "@constant" },
        String = { icon = "𝓐", hl = "@string" },
        Number = { icon = "#", hl = "@number" },
        Boolean = { icon = "⊨", hl = "@boolean" },
        Array = { icon = "", hl = "@constant" },
        Object = { icon = "⦿", hl = "@type" },
        Key = { icon = "k", hl = "@type" },
        Null = { icon = "NULL", hl = "@type" },
        EnumMember = { icon = "", hl = "@field" },
        Struct = { icon = "𝓢", hl = "@type" },
        Event = { icon = "", hl = "@type" },
        Operator = { icon = "", hl = "@operator" },
        TypeParameter = { icon = "", hl = "@parameter" },
        Component = { icon = "", hl = "@function" },
        Fragment = { icon = "", hl = "@constant" },
    },
})


