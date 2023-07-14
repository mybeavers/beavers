-- 创建javase项目目录
vim.cmd([[
    command MvnJavaSE :execute "!cp -r ~/.config/templates/javaSE/* ./" 
]])

-- 创建javaweb项目目录
vim.cmd([[
    command MvnJavaMVC :execute "!cp -r ~/.config/templates/javaMVC/* ./"
]])

vim.cmd([[
    command MvnJavaSpringBoot :execute "!cp -r ~/.config/templates/javaSpringBoot/* ./"
]])


