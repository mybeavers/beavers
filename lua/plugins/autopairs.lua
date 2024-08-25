require("nvim-autopairs").setup ({
    enable_check_bracket_line = false
})

---- --------------------------
-- CMP 函数自动添加括号
-- --------------------------   
local handlers = require('nvim-autopairs.completion.handlers')
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- -------------------------- 
-- 在括号之间添加空格
-- --------------------------
local npairs = require'nvim-autopairs'

-- ---------------- 
-- 快速包装
-- ----------------
npairs.setup({
    fast_wrap = {},
})

-- change default fast_wrap
npairs.setup({
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = [=[[%'%"%>%]%)%}%,]]=],
      end_key = '$',
      before_key = 'h',
      after_key = 'l',
      cursor_pos_before = true,
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      manual_position = true,
      highlight = 'Search',
      highlight_grey='Comment'
    },
})
