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

local mode = setmetatable({
        ['n'] = { string = ' NORMAL ', mode_hl = '%#statuslineNormal#', mode_icon_hl = '%#statuslineNormalIcon#', mode_icon_left_hl = "%#statuslineNormalLeftIcon#" },
        ['i'] = { string = ' INSERT ', mode_hl = '%#statuslineInsert#',  mode_icon_hl = '%#statuslineInsertIcon#', mode_icon_left_hl = "%#statuslineInsertLeftIcon#" },
        ['v'] = { string = ' VISUAL ', mode_hl = '%#statuslineVisual#',  mode_icon_hl = '%#statuslineVisualIcon#', mode_icon_left_hl = "%#statuslineVisualLeftIcon#" },
        ['c'] = { string = ' COMMAND ', mode_hl = '%#statuslineCommand#', mode_icon_hl = '%#statuslineCommandIcon#', mode_icon_left_hl = "%#statuslineCommandLeftIcon#" },
        ['t'] = { string = ' TERMINAL ', mode_hl = '%#statuslineCommand#', mode_icon_hl = '%#statuslineCommandIcon#', mode_icon_left_hl = "%#statuslineCommandLeftIcon#" },
    },
    {
        __index = function()
            return {
                string = 'UNKONW',
                mode_hl = '%#statuslineNormal#',
                mode_icon_hl =
                '%#statuslineNormalIcon#',
                mode_icon_left_hl = "%#statuslineNormalLeftIcon#"
            }
        end,
    })

local section_mode = function()
    mode_info = mode[vim.fn.mode()]
    return mode_info.mode_hl .. mode_info.string .. mode_info.mode_icon_hl .. ''
end

local section_mode_left = function()
    mode_info = mode[vim.fn.mode()]
    return mode_info.mode_icon_left_hl .. "" .. mode_info.mode_hl .. " "
end

local filename = function()
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

local diagnostic_levels = {
    { name = 'ERROR', hl = "%#DiagnosticError#" },
    { name = 'WARN',  hl = '%#DiagnosticWarn#' },
    { name = 'INFO',  hl = "%#DiagnosticInfo#" },
    { name = 'HINT',  hl = "%#DiagnosticHint#" },
}


local get_diagnostics_Count = function()
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

local section_diagnostics = function()
    local dianosticsCount = get_diagnostics_Count()
    local error,warn,info,hint = "","","",""

    if dianosticsCount[1] > 0 then
        error = "%#DiagnosticError#" .. '  ' .. dianosticsCount[1]
    end
    if dianosticsCount[2] > 0 then
        warn = '%#DiagnosticWarn#' .. '  ' .. dianosticsCount[2]
    end
    if dianosticsCount[3] > 0 then
        info = "%#DiagnosticInfo#" .. " 󰋼 " .. dianosticsCount[3]
    end
    if dianosticsCount[4] > 0 then
        hint = "%#DiagnosticHint#" .. ' 󰌵' .. dianosticsCount[4]
    end

    return error .. warn .. info .. hint
end


local get_lsp = function ()
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

local line = function ()
    return "%l:%v"
end

Right_show = function()
    return section_mode() .. filename() .. line()
end
Left_show = function()
    return section_diagnostics() .. "  " .. get_lsp() .. "  " .. section_mode_left()
end


vim.go.statusline = "%{%v:lua.Right_show()%}%*%=%{%v:lua.Left_show()%}"
