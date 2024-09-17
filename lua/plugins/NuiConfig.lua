function lspMenu()
    local Menu = require("nui.menu")
    local event = require("nui.utils.autocmd").event
    local menu = Menu({
        position = "50%",
        size = {
            width = 20,
            height = 10,
        },
        border = {
            style = "single",
            text = {
                top = "[--LSP USEING--]",
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "FloatBorder:MyCmpFloatBorder",
        },
    }, {
        lines = {
            Menu.item("definition", { id = 1 }),
            Menu.item("refernces"),
            Menu.item("code action"),
            Menu.item("implementation"),
            Menu.item("rename"),
            Menu.item("format"),
            Menu.item("hover"),
            Menu.item("signature help"),
            Menu.item("type definition"),
            Menu.item("declaration"),

        },
        max_width = 30,
        keymap = {
            focus_next = { "j", "<Down>", "<Tab>" },
            focus_prev = { "k", "<Up>", "<S-Tab>" },
            close = { "<Esc>", "<C-c>" },
            submit = { "<CR>", "<Space>" },
        },
        on_close = function()
        end,
        on_submit = function(item)
            local buf = vim.lsp.buf
            if item.text == "definition" then
                buf.definition()
            elseif item.text == "refernces" then
                buf.references()
            elseif item.text == "code action" then
                buf.code_action()
            elseif item.text == "implementation" then
                buf.implementation()
            elseif item.text == "rename" then
                buf.rename()
            elseif item.text == "format" then
                buf.format { async = true }
            elseif item.text == "hover" then
                buf.hover()
            elseif item.text == "signature help" then
                buf.signature_help()
            elseif item.text == "type definition" then
                buf.type_definition()
            elseif item.text == "declaration" then
                buf.declaration()
            end
        end,
    })

    -- mount the component
    menu:mount()
end


MyKeymap("n", "<space>t", ":lua lspMenu()<CR>", MyKeymapOpt)
