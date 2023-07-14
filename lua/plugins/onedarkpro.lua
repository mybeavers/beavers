
vim.cmd[[colorscheme onedark]]


require("onedarkpro").setup({
    options = {
        --支持透明主題
      --  transparency = true,
    },

    styles = {
    comments = "italic",
    methods = "bold",
    keywords = "italic",
    parameters = "italic",
    functions = "bold",   
  },
  options = {
    cursorline = true
  },

})

local hour = tonumber(os.date("%H"))
if hour >= 16 or hour < 10 then
    vim.api.nvim_exec("color onedark", false)
else
  vim.api.nvim_exec("color onelight", false)
end



