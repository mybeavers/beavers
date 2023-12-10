local api = vim.api
local cmd = vim.cmd
local highlight = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-------------------------------------
--  NOTE  My color group
---------------------------------------

CoreUIColorGroup = {
    black                       = '#000000',    -- 黑色
    withe                       = '#ffffff',    -- 白色


    red                         = '#e06c75',    -- 红色
    orange                      = '#FF8800',    -- 橙色
    yellow                      = '#ECBE7B',    -- 黄色
    green                       = '#98be65',    -- 绿色
    cyan                        = '#008080',    -- 青色
    blue                        = '#51afef',    -- 蓝色
    purple                      = '#800080',    -- 紫色


    DarkRed                     = '#8b0000',    -- 暗红色
    DarkOrange                  = '#ff8c00',    -- 暗橙色
    DarkYellow                  = '#ffff00',    -- 暗黄色
    DarkGreen                   = '#013220',    -- 暗绿色
    DarkCyan                    = '#008b8b',    -- 暗青色
    DarkBlue                    = '#00008b',    -- 暗蓝色
    DarkPurple                  = '#800080',    -- 暗紫色


    LightRed                     = '#ff0000',    -- 亮红色
    LightOrange                  = '#ffa500',    -- 亮橙色
    LightYellow                  = '#ffffed',    -- 亮黄色
    LightGreen                   = '#00ff00',    -- 亮绿色
    LightCyan                    = '#00ffff',    -- 亮青色
    LightBlue                    = '#0000ff',    -- 亮蓝色
    LightPurple                  = '#800080',    -- 亮紫色


    SoftRed                     = '#E06C75',    -- 柔和的红色
    magenta                     = '#c678dd',    -- 紫红色
    SlightlyDesaturatedMagenta  = '#C586C0',    -- 略微不饱和的紫红色
    SoftOrange                  = '#E5C07B',    -- 柔和的橙色
    ModerateOrange              = '#D19A66',    -- 适度的橙色
    SoftGreen                   = '#A1E1A9',    -- 柔和的绿色
    SoftBlue                    = '#61AFEF',    -- 柔和的蓝色
    VerySoftBlue                = '#9CDCFE',    -- 非常柔和的蓝色
    LightGray                   = '#D4D4D4',    -- 浅灰色
    DarkGrayishBlue             = '#7f828e',    -- 深灰蓝色
    DarkGrayishBlue2            = '#abb2bf',    -- 深灰蓝色2
    ModerateCyan                = '#56b6c2',    -- 适度的青色
    violet                      = '#a9a1e1',    -- 紫罗兰色
    SoftViolet                  = '#b490ca',    -- 柔和的紫色
}


-----------------------------------------
--  NOTE     statusline 底栏
-----------------------------------------
api.nvim_set_hl(0, 'User1', {fg=CoreUIColorGroup.SoftRed})
api.nvim_set_hl(0, 'User2', {fg=CoreUIColorGroup.green})
api.nvim_set_hl(0, 'User3', {fg=CoreUIColorGroup.violet})
api.nvim_set_hl(0, 'User4', {fg= CoreUIColorGroup.SoftBlue})

api.nvim_set_hl(0, 'User5', {fg=CoreUIColorGroup.black, bg=CoreUIColorGroup.blue})
api.nvim_set_hl(0, 'User6', {fg=CoreUIColorGroup.black, bg=CoreUIColorGroup.green})
api.nvim_set_hl(0, 'User7', {fg=CoreUIColorGroup.black, bg=CoreUIColorGroup.violet})
api.nvim_set_hl(0, 'User8', {fg=CoreUIColorGroup.black, bg=CoreUIColorGroup.SoftRed})


api.nvim_set_hl(0, 'User9', {fg=CoreUIColorGroup.DarkGrayishBlue})

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
        cmd('highlight clear DiagnosticUnderlineInfo') -- 清除java中的TODO高亮设置
        cmd('2match MyFIX / FIX /')
        cmd('1match MyNOTE / NOTE /')
        highlight(0,'TODO', {fg = CoreUIColorGroup.black, bg=CoreUIColorGroup.SoftBlue})
        highlight(0, 'MyFIX', {fg=CoreUIColorGroup.black, bg=CoreUIColorGroup.yellow})
        highlight(0, 'MyNOTE', {fg=CoreUIColorGroup.black, bg=CoreUIColorGroup.green})
    end,
    nested=true
})

-- --------------------------------------
--  NOTE  My java highlight group
-- --------------------------------------

autocmd({"FileType", "ColorScheme"}, {
    pattern = 'java',
    callback = function ()
        highlight(0, 'javaType', {fg = CoreUIColorGroup.magenta})                           -- 数据类型
        highlight(0, '@lsp.type.modifier.java', {link='javaType'})                          -- 关键字
        highlight(0, '@lsp.type.method.java', {fg = CoreUIColorGroup.SoftBlue})             -- 方法/函数
        highlight(0, '@lsp.type.property.java', {fg = CoreUIColorGroup.SoftRed})            -- 变量
        highlight(0, '@lsp.type.class.java', {fg = CoreUIColorGroup.SoftOrange})            -- 类
        highlight(0, 'javaClassDecl', {link='javaType'})                                    -- 实现
        highlight(0, '@lsp.type.annotationMember.java', {fg = CoreUIColorGroup.SoftBlue})   -- 注解方法
        highlight(0, '@lsp.type.enumMember.java', {fg = CoreUIColorGroup.ModerateOrange})   -- 枚举常量
    end,
    nested = true,
})



-- --------------------------------------
--  NOTE  My C highlight group
-- --------------------------------------

autocmd({"FileType", "ColorScheme"}, {
    pattern = 'c',
    callback = function ()
        highlight(0, 'cIncluded', {fg = CoreUIColorGroup.SoftOrange})                       -- 头文件
        highlight(0, '@function.builtin', {fg=CoreUIColorGroup.SoftBlue})                   -- 库函数

        highlight(0, 'cType', {fg = CoreUIColorGroup.magenta})                              -- 数据类型
        highlight(0, '@lsp.type.variable.c', {fg=CoreUIColorGroup.SoftRed})                 -- 变量
        highlight(0, 'cStatement', {fg=CoreUIColorGroup.magenta})                            -- 关键字
        highlight(0, '@lsp.type.function.c', {link='@function.builtin'})                    -- 函数
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
        highlight(0, 'CmpItemKindVariable', { bg='NONE', fg=CoreUIColorGroup.VerySoftBlue})
        highlight(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
        highlight(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
        -- pink
        highlight(0, 'CmpItemKindFunction', { bg='NONE', fg=CoreUIColorGroup.SlightlyDesaturatedMagenta})
        highlight(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
        -- front
        highlight(0, 'CmpItemKindKeyword', { bg='NONE', fg=CoreUIColorGroup.LightGray})
        highlight(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
        highlight(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

        -- cmp bg
        highlight(0, 'MyCmpSel', {bg=CoreUIColorGroup.SoftBlue, fg=CoreUIColorGroup.black})
    end,
    nested = true,
})




--------------------------------------
 -- NOTE Telescope highlight group
--------------------------------------
autocmd({"BufEnter", "ColorScheme"}, {
     pattern = "*",
     callback = function ()
        highlight(0, 'TelescopePromptTitle', {bg=CoreUIColorGroup.SoftViolet, fg=CoreUIColorGroup.black}) --左下title
        highlight(0, 'TelescopePreviewTitle', {bg=CoreUIColorGroup.SoftGreen, fg=CoreUIColorGroup.black}) --右上title 
     end,
    nested= true
})


