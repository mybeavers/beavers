
vim.cmd[[colorscheme onedark]]


require("onedarkpro").setup({
    colors = {
        onelight = {
            bg= "#fdf6e3",
        },

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


