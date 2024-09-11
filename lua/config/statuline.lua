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

        highlight(0, "statuslineGitAdd", { fg = CoreUIColorGroup.ModerateOrange })
        highlight(0, "statuslineGitDelet", { fg = CoreUIColorGroup.SoftRed })

        highlight(0, "statuslineLspName", { fg = CoreUIColorGroup.SoftViolet })
    end,
    nested = true,
})


-- ------------
-- mode  
-- ------------

local mode = setmetatable({
        ['n'] = { string = ' NORMAL ', mode_hl = '%#statuslineNormal#', mode_icon_hl = '%#statuslineNormalIcon#', mode_icon_left_hl = "%#statuslineNormalLeftIcon#" },
        ['i'] = { string = ' INSERT ', mode_hl = '%#statuslineInsert#', mode_icon_hl = '%#statuslineInsertIcon#', mode_icon_left_hl = "%#statuslineInsertLeftIcon#" },
        ['v'] = { string = ' VISUAL ', mode_hl = '%#statuslineVisual#', mode_icon_hl = '%#statuslineVisualIcon#', mode_icon_left_hl = "%#statuslineVisualLeftIcon#" },
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
    local mode_info = mode[vim.fn.mode()]
    return mode_info.mode_hl .. mode_info.string .. mode_info.mode_icon_hl .. ''
end

local section_mode_left = function()
    local mode_info = mode[vim.fn.mode()]
    return mode_info.mode_icon_left_hl .. "" .. mode_info.mode_hl .." "
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
    local error, warn, info, hint = "", "", "", ""

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


local get_lsp        = function()
    local clients = vim.lsp.get_clients()
    local lspname
    for _, client in ipairs(clients) do
        lspname = client.name
    end
    if lspname == nil then
        lspname = "%Y"
    end
    return "%#statuslineLspName#" .. "  " .. lspname end

local line           = function()
    local active_bufnr = tostring(vim.api.nvim_buf_get_name(0))
    local nopass = active_bufnr:match("NvimTree")
    if nopass == "NvimTree" then
        return ""
    end


    return "%l:%v "
end

local git_diff_count = function()
    local handle = io.popen("git rev-parse --show-toplevel 2> /dev/null")
    if handle == nil then
        return ""
    end


    local repo_path = handle:read("*a")
    handle:close()

    if repo_path == "" or repo_path == nil then
        return ""
    end

    local active_bufnr = tostring(vim.api.nvim_buf_get_name(0))
    local nopass = active_bufnr:match("NvimTree")
    if nopass == "NvimTree" then
        return ""
    end

    local git = "git --no-pager diff --stat --no-color --no-ext-diff " .. active_bufnr

    local handle = io.popen(git)
    if handle == nil or handle == 0 then
        return ""
    end
    local str = handle:read("*a")
    handle:close()

    if str == nil or str == "" then
        return ""
    end

    local insertions = str:match("(%d+) insertions")
    local deletions = str:match("(%d+) deletions")
    if insertions == nil then
        insertions = ""
    end
    if deletions == "" then
        deletions = ""
    end



    return "%#statuslineGitAdd#" .. "  " .. insertions .. "%#statuslineGitDelet#" .. "  " .. deletions
end



Right_show = function()
    return section_mode() .. filename() .. line() .. " "
end
Left_show = function()
    return section_diagnostics() .. "  " .. get_lsp() .. "  %#statuslineGitAdd# UTF8 " .. section_mode_left()
end


vim.go.statusline = "%{%v:lua.Right_show()%}%*%=%{%v:lua.Left_show()%}"
