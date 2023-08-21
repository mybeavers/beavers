-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- jk移动时光标下上方保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 开启行号
--vim.wo.number = true
--vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 缩进4个空格等于一个Tab


vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

-- >> << 时移动长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

-- 新行对齐当前行，空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 搜索不要高亮
vim.o.hlsearch = false

-- 边输入边搜索
vim.o.incsearch = true

-- 使用增强状态栏后不再需要 vim 的模式提示
vim.o.showmode = false

-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 禁止折行
vim.o.wrap = false
vim.wo.wrap = false

-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.mouse = ""
-- 更新时间300秒
vim.o.updatetime = 300

-- 等待mappings
vim.o.timeoutlen = 100

-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true

-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
-- 白色主题
--vim.o.background = "light"
-- 黑色主题
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.pumheight = 10
-- 分割window时状态栏不变
vim.o.laststatus = 3

-- 取消sql提示
vim.g["omni_sql_no_default_maps"] = 1 
-- 不可见字符的显示，这里只把空格显示为一个点
-- vim.o.list = true
-- vim.o.listchars = "space:·"
--tab栏
-- vim.o.showtabline = 2
-- 鼠标支持
--vim.o.mouse = "a"
-- 命令行高为2，提供足够的显示空间
--vim.o.cmdheight = 2
-- 右侧参考线，超过表示代码太长了，考虑换行
--vim.wo.colorcolumn = "80"
-- 相对行号
--vim.wo.relativenumber = true

--vim.opt.list = true 显示行号符
--vim.opt.listchars:append "eol:↴" 设置换行符
vim.o.statusline = "%1*%=%-7.(%l,%c%V%)%t  "
