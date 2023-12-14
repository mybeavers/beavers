### my neovim config   😗😗



<h2 align="center"> Show </h2>

<h4 align = 'center'> Colorscheme </h4>

![colors](https://gitee.com/liaoqiao123/file_code/raw/master/images/b.png)

<br> 


<h4 align = 'center'> LSP </h4>


![lsp](https://gitee.com/liaoqiao123/file_code/raw/master/images/a.png)

<br> 


<h4 align = 'center'> Markdown </h4>

![markdown](https://gitee.com/liaoqiao123/file_code/raw/master/images/c.png)


<br><br><hr>

<br><br>

<br><br>


<h1 align="center"> Install VIM </h1>

安装环境: ubuntu > apt, 确保安装python3, 并且安装pip3  
> sudo add-apt-repository ppa:neovim-ppa/unstable && sudo apt update   
> sudo apt install neovim && sudo pip3 install pynvim  

<br> 

我的配置  
> cd ~/.config && git clone https://gitee.com/mybeavers/beavers.git && mv beavers nvim   



<h1 align="center"> USE VIM </h1>







#### 一. 基本模式
1. **命令模式**(Command mode)
    - 说明: 默认进入命令模式, 其他模式中按 ESC 键进入此模式.
    - 作用: 此状态下, 敲击键盘动词会被Vim识别为命令[可以理解为快捷键].
2. **输入模式**(Insert mode)
    - 说明: 在命令模式下按 i 进入此模式.
    - 作用: 文本编辑.
3. **底线命令模式**(Last line mode)
    - 说明: 在命令模式下按 : 进入此模式.
    - 作用: 此模式会将输入的字符识别为命令, 如: w(保存), q(退出)...

> 注: 在底线模式下输入 wq 可保存退出Vim. [如何产生一个随机字符? - - 让新手退出Vim]

<br><br>





#### 二. 光标移动
> 光标移动操作默认在命令模式下进行
1. **方向移动**
    - 方式一: h  [光标右移] , j [光标下移] , k [光标上移] , l [光标左移] 
    - 方式二: 键盘方向键

<br> 


2. **单词跳转**
    - w/W : 向后跳转一个单词距离[按照空格判断]
    - b/B : 向前跳转一个单词距离[按照空格判断]

<br> 


3. **行内跳转**
    - $ : 跳转到当前光标行的最后一个字符后.
    - 0 : 跳转到当前光标行的开头.
    - Home键跳转到行的开头, End键跳转到行尾部. 功能与$, 0相同.

<br> 


4. **行间跳转**
    - gg : 跳转到文件的首行
    - G : 跳转到文件的尾行
    - 指定行跳转 > 底线命令模式: number 
        - 例[跳转到10行的位置]: 10
    - Shift+{ : 移动到上一个段落
    - Shift+} : 移动到下一个段落
    - ctrl+u : 光标向上滚动半屏[根据空格判断]
    - ctrl+d : 光标向下滚动半屏[根据空格判断]

<br> 


5. **括号跳转**
    - % : 匹配字符[{}, [], ()]间跳转.

<br> 



6. **字符匹配查询**
    - / : 输入想要移动的字符, vim会在当前文件内进行字符匹配
    - n : 当使用 / 搜索字符时, 如何有多个结果, 可以使用 n 跳转到下一个结果

