----------------------------------------
--          ColorGroups
----------------------------------------
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
}



-----------------------------------------
--          statusline 底栏
-----------------------------------------
vim.api.nvim_set_hl(0, 'User1', {fg=colors.black, bg=colors.blue})
vim.api.nvim_set_hl(0, 'User2', {fg=colors.DarkGrayishBlue})
vim.api.nvim_set_hl(0, 'User3', {fg=colors.black, bg=colors.green})
vim.api.nvim_set_hl(0, 'User8', {fg=colors.black, bg=colors.violet})
vim.api.nvim_set_hl(0, 'User0', {fg=colors.black, bg=colors.red})

vim.api.nvim_set_hl(0, 'User4', {fg=colors.SoftBlue})
vim.api.nvim_set_hl(0, 'User5', {fg=colors.green})
vim.api.nvim_set_hl(0, 'User7', {fg=colors.violet})
vim.api.nvim_set_hl(0, 'User9', {fg=colors.red})

 vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%t  "
----------------------------------------
--  根据模式变换颜色 > 多功能版statusline
-----------------------------------------
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
--vim.api.nvim_create_autocmd('ModeChanged', {
--    pattern = '*',
--    callback = function ()
--        if vim.g.my_new_mode == 'n' then --命令模式
--            vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%4*%1*%t%4*  "
--            --vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%4*%t  "
--        end
--        if vim.g.my_new_mode == 'i' then --插入模式
--            vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%7*%8*%t%7*  "
--            --vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%7*%t  "
--        end
--        if vim.g.my_new_mode == 'v' then --选中模式
--            vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%5*%3*%t%5*  "
--            --vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%5*%t  "
--        end
--        
--        
--        if vim.g.my_new_mode == 'c' then --底栏命令
--            --vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%9*%0*%t%9*  "
--            
--            
--            
--            vim.o.statusline = "%2*%=%-7.(%l,%c%V%)%9*%t  "
--        end
--    end,
--    nested=true,
--})



----------------------------------------
--          MyOneDark Theme
----------------------------------------
vim.cmd('highlight clear') -- clear all highlight

vim.cmd([[
    if exists('syntax on') 
        syntax reset
]])

vim.o.background='dark'
vim.cmd('let g:colors_name="MyOneDark"')

vim.api.nvim_set_hl(0, 'VertSplit', {fg=colors.magenta, bg=colors.magenta})

vim.cmd('color habamax')

----------------------------------------
--         My java highlight group
----------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = 'java',
    callback = function ()
        vim.api.nvim_set_hl(0, 'javaType', {fg = colors.magenta})                             -- 数据类型
        vim.api.nvim_set_hl(0, 'javaClassDecl', {link='javaType'})                            -- 实现
        vim.api.nvim_set_hl(0, '@lsp.type.modifier.java', {link='javaType'})                  -- 关键字
        vim.api.nvim_set_hl(0, '@lsp.type.property.java', {fg = colors.SoftRed})              -- 变量
        vim.api.nvim_set_hl(0, '@lsp.type.class.java', {fg = colors.SoftOrange})              -- 类
        vim.api.nvim_set_hl(0, '@lsp.type.method.java', {fg = colors.SoftBlue})               -- 方法
        vim.api.nvim_set_hl(0, '@lsp.type.annotationMember.java', {fg = colors.SoftBlue})     -- 注解方法
        vim.api.nvim_set_hl(0, '@lsp.type.enumMember.java', {fg = colors.ModerateOrange})     -- 枚举常量
    end,
    nested = true,

})



----------------------------------------
--          Cmp高亮显示组
----------------------------------------
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function ()
        -- gray
        vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg= '#808080' })
        -- blue
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg= '#569CD6' })
        vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
        -- light blue
        vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg=colors.VerySoftBlue})
        vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
        vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
        -- pink
        vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg=colors.SlightlyDesaturatedMagenta})
        vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
        -- front
        vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg=colors.LightGray})
        vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
        vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })

        -- 选中栏
        vim.api.nvim_set_hl(0, 'MyCmpSel', {bg=colors.SoftBlue, fg=colors.black})
    end,
    nested = true,
})

