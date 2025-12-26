local autocmd = require("vimrc.autocmd")
local highlight = require("vimrc.highlight")

autocmd "WinEnter" {
    desc = "ファイルの変更チェックの頻度を強化 (https://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html)",
    command = "checktime",
}

highlight.set {
    ExtraWhitespace = { bg = "#ff0a1e" },
}

autocmd { "BufRead", "BufNew", "FileType", "InsertEnter", "InsertLeave" } {
    desc = "末尾空白ハイライト (https://github.com/bronson/vim-trailing-whitespace)",
    callback = function(context)
        local disable = { "markdown", "ddu-ff", "ddu-filer", "mason", "lspinfo" }
        local ft = vim.opt.filetype:get()
        for _, i in ipairs(disable) do
            if ft == i then
                vim.cmd([=[ match ExtraWhitespace /^^/ ]=])
                return
            end
        end
        if context.event == "InsertEnter" then
            vim.cmd([=[ match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/ ]=])
        else
            vim.cmd([=[ match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/ ]=])
        end
    end,
}

autocmd { "FocusGained", "FocusLost" } {
    desc = "Vimにフォーカスを戻した時だけマウスを無効に",
    callback = function(context)
        local modes = { "n", "i", "c", "v", "s", "o" }
        if context.event == "FocusGained" then
            local enable_mouse = function()
                -- del だと エラー(No such mapping) 出るので set で リセット
                vim.keymap.set(modes, "<LeftMouse>", "<LeftMouse>")
            end
            vim.keymap.set({ "n", "i", "c", "v", "s", "o" }, "<LeftMouse>", enable_mouse)
            autocmd { "CursorMoved", "CursorMovedI", "ModeChanged", "WinScrolled" } {
                callback = enable_mouse,
                once = true,
            }
        elseif context.event == "FocusLost" then
            vim.keymap.set(modes, "<LeftMouse>", "<nop>")
        end
    end,
}

autocmd "CmdlineLeave" {
    desc = "検索コマンドからの離脱時にIMEをoffにする",
    pattern = { "/", "?" },
    callback = function()
        if vim.fn.has("nvim") then
            local res = vim.system({
                "osascript",
                "-e",
                'tell application "System Events" to key code 102', -- 102: EISU
            }):wait()
            if res.code ~= 0 or res.signal ~= 0 then
                error(vim.inspect(res))
            end
        end
    end,
}

autocmd "CmdlineEnter" {
    desc = "入力補完オプション変更",
    pattern = ":",
    callback = function()
        local save = vim.o.completeopt
        vim.o.completeopt = "menu,noselect"
        autocmd "CmdlineLeave" {
            callback = function()
                vim.o.completeopt = save
            end,
            once = true,
        }
    end,
}

autocmd "CmdwinEnter" {
    desc = "cmdwin の設定",
    callback = function(context)
        vim.cmd("TSContext disable")
        vim.cmd([[g/\v(^qa?!?|^wq?a?!?)$/d]])
        vim.opt_local.number = false
        vim.opt_local.signcolumn = "no"
        local save_cmdheight = vim.opt.cmdheight
        vim.opt.cmdheight = 0
        vim.keymap.set("n", "<ESC>", "<Cmd>:q<CR>", { buffer = context.buf })
        autocmd "CmdwinLeave" {
            callback = function()
                vim.cmd("TSContext enable")
                vim.opt.cmdheight = save_cmdheight
            end,
            once = true,
        }
    end,
}
