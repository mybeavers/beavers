-------------------------------------
--  NOTE  My color group
---------------------------------------

CoreUIColorGroup = {
    black = '#000000', -- 黑色
    withe = '#ffffff', -- 白色


    red    = '#e06c75', -- 红色
    orange = '#FF8800', -- 橙色
    yellow = '#ECBE7B', -- 黄色
    green  = '#98be65', -- 绿色
    cyan   = '#008080', -- 青色
    blue   = '#51afef', -- 蓝色
    purple = '#800080', -- 紫色


    DarkRed    = '#8b0000', -- 暗红色
    DarkOrange = '#ff8c00', -- 暗橙色
    DarkYellow = '#ffff00', -- 暗黄色
    DarkGreen  = '#013220', -- 暗绿色
    DarkCyan   = '#008b8b', -- 暗青色
    DarkBlue   = '#00008b', -- 暗蓝色
    DarkPurple = '#800080', -- 暗紫色


    LightRed    = '#ff0000', -- 亮红色
    LightOrange = '#ffa500', -- 亮橙色
    LightYellow = '#ffffed', -- 亮黄色
    LightGreen  = '#00ff00', -- 亮绿色
    LightCyan   = '#00ffff', -- 亮青色
    LightBlue   = '#0000ff', -- 亮蓝色
    LightPurple = '#800080', -- 亮紫色


    SoftRed                    = '#E06C75', -- 柔和的红色
    magenta                    = '#c678dd', -- 紫红色
    SlightlyDesaturatedMagenta = '#C586C0', -- 略微不饱和的紫红色
    SoftOrange                 = '#f3cdb7', -- 柔和的橙色
    ModerateOrange             = '#D19A66', -- 适度的橙色
    SoftGreen                  = '#A1E1A9', -- 柔和的绿色
    SoftBlue                   = '#61AFEF', -- 柔和的蓝色
    VerySoftBlue               = '#9CDCFE', -- 非常柔和的蓝色
    LightGray                  = '#D4D4D4', -- 浅灰色
    DarkGrayishBlue            = '#7f828e', -- 深灰蓝色
    DarkGrayish                = '#7f828e', -- 暗灰色
    ModerateCyan               = '#56b6c2', -- 适度的青色
    violet                     = '#a9a1e1', -- 紫罗兰色
    SoftViolet                 = '#b490ca', -- 柔和的紫色
}


-- icons:
--"＞◡❛", " " ," ", " ", " ", " ", " ", " ", " ", '' "",""," ,"ﰊ","", "", "", "", ""
-----------------------------------------
-- NOTE     statusline 底栏
----------------------------------------
vim.o.statusline = MyStatusLine()

----------------------------------------
-- NOTE 字符高亮
----------------------------------------
autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = '*',
    callback = function()
        cmd('highlight clear DiagnosticUnderlineInfo') -- 清除TODO高亮设置
        cmd('1match MyNOTE / NOTE /')
        cmd('2match MyTODO / TODO /')

        highlight(0, 'MyTODO', { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.blue })
        highlight(0, 'MyFIX', { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.yellow })
        highlight(0, 'MyNOTE', { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.green })
    end,
    nested = true
})


----------------------------------------
-- NOTE  Search
----------------------------------------
autocmd({ "InsertEnter" }, {
    pattern = '*',
    callback = function()
        cmd("let @/ = ''")
    end,
})

autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = "*",
    callback = function()
        highlight(0, 'CurSearch', { bg = CoreUIColorGroup.SoftRed, fg = CoreUIColorGroup.black })
        highlight(0, 'IncSearch', { bg = CoreUIColorGroup.SoftRed, fg = CoreUIColorGroup.black })
        highlight(0, 'Search', { bg = CoreUIColorGroup.yellow, fg = CoreUIColorGroup.black })
    end,
    nested = true
})


