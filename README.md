### my neovim config   😗😗



<h2 align="center"> UI </h2>

<h4 align = 'center'> Colorscheme </h4>

![colors](https://gitee.com/liaoqiao123/file_code/raw/master/images/b.png)

<br> 


<h4 align = 'center'> LSP </h4>


![lsp](https://gitee.com/liaoqiao123/file_code/raw/master/images/a.png)

<br> 


<h4 align = 'center'> Markdown </h4>

![markdown](https://gitee.com/liaoqiao123/file_code/raw/master/images/c.png)


<br><br><hr>



<h1 align="center"> Install VIM </h1>

安装环境: ubuntu > apt, 确保安装python3, 并且安装pip3  
> `sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt update`  
> `sudo apt install neovim && sudo pip3 install pynvim`

<br> 

我的配置  
> `cd ~/.config && git clone https://github.com/mybeavers/beavers.git && mv beavers nvim`



<h1 align="center"> USE VIM </h1>


#### 快捷键

|**常用快捷键** |说明   |
|---        |---    |
|`ctrl+b`   |打开目录|
|`1` / `2`  |跳转到上一个 或 下一个已经打开的buffer|
|`[` / `]`  |跳转到上一个 或 下一个段落|
|`3`        |在选择模式下 快速注释 或 取消已选定的代码段注释|
|`3`        |删除其他buffers|
|`-`        |主题切换|
|`=`        |对已选定的代码格式化|
|`vs` / `pl`|垂直分隔窗口 或 水平分隔窗口|
|`ESC`      |保存退出所有buffer|
|`q`        |退出当前buffer|
|`F12`      |运行程序|
|`F5`       | 打开/关闭虚拟终端|

<hr><br>


|**LSP快捷键**  |说明|
|---        |---    |
|`space+e`  |查看诊断信息|
|`space+q`  |查看所有错误|
|`space+y`  |复制诊断信息到寄存器|
|`space+g`  |跳转到方法/变量...定义|
|`space+r`  |重命名|
|`space+f`  |格式化|
|`space+d`  |查看: method textDocument/declaration|
|`space+k`  |查看: 代码的Tip悬浮展示|
|`space+i`  |查看: 当前代码(主要是函数方法/变量)的实现定位|
|`space+h`  |查看: 签名帮助|
|`space+a`  |查看: 类型定义|
|`space+s`  |查看: 当前代码符号的引用查询|
|`space+wa` |添加工作区折叠|
|`space+wr` |删除工作区折叠|
|`space+wl` |查看工作曲折叠|

<hr><br>


|**Telescope快捷键**|说明   |
|---            |---    |
|`\+t`|打开Telescope|
|`\+o`|打开Telescope OldFiles|
|`\+f`|打开Telescope Find File|
|`\+b`|打开Telescope Buffers|
|`\+s`|打开Telescope Lsp Document Symbols|
