# Nvimconfig 
**Nvimconfig是nvim的配置.**


<br><br>

<h2 align="center"> 展示 </h2>

### 目录树/开始页/主题色彩

![开始页](https://gitee.com/liaoqiao123/file_code/raw/master/images/b.png)

### 智能补全/代码诊断

![代码高亮](https://gitee.com/liaoqiao123/file_code/raw/master/images/a.png)

### markdown实时预览

![代码高亮](https://gitee.com/liaoqiao123/file_code/raw/master/images/c.png)

### winber和git显示
![winber](https://gitee.com/liaoqiao123/file_code/raw/master/images/d.png)

<br><br><hr>
 


#### 1. 安装nvim
- 安装稳定版本

> sudo apt-add-repository ppa:neovim-ppa/stable  
> sudo apt-get update && apt-get install neovim  


- 或安装最新版本
> sudo apt-add-repository ppa:neovim-ppa/unstable  
> sudo apt-get update && apt-get install neovim


<br> 



<br> 

#### 3.Github下载我的配置:
1. `cd ~/.config/`
2. `git clone https://github.com/liaoqiao1/NvimConfig.git && mv NvimConfig nvim`

#### 或者在Gitee下载我的配置:
1. `cd ~/.config/`
2. `git clone https://gitee.com/liaoqiao123/nvimconfig.git && mv nvimconfig nvim`

<br><br>

#### 4. 配置概述
```
├── init.vim                #配置加载
├── lua
│   ├── 1_set.lua           #set配置
│   ├── 2_plug.lua          #插件安装
│   ├── 3_key.lua           #快捷键配置
│   ├── 4_command.lua       #自定义命令
│   ├── Lsp                 #lsp服务器/cmd补全
│   │   ├── cmp.lua
│   │   ├── handlers.lua 
│   │   └── lspinit.lua   
│   ├── PlugConfig          #插件的单独配置
│   │   ├── bufferline.lua
│   │   ├── dashboard.lua
│   │   ├── indent.lua
│   │   ├── lualine.lua
│   │   ├── markdown.lua
│   │   ├── nvimtree.lua
│   │   ├── onedarkpro.lua
│   │   ├── treesitter.lua
│   │   └── ultisnips.lua
│   └── Ultisnips           #自定义代码片段
│       ├── all.snippets
│       ├── java.snippets
│       ├── markdown.snippets
│       ├── python.snippets
│       └── README.md
└── README.md               
```


<br><br>
>
#### 5. 常用快捷键

|自定义快捷键|说明			             |
|---       |---                          |
|vs        | 分割窗口                    |
|=         | 格式化代码                  |
|q         | 保存                        |
|w         | 退出                        |
|gd        |跳转到函数实现               |
|gD        |跳转到函数声明               |
|gr        |查看函数参考文档             |
|space+e   |查看错误信息                 |
|space+rn  |重命名函数                   |
|[d        |跳转到上一个错误位置         |         
|]d        |跳转到下一个错误位置         |
|Ctrl-b    |目录树打开与关闭	         |
|Ctrl-f    |打开文件搜索                 |
|Shift-F12 |代码一键运行/markdown实时渲染|
|Shift-F11 |标签页切换                   |
|Shift-F10 |保存退出/关闭markdown渲染    |




