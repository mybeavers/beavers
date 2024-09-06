autocmd({ "BufEnter", "ColorScheme" }, {
    pattern = "*",
    callback = function()
        highlight(0, "statuslineNormal", { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.SoftBlue })
        highlight(0, "statuslineNormalIcon",
            { fg = CoreUIColorGroup.SoftBlue, bg = get_highlight_group_bg("NvimTreeCursorLine") })
        highlight(0, "statuslineNormalLeftIcon",
            { fg = CoreUIColorGroup.SoftBlue })


        highlight(0, "statuslineInsert", { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.SoftViolet })
        highlight(0, "statuslineInsertIcon",
            { fg = CoreUIColorGroup.SoftViolet, bg = get_highlight_group_bg("NvimTreeCursorLine") })
        highlight(0, "statuslineInsertLeftIcon",
            { fg = CoreUIColorGroup.SoftViolet })



        highlight(0, "statuslineCommand", { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.red })
        highlight(0, "statuslineCommandIcon",
            { fg = CoreUIColorGroup.red, bg = get_highlight_group_bg("NvimTreeCursorLine") })
        highlight(0, "statuslineCommandLeftIcon",
            { fg = CoreUIColorGroup.red })


        highlight(0, "statuslineVisual", { fg = CoreUIColorGroup.black, bg = CoreUIColorGroup.SoftGreen })
        highlight(0, "statuslineVisualIcon",
            { fg = CoreUIColorGroup.SoftGreen, bg = get_highlight_group_bg("NvimTreeCursorLine") })
        highlight(0, "statuslineVisualLeftIcon",
            { fg = CoreUIColorGroup.SoftGreen, bg = get_highlight_group_bg("NvimTreeCursorLine") })

        highlight(0, "statuslineFileName", { bg = get_highlight_group_bg("NvimTreeCursorLine") })
        highlight(0, "statuslineFileNameIcon", { fg = get_highlight_group_bg("NvimTreeCursorLine") })
    end,
    nested = true,
})




-- ------------
-- mode
-- ------------
mode = setmetatable({
        ['n'] = { string = 'NORMAL', mode_hl = '%#statuslineNormal#', mode_right_icon = '', mode_icon_hl = '%#statuslineNormalIcon#', mode_icon_left_hl = "%#statuslineNormalLeftIcon#" },
        ['i'] = { string = 'INSERT', mode_hl = '%#statuslineInsert#', mode_right_icon = '', mode_icon_hl = '%#statuslineInsertIcon#', mode_icon_left_hl = "%#statuslineInsertLeftIcon#" },
        ['v'] = { string = 'VISUAL', mode_hl = '%#statuslineVisual#', mode_right_icon = '', mode_icon_hl = '%#statuslineVisualIcon#', mode_icon_left_hl = "%#statuslineVisualLeftIcon#" },
        ['c'] = { string = 'COMMAND', mode_hl = '%#statuslineCommand#', mode_right_icon = '', mode_icon_hl = '%#statuslineCommandIcon#', mode_icon_left_hl = "%#statuslineCommandLeftIcon#" },
        ['t'] = { string = 'TERMINAL', mode_hl = '%1*', mode_right_icon = '', mode_left_icon = '', mode_icon_hl = '%2*' },
    },
    {
        __index = function()
            return { string = 'Unknown', short = 'U', hl = '%#MiniStatuslineModeOther#' }
        end,
    })

section_mode = function()
    mode_info = mode[vim.fn.mode()]
    return mode_info.mode_hl .. mode_info.string .. mode_info.mode_icon_hl .. mode_info.mode_right_icon .. filename()
end

section_mode_left = function()
    mode_info = mode[vim.fn.mode()]
    return mode_info.mode_icon_left_hl .. "" .. mode_info.mode_hl .. " "
end
-- ----------------
-- file
-- ----------------
function filename()
    local filepath = vim.api.nvim_buf_get_name(0)
    local splitString = vim.split(filepath, "/")
    local tmp = splitString[#splitString]
    local name, extension = string.match(tmp, "(.+)%.(%w+)")

    if name == nil then
        return "%t"
    end

    local fileBG = "%#statuslineFileName#"
    local fileIcon = "%#statuslineFileNameIcon#"
    return fileBG .. name .. fileIcon .. ''
end

--------------
-- LSP诊断信息
-- -----------

diagnostic_levels = {
    { name = 'ERROR', hl = "%#DiagnosticError#" },
    { name = 'WARN',  hl = '%#DiagnosticWarn#' },
    { name = 'INFO',  hl = "%#DiagnosticInfo#" },
    { name = 'HINT',  hl = "%#DiagnosticHint#" },
}


get_diagnostics_Count = function()
    local res = {}
    for _, d in ipairs(vim.diagnostic.get(0)) do
        res[d.severity] = (res[d.severity] or 0) + 1
    end

    local count = res
    local severity = vim.diagnostic.severity
    local severityCount = {}
    for _, level in ipairs(diagnostic_levels) do
        local n = count[severity[level.name]] or 0
        severityCount[#severityCount + 1] = n
    end
    return severityCount
end

section_diagnostics = function()
    local array = get_diagnostics_Count()
    
    return "%#DiagnosticError#" .. '  ' .. array[1] ..
        '%#DiagnosticWarn#' .. '  ' .. array[2] ..
        "%#DiagnosticInfo#" .. " 󰋼 " .. array[3] ..
        "%#DiagnosticHint#" .. ' 󰌵' .. array[4]
end


-- 获取显示组的bg 以合适的格式返回
function get_highlight_group_bg(group_name)
    local hl = vim.api.nvim_get_hl_by_name(group_name, true)
    local str = vim.inspect(hl)
    local table = assert(loadstring("return" .. str))()
    local backgroundValue = table.background
    return "#" .. string.format("%x", backgroundValue)
end

function get_lsp()
    local clients = vim.lsp.get_clients()
    local lspname
    for _, client in ipairs(clients) do
        lspname = client.name
    end
    if lspname == nil then
        return "  utf8"
    end
    return "  " .. lspname
end

statusLine_right_show = function()
    return section_mode() .. "%l:%v"
end

statusLine_left_show = function()
    return section_diagnostics() .. "  " .. get_lsp() .. "  " .. section_mode_left()
end


vim.go.statusline = "%{%v:lua.statusLine_right_show()%}%*%=%{%v:lua.statusLine_left_show()%}%*"
