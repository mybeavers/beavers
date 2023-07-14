## 自定义代码片段: ultisnips

### 一.创建代码片段文件
1. 设置
    - `let g:UltiSnipsSnippetDirectories = ["~/.config/nvim/lua/Ultisnips/"]`
    - 说明: 该方法设置的代码片段的文件夹位置

2. 在指定的文件夹下创建 .snippets文件
    1. all.snippets
        - 所有文件类型都可用.
    2. 文件类型.snippets
        - 设置单个文件类型使用,

3. 示例
    1. python.snippets
        - 只有python类型文件可用
    2. java.snippets
        - 只有java类型文件可用
    3. all.snippets
        - 所有文件类型都可用


### 二.语法:

> snippet 触发字符 ["代码片段说明"] [参数]  
> 代码片段内容  
> endsnippet  


1. 示例
```
snippet #! "#!/usr/.." b
#!/usr/bin/env python3
$0
endsnippet
```

2. 说明:
    1. 在python文件中输人 #! 会触发该代码片段
    2. 代码片段说明与参数是可选的
    3. $0 是占位符.
    4. snippet代表开始, endsnippet代表结束
    5. 代码段与代码段之间应该由空格隔开

### 参数说明
1. b 表示触发字符应该在一行的开始
2. i 表示触发字符可以在单词内
3. e 表示自定义上下文
4. w 表示触发字符的前后必须是一个字母分界点

<br><br>




#### 1. 观察模式替换
在Snippets中包含一个特殊的替换字符 ${VISUAl}。用来替换选中的文字。  

> 在观察模式下选中一些文字，按下触发（g:UltiSnipsExpandTrigger）键，  
> 这时选中的文字会被删除，进入插入模式，输入触发关键字，触发代码模版，这时就能看到选中的文字在里面.

注意: `g:UltiSnipsExpandTrigger`被映射为`空格+y`组合键.

<br><br>



#### 2. 嵌入python和shell代码
- 嵌入shell代码
> snippet date "time" b  
> today is `date`  
> endsnippet    

- 说明: 反引号中可执行shell代码.

<br><br>
>

- 嵌入python代码
> snippet filename "file name" b  
> ##`!p snip.rv ="{0}".format(snip.basename)`  
> $0
> endsnippet  

- 说明: 反引号中以前缀 !p 开始,可以执行python代码

|方法         |说明                                                          |
|---          |---                                                           |
|fn           |表示当前文件名+后缀                                           |
|path         |当前文件名的路径                                              |
|t            |占位符的字典，可以使用 t[1], t[2], t.v 来取占位符内容         |
|snip         |UltiSnips.TextObjects.SnippetUtil 对象的一个实例              |
|match        |正则代码片段时返回的匹配元素（非常强大）                      |
|snip.rv      |表示 return value，python 代码执行后处理过的字符串赋给 rv 即可|
|snip.ft      |表示当前文件类型                                              |
|snip.basename|当前文件名                                                    |
|snip.v       |表示 VISUAL 模式变量，其中 snip.v.mode 表示模式类型，snip.v.text 表示 VISUAL 模式中选择的字符|

