local api = vim.api
local highlight = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd
-------------------------------------
--  NOTE  ColorGroups
---------------------------------------

local colors = {
    red                         = '#e06c75',    -- 红色
    blue                        = '#51afef',    -- 蓝色
    green                       = '#98be65',    -- 绿色
    yellow                      = '#ECBE7B',    -- 黄色
    cyan                        = '#008080',    -- 青色
    orange                      = '#FF8800',    -- 橙色
    black                       = '#000000',    -- 黑色
    withe                       = '#ffffff',    -- 白色
    violet                      = '#a9a1e1',    -- 紫罗兰色
    SoftRed                     = '#E06C75',    -- 柔和的红色
    magenta                     = '#c678dd',    -- 柔和的品红色
    SlightlyDesaturatedMagenta  = '#C586C0',    -- 略微不饱和的洋红色
    SoftOrange                  = '#E5C07B',    -- 柔和的橙色
    ModerateOrange              = '#D19A66',    -- 适度的橙色
    SoftBlue                    = '#61AFEF',    -- 柔和的蓝色
    VerySoftBlue                = '#9CDCFE',    -- 非常柔和的蓝色
    LightGray                   = '#D4D4D4',    -- 浅灰色
    DarkGrayishBlue             = '#7f828e',    -- 深灰蓝色
    DarkGrayishBlue2            = '#abb2bf',
    ModerateCyan                = '#56b6c2',    -- 适度的青色
    SoftViolet                  = '#b490ca',    -- 柔和的紫色
    SoftGreen                   = '#A1E1A9',    -- 柔和的绿色
}

-----------------------------------------
--  NOTE     statusline 底栏
-----------------------------------------
vim.api.nvim_set_hl(0, 'User1', {fg=colors.SoftRed})
vim.api.nvim_set_hl(0, 'User2', {fg=colors.green})
vim.api.nvim_set_hl(0, 'User3', {fg=colors.violet})
vim.api.nvim_set_hl(0, 'User4', {fg= colors.SoftBlue})

vim.api.nvim_set_hl(0, 'User5', {fg=colors.black, bg=colors.blue})
vim.api.nvim_set_hl(0, 'User6', {fg=colors.black, bg=colors.green})
vim.api.nvim_set_hl(0, 'User7', {fg=colors.black, bg=colors.violet})
vim.api.nvim_set_hl(0, 'User8', {fg=colors.black, bg=colors.SoftRed})


vim.api.nvim_set_hl(0, 'User9', {fg=colors.DarkGrayishBlue})

vim.o.statusline = '%9*%=%-7.(%l,%c%V%)%t  '
--------------------------------------
-- NOTE 根据模式变换颜色 > 多功能版statusline
---------------------------------------

--vim.cmd([[ 
--function! StoreNewMode(event) abort
--  let g:my_new_mode = a:event.new_mode
--endfunction
--
--autocmd ModeChanged * call StoreNewMode(v:event)
--]])
--
--
--
---- 根据当前模式改变statusline 
--autocmd('ModeChanged', {
--    pattern = '*',
--    callback = function ()
--        if vim.g.my_new_mode == 'n' then --命令模式
--            vim.o.statusline = "%9*%=%-7.(%l,%c%V%)%4*%5*%t%4* "
--        end
--        if vim.g.my_new_mode == 'i' then --插入模式
--            vim.o.statusline = "%9*%=%-7.(%l,%c%V%)%3*%7*%t%3* "
--        end
--        if vim.g.my_new_mode == 'v' then --选中模式
--            vim.o.statusline = "%9*%=%-7.(%l,%c%V%)%2*%6*%t%2* "
--        end
--        if vim.g.my_new_mode == 'c' then --底栏命令
--            vim.o.statusline = "%9*%=%-7.(%l,%c%V%)%1*%8*%t%1* "
--        end
--    end,
--    nested=true,
--  })

----------------------------------------
--          TODO 字符高亮
---------------------------------------- 
autocmd({"BufEnter","ColorScheme"}, {
    pattern = '*',
    callback=function ()
        vim.cmd('highlight clear DiagnosticUnderlineInfo') -- 清除java中的TODO高亮设置
        vim.cmd('2match MyFIX / FIX /')
        vim.cmd('1match MyNOTE / NOTE /')
        highlight(0,'TODO', {fg = colors.black, bg=colors.SoftBlue})
        highlight(0, 'MyFIX', {fg=colors.black, bg=colors.yellow})
        highlight(0, 'MyNOTE', {fg=colors.black, bg=colors.green})
    end,
    nested=true
})

----------------------------------------
--  NOTE  My java highlight group
----------------------------------------
autocmd({"FileType", "ColorScheme"}, {
    pattern = '*',
    callback = function ()
        highlight(0, 'javaType', {fg = colors.magenta})                             -- 数据类型
        highlight(0, 'javaClassDecl', {link='javaType'})                            -- 实现
        highlight(0, '@lsp.type.modifier.java', {link='javaType'})                  -- 关键字
        highlight(0, '@lsp.type.property.java', {fg = colors.SoftRed})              -- 变量
        highlight(0, '@lsp.type.class.java', {fg = colors.SoftOrange})              -- 类
        highlight(0, '@lsp.type.method.java', {fg = colors.SoftBlue})               -- 方法
        highlight(0, '@lsp.type.annotationMember.java', {fg = colors.SoftBlue})     -- 注解方法
        highlight(0, '@lsp.type.enumMember.java', {fg = colors.ModerateOrange})     -- 枚举常量
    end,
    nested = true,

})



----------------------------------------
--          Cmp highlight group
----------------------------------------
autocmd({"vimEnter", "ColorScheme"}, {
    pattern = "*",
    callback = function ()
        -- gray
        highlight(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg= '#808080' })
        -- blue
        highlight(0, 'CmpItemAbbrMatch', { bg='NONE', fg= '#569CD6' })
        highlight(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
        -- light blue
        highlight(0, 'CmpItemKindVariable', { bg='NONE', fg=colors.VerySoftBlue})
        highlight(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
        highlight(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
        -- pink
        highlight(0, 'CmpItemKindFunction', { bg='NONE', fg=colors.SlightlyDesaturatedMagenta})
        highlight(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
        -- front
        highlight(0, 'CmpItemKindKeyword', { bg='NONE', fg=colors.LightGray})
        highlight(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
        highlight(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

        -- cmp bg
        highlight(0, 'MyCmpSel', {bg=colors.SoftBlue, fg=colors.black})
    end,
    nested = true,
})




--------------------------------------
 -- NOTE Telescope highlight group
--------------------------------------
autocmd({"BufEnter", "ColorScheme"}, {
     pattern = "*",
     callback = function ()
        highlight(0, 'TelescopePromptTitle', {bg=colors.SoftViolet, fg=colors.black}) --左下title
        highlight(0, 'TelescopePreviewTitle', {bg=colors.SoftGreen, fg=colors.black}) --右上title 
     end,
    nested= true
})




