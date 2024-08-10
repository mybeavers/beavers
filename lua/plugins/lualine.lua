local lualine = require('lualine')

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

-- Config 
local config = {
    options = {
        component_separators = '',
        section_separators = '',
        theme  = "auto",
     },

    sections = {
        lualine_a = {
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },

    inactive_sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },

    winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
    }
}


local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end



local mode_color = {
            n = CoreUIColorGroup.blue,
            i = CoreUIColorGroup.violet,
            v = CoreUIColorGroup.green,
            c = CoreUIColorGroup.red,
}


ins_left {
    function()
        return  '▊'
    end,
--    color = { fg = CoreUIColorGroup.blue, gui = 'bold' },
    color = function()
        -- 颜色变化
        return { fg = mode_color[vim.fn.mode()]}
    end,

    padding = { right = 1 },

}

-- 图标蓝色代表插入,红色代表命令,选择模式是绿
ins_left {
    function()
        return ' '
    end,
    color = function()
        -- 颜色变化
        return { fg = mode_color[vim.fn.mode()]}
    end,
    padding = { right = 1 },
}

-- 显示time
ins_left {
    function ()
        local gettime = os.date("%H:%M");
        return gettime
    end,
    color = function()
        -- auto change color according to neovims mode
        return { fg = mode_color[vim.fn.mode()] }
    end,
    cond = conditions.hide_in_width,
}

ins_left{
    '%l:%c %P',
    color = {fg = '#7f828e'}
}

-- 显示代码错误信息
ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ', hint=' ' },
    }






-- 显示添加/修改/删除
ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified =" ", removed = ' ' },
    diff_color = {
        added = { fg = CoreUIColorGroup.green },
        modified = { fg = CoreUIColorGroup.orange },
        removed = { fg = CoreUIColorGroup.red },
    },
    cond = conditions.hide_in_width,
}


-- git分支
ins_right {
    'branch',
    icon = '',
    cond = conditions.hide_in_width,
    color = { fg = CoreUIColorGroup.violet, gui = 'bold' },
}



-- 显示编码
ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = CoreUIColorGroup.yellow, gui = 'bold' },
}

ins_right {
    function()
        return '▊'
    end,
--    color = { fg = CoreUIColorGroup.blue, gui = 'bold' },
    color = function()
        -- 颜色变化
        return { fg = mode_color[vim.fn.mode()]}
    end,

    padding = { left = 1 },
}

lualine.setup(config)