----------------------------------------
-- NOTE  Cmp highlight group dddfd
----------------------------------------
autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = "*",
    callback = function()
        -- gray
        highlight(0, 'CmpItemAbbrDeprecated', { bg = 'NONE', strikethrough = true, fg = '#808080' })
        -- blue
        highlight(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
        highlight(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
        -- light blue
        highlight(0, 'CmpItemKindVariable', { bg = 'NONE', fg = CoreUIColorGroup.VerySoftBlue })
        highlight(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
        highlight(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
        -- pink
        highlight(0, 'CmpItemKindFunction', { bg = 'NONE', fg = CoreUIColorGroup.SlightlyDesaturatedMagenta })
        highlight(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
        -- front
        highlight(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = CoreUIColorGroup.LightGray })
        highlight(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
        highlight(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })

        -- cmp bg
        highlight(0, 'MyCmpSel', { bg = CoreUIColorGroup.SoftBlue, fg = CoreUIColorGroup.black })
        highlight(0, 'MyCmpFloatBorder', { fg = CoreUIColorGroup.DarkGrayishBlue })
        
        highlight(0, 'MyCmpFloatBorder', { fg = CoreUIColorGroup.DarkGrayishBlue })

    end,
    nested = true,
})


--------------------------------------
-- NOTE  GitSigns highlight group
--------------------------------------
autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = '*',
    callback = function()
        highlight(0, 'GitSignsAdd', { fg = CoreUIColorGroup.SoftGreen })
        highlight(0, 'GitSignsDelete', { fg = CoreUIColorGroup.SoftRed })
        highlight(0, 'GitSignsChange', { fg = CoreUIColorGroup.SoftOrange })
    end,
    nested = true,

})

--------------------------------------
-- NOTE Telescope highlight group
--------------------------------------
autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = "*",
    callback = function()
        highlight(0, 'TelescopePromptTitle', { bg = CoreUIColorGroup.SoftOrange, fg = CoreUIColorGroup.black }) --左下title
        highlight(0, 'TelescopePreviewTitle', { bg = CoreUIColorGroup.SoftGreen, fg = CoreUIColorGroup.black }) --右上title
        highlight(0, 'TelescopeBorder', { link = "NormalNC" })                                                  --右上title
        highlight(0, 'TelescopeNormal', { link = "NormalNC" })                                                  --右上titl
    end,
    nested = true
})



-- --------------------------------------
--  NOTE  JAVA highlight group
-- --------------------------------------

autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = 'java',
    callback = function()
        highlight(0, 'javaType', { fg = CoreUIColorGroup.magenta })                         -- 数据类型
        highlight(0, '@lsp.type.modifier.java', { link = 'javaType' })                      -- 关键字
        highlight(0, '@lsp.type.method.java', { fg = CoreUIColorGroup.SoftBlue })           -- 方法/函数
        highlight(0, '@lsp.type.property.java', { fg = CoreUIColorGroup.SoftRed })          --变量
        highlight(0, '@lsp.type.parameter.java', { fg = CoreUIColorGroup.SoftRed })         -- 变量
        highlight(0, '@lsp.type.class.java', { fg = CoreUIColorGroup.SoftOrange })          -- 类
        highlight(0, 'javaClassDecl', { link = 'javaType' })                                -- 实现
        highlight(0, '@lsp.type.annotationMember.java', { fg = CoreUIColorGroup.SoftBlue }) -- 注解方法
        highlight(0, '@lsp.type.enumMember.java', { fg = CoreUIColorGroup.ModerateOrange }) -- 枚举常量
    end,
    nested = true,
})


-- --------------------------------------
--=  NOTE  C highlight group
-- --------------------------------------

autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = 'c',
    callback = function()
        highlight(0, 'cIncluded', { fg = CoreUIColorGroup.SoftOrange })         -- 头文件
        highlight(0, '@function.builtin', { fg = CoreUIColorGroup.SoftBlue })   -- 库函数

        highlight(0, 'cType', { fg = CoreUIColorGroup.magenta })                -- 数据类型
        highlight(0, '@lsp.type.variable.c', { fg = CoreUIColorGroup.SoftRed }) -- 变量
        highlight(0, 'cStatement', { fg = CoreUIColorGroup.magenta })           -- 关键字
        highlight(0, '@lsp.type.function.c', { link = '@function.builtin' })    -- 函数
    end,
    nested = true,
})




-- --------------------------------------
--  NOTE  PYTHON highlight group
-- --------------------------------------
autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = 'python',
    callback = function()
        highlight(0, 'pythonAttribute', { fg = CoreUIColorGroup.SoftBlue })
    end,
    nested = true,

})
