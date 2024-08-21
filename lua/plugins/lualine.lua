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
local function filename()
    filepath = vim.api.nvim_buf_get_name(0)
    splitString = vim.split(filepath, "/")
    tmp = splitString[#splitString]
    name, extension = string.match(tmp, "(.+)%.(%w+)")

    if name == nil then
        return "%t"
    end

    if string.len(name) > 10 then
        local substr1 = string.sub(name, 1, 4)
        local substr2 = substr1.sub(name, -4, -1)
        return substr1 .. "" .. ".." .. substr2
    end
    return name
end

local function mySystemIcon()
    return ""
end
-- Config
local config = {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = ' ', right = ' ' },
        section_separators = { left = "", right = "" },
    },
--
    sections = {
        lualine_a = {
            'mode',
        },
        lualine_b = { filename },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {mySystemIcon},
    },
}


local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end



-- 显示添加/修改/删除
ins_left {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = " ", modified = " ", removed = " " },
    diff_color = {
        added = { fg = CoreUIColorGroup.DarkGrayish },
        modified = { fg = CoreUIColorGroup.DarkGrayish },
        removed = { fg = CoreUIColorGroup.DarkGrayish },
    },
    cond = conditions.hide_in_width,
}

-- 显示代码错误信息
ins_right {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = "󰋼 ", hint = "󰌵" },
    cond = conditions.hide_in_width,

}

-- git分支
--ins_right {
--    'branch',
--    icon = '',
--    cond = conditions.hide_in_width,
--    color = { fg = CoreUIColorGroup.violet, gui = 'bold' },
--}
ins_right {
    function()
        local clients = vim.lsp.get_clients()
        local lspname
        for _, client in ipairs(clients) do
            lspname = client.name
        end
        if lspname == nil then
            return "utf8"
        end
        return lspname
    end,
    icon = " ",
    color = { fg = CoreUIColorGroup.SoftViolet },
    cond = conditions.hide_in_width,
}


ins_right {
    "progress",
    icon = "",
    color = { fg = CoreUIColorGroup.ModerateOrange }
}
lualine.setup(config)
