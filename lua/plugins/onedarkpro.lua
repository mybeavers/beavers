require("onedarkpro").setup({
    colors = {
        dark = {
            telescope_prompt = "require('onedarkpro.helpers').darken('bg', 1, 'onedark')",
            telescope_results = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')",
            telescope_preview = "require('onedarkpro.helpers').darken('bg', 6, 'onedark')",
            telescope_selection = "require('onedarkpro.helpers').darken('bg', 8, 'onedark')",
        },
        light = {
            bg= "#fdf6e3",
            telescope_prompt = "require('onedarkpro.helpers').darken('bg', 2, 'onelight')",
            telescope_results = "require('onedarkpro.helpers').darken('bg', 5, 'onelight')",
            telescope_preview = "require('onedarkpro.helpers').darken('bg', 7, 'onelight')",
            telescope_selection = "require('onedarkpro.helpers').darken('bg', 9, 'onelight')",
        },
    },
    highlights = {
        TelescopeBorder = {
            fg = "${telescope_results}",
            bg = "${telescope_results}",
        },

        TelescopePromptBorder = {
            fg = "${telescope_prompt}",
            bg = "${telescope_prompt}",
        },
        TelescopePromptCounter = { fg = "${fg}" },
        TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
        TelescopePromptPrefix = {
            fg = "${purple}",
            bg = "${telescope_prompt}",
        },
        TelescopePromptTitle = {
            fg = "${telescope_prompt}",
            bg = "${purple}",
        },
        TelescopePreviewTitle = {
            fg = "${telescope_results}",
            bg = "${green}",
        },
        TelescopeResultsTitle = {
            fg = "${telescope_results}",
            bg = "${telescope_results}",
        },
        TelescopeMatching = { fg = "${blue}" },
        TelescopeNormal = { bg = "${telescope_results}" },
        TelescopeSelection = { bg = "${telescope_selection}" },
        TelescopePreviewNormal = { bg = "${telescope_preview}" },
        TelescopePreviewBorder = { fg = "${telescope_preview}", bg = "${telescope_preview}" },
    },
    options = {
        --支持透明主題
    },
    styles = {
    types = "NONE",
    methods = "NONE",
    numbers = "NONE",
    strings = "NONE",
    comments = "NONE",
    keywords = "bold,italic",
    constants = "NONE",
    functions = "NONE",
    operators = "NONE",
    variables = "NONE",
    parameters = "NONE",
    conditionals = "NONE",
    virtual_text = "NONE",


  },

})

local hour = tonumber(os.date("%H"))
if hour >= 16 or hour < 10 then
    vim.api.nvim_exec("color onedark", false)
else
    vim.api.nvim_exec("color onelight", false)
end
