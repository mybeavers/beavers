local lualine = require('lualine')

local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#e06c75',
}

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
        --[[
        theme = {
        normal = { c = { fg = colors.fg, bg = colors.bg } },
        inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },]]
        theme = vim.g.colorscheme;


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




ins_left {
    function()
        return '▊'
    end,
    color = function()
        -- 棰滆壊鍙樺寲
        local mode_color = {
            n = colors.blue,
            i = colors.violet,
            v = colors.green,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.red,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 },

}


-- 图标蓝色代表插入,红色代表命令,选择模式是绿
ins_left {
    -- mode component
    function()
        --当前系统图标
        return '  ＞◡❛料峭'
    end,
    color = function()
        -- 颜色变化
        local mode_color = {
            n = colors.blue,
            i = colors.violet,
            v = colors.green,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.red,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
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
        local mode_color = {
            n = colors.blue,
            i = colors.violet,
            v = colors.green,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.red,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    cond = conditions.hide_in_width,
}
-- 显示光标所在 行:列
ins_left { 'location' }

-- 显示文本百分比
ins_left { 'progress'}



-- 显示代码错误信息
ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
}





-- 显示添加/修改/删除
ins_right {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified =" ", removed = ' ' },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red },
    },
    cond = conditions.hide_in_width,
}





-- git分支
ins_right {
    'branch',
    icon = '',
    cond = conditions.hide_in_width,
    color = { fg = colors.violet, gui = 'bold' },
}



-- 显示编码
ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper, -- I'm not sure why it's upper case either ;)
    cond = conditions.hide_in_width,
    color = { fg = colors.violet, gui = 'bold' },
}
ins_right {
    function()
        return '▊'
    end,
    color = function()
        -- auto change color according to neovims mode
        local mode_color = {
            n = colors.blue,
            i = colors.violet,
            v = colors.green,
            [''] = colors.blue,
            V = colors.blue,
            c = colors.red,
            no = colors.red,
            s = colors.orange,
            S = colors.orange,
            [''] = colors.orange,
            ic = colors.yellow,
            R = colors.violet,
            Rv = colors.violet,
            cv = colors.red,
            ce = colors.red,
            r = colors.cyan,
            rm = colors.cyan,
            ['r?'] = colors.cyan,
            ['!'] = colors.red,
            t = colors.red,
        }
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 1 },
}


lualine.setup(config)
