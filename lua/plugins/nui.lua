function MyPopup()
    local Popup = require("nui.popup")
    local NuiText = require("nui.text")
    local event = require("nui.utils.autocmd").event

    local popup = Popup({
        enter = true,
        focusable = true,
        border = {
            style = "rounded",
            text = {
                top = "My KeyMap",
                top_align = "center",
            },
        },
        position = "50%",
        size = {
            width = "80%",
            height = "60%",
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:SpecialChar",
        },
    })
    -- mount/open the component
    popup:mount()

    -- unmount component when cursor leaves buffer
    popup:on(event.BufLeave, function()
        popup:unmount()
    end)

    -- set content
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, {
        string.format("%s   %s    %s", "n", "-", "切换主题"),
        string.format("%s   %s    %s", "n", "]", "跳转到上一段落"),
        string.format("%s   %s    %s", "n", "[", "跳转到下一段落"),
        string.format("%s   %s    %s", "v", "3", "快速注释"),
        string.format("%s   %s    %s", "n", "alt+-", "加载更多配置"),
        string.format("%s   %s    %s", "n", "F5", "打开或关闭虚拟终端"),
        string.format("%s   %s    %s", "n", "ctrl+b", "打开目录树"),
        string.format("%s   %s    %s", "n", "[1 / 2 / 3]", "[跳转到前一个/后一个/删除其他]buffer"),
        string.format("%s   %s    %s", "n", "space+g", "跳转到: 函数/变量定义"),
        string.format("%s   %s    %s", "n", "space+r", "重命名"),
        string.format("%s   %s    %s", "n", "space+c", "修改建议"),
        string.format("%s   %s    %s", "n", "space+f", "格式化文档"),
        string.format("%s   %s    %s", "n", "space+d", "查看: method textDocument/declaration"),
        string.format("%s   %s    %s", "n", "space+k", "查看: 代码的Tip悬浮展示"),
        string.format("%s   %s    %s", "n", "space+i", "查看: 当前代码(主要是函数方法/变量)的实现定位"),
        string.format("%s   %s    %s", "n", "space+h", "查看: 签名帮助"),
        string.format("%s   %s    %s", "n", "space+a", "查看: 类型定义"),
        string.format("%s   %s    %s", "n", "space+s", "查看: 当前代码符号的引用查询"),
        string.format("%s   %s    %s", "n", "space+e", "查看代码诊断信息"),
        string.format("%s   %s    %s", "n", "space+q", "查看所有错误"),
        string.format("%s   %s    %s", "n", "space+y", "复制诊断信息"),
        string.format("%s   %s    %s", "n", "leader+o", "查找历史文件"),
        string.format("%s   %s    %s", "n", "leader+f", "查找当前目录下的文件"),
        string.format("%s   %s    %s", "n", "leader+t", "打开telescope"),
        string.format("%s   %s    %s", "n", "leader+b", "显示已打开的buffer"),
        string.format("%s   %s    %s", "n", "leader+s", "显示当前文件函数/变量"),
    })
end
