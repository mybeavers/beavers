--[[
a: 当前路径下添加文件或目录
d: 删除当前光标所在文件
r: 重命名文件或目录
--]]



-- 禁用netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1



vim.opt.termguicolors = true


require("nvim-tree").setup({
  sort_by = "case_sensitive",
 
    view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
    custom = {"^.git$","*.class"},--过滤.git和.class文件
  },
    
})

--equire("nvim-tree").setup()

