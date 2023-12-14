
---------------------------------
--          通用设置
---------------------------------
vim.o.filetype="on"								-- 设置开启文件类型侦测
vim.o.eb=false									-- 关闭错误的提示
vim.o.syntax="enable"							-- 开启语法高亮功能
vim.o.syntax="on"								-- 自动语法高亮
vim.o.mouse = ""								-- 禁用鼠标
vim.o.background="dark"							-- 背景颜色
vim.wo.cursorline = true						-- 高亮所在行
vim.wo.signcolumn = "yes"						-- 显示左侧图标指示列
vim.o.showmode = false							-- 是否在命令行下显示当前模式
vim.g["omni_sql_no_default_maps"] = 1			-- 取消sql提示
vim.o.splitbelow = true							-- 新窗口的位置
vim.o.splitright = true							-- 新窗口的位置
vim.o.updatetime = 300							-- 更新时间
vim.o.timeoutlen = 100							-- 等待mapping时间
vim.o.pumheight = 10							-- 插入模式下弹出式菜单的高度
vim.o.laststatus = 3							-- 分割window时状态栏不变
-- vim.o.mouse = "a"							-- 启用鼠标

---------------------------------
--          代码缩进和排版           
---------------------------------
vim.o.autoindent = true							-- 设置自动缩进
vim.o.smartindent = true						-- 根据上一行的缩进决定下一行的缩进
vim.o.cindent = true							-- 设置使用c/c++语言的自动缩进方式
vim.o.cinoptions ='g0,:0,N-s,(0'				-- 设置c/c++语言的具体缩进方式

vim.o.expandtab=false							-- 禁止空格替换tab
vim.o.expandtab = true							-- 按tab键时插入空格
vim.o.shiftwidth = 4							--  设置格式化时制表符占用空格数
vim.o.tabstop = 4								-- 设置编辑时制表符占用空格数
vim.o.softtabstop = 4							-- 设置4个空格为一个制表符

vim.o.shiftround = true							-- 缩进列数自动取整
vim.o.wrap = false								-- 禁止折行
vim.o.scrolloff = 8								-- 向右滑动距离
vim.o.sidescrolloff = 8							-- 右部距离


---------------------------------
--          搜索设置           
---------------------------------
vim.o.hlsearch = false							-- 高亮显示搜索结果
vim.o.incsearch = true							-- 开启实时搜索
vim.o.ignorecase=true				            -- 搜索时大小写不敏感
vim.o.smartcase = true							-- 搜索智能匹配大小写



---------------------------------
--          代码补全
---------------------------------
vim.o.wildmenu=true								-- vim自身命名行模式智能补全
vim.o.completeopt="menuone,preview,noselect"	-- 补全时不显示窗口，只显示补全列表
vim.o.omnifunc="syntaxcomplete#Complete"		-- 设置全能补全
vim.o.cpt="kspell"								-- 设置补全单词
vim.o.shortmess = vim.o.shortmess .. 'c'		-- 智能补全


---------------------------------
--          缓存设置
---------------------------------
vim.o.backup = false							-- 设置不备份
vim.o.writebackup = false						-- 禁止生成交换文件
vim.o.swapfile = false							-- 禁止生成临时文件
vim.o.autoread=true								-- 文件在vim之外修改过，自动重新读入
vim.o.autowrite=true							-- 设置自动保存
vim.o.confirm=true								-- 在处理未保存或只读文件的时候，弹出确认
vim.o.hidden = true								-- 允许隐藏被修改过的buffer





---------------------------------
--          字符编码
---------------------------------
vim.o.langmenu="zh_CN.UTF-8"
vim.o.helplang="cn"
vim.o.encoding="utf8"
vim.o.fileencodings="utf8,ucs-bom,gbk,cp936,gb2312,gb18030"

