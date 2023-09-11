local autocmd = require('rc.util').autocmd
local highlight = require('rc.util').highlight

autocmd 'WinEnter' {
    desc = 'ファイルの変更チェックの頻度を強化 (https://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html)',
    command = "checktime"
}

autocmd 'FileType' {
    desc = 'インデントのスペースの数2のファイルタイプ設定',
    pattern = { 'astro', 'dart', 'javascript', 'json', 'pdf', 'scss', 'typescript', 'typescriptreact', 'vim' },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
}

highlight.set {
    ExtraWhitespace = { bg = '#ff0a1e' }
}

autocmd { 'BufRead', 'BufNew', 'FileType', 'InsertEnter', 'InsertLeave' } {
    desc = '末尾空白ハイライト (https://github.com/bronson/vim-trailing-whitespace)',
    callback = function(context)
        local disable = { 'markdown', 'ddu-ff', 'ddu-filer', 'mason', 'lspinfo' }
        local ft = vim.opt.filetype:get()
        for _, i in ipairs(disable) do
            if ft == i then
                vim.cmd([=[ match ExtraWhitespace /^^/ ]=])
                return
            end
        end
        if context.event == 'InsertEnter' then
            vim.cmd([=[ match ExtraWhitespace /\\\@<![\u3000[:space:]]\+\%#\@<!$/ ]=])
        else
            vim.cmd([=[ match ExtraWhitespace /\\\@<![\u3000[:space:]]\+$/ ]=])
        end
    end
}

autocmd { 'FocusGained', 'FocusLost' } {
    desc = 'Vimにフォーカスを戻した時だけマウスを無効に',
    callback = function(context)
        local modes = { 'n', 'i', 'c', 'v', 's', 'o' }
        if context.event == 'FocusGained' then
            local enable_mouse = function()
                -- del だと エラー(No such mapping) 出るので set で リセット
                vim.keymap.set(modes, '<LeftMouse>', '<LeftMouse>')
            end
            vim.keymap.set({ 'n', 'i', 'c', 'v', 's', 'o' }, '<LeftMouse>', enable_mouse)
            autocmd { 'CursorMoved', 'CursorMovedI', 'ModeChanged', 'WinScrolled' } {
                callback = enable_mouse,
                once = true
            }
        elseif context.event == 'FocusLost' then
            vim.keymap.set(modes, '<LeftMouse>', '<nop>')
        end
    end
}

autocmd 'CmdlineLeave' {
    desc = '検索コマンドからの離脱時にIMEをoffにする',
    pattern = { '/', '?' },
    callback = function()
        -- 102: EISU
        vim.fn.system [[
            osascript -e "tell application \"System Events\" to key code 102"
        ]]
    end,
}

autocmd 'CmdlineEnter' {
    desc = '入力補完オプション変更',
    pattern = ':',
    callback = function()
        local save = vim.o.completeopt
        vim.o.completeopt = 'menu,noselect'
        autocmd 'CmdlineLeave' {
            callback = function()
                vim.o.completeopt = save
            end
        }
    end
}

autocmd 'CmdwinEnter' {
    desc = 'cmdwin の設定',
    callback = function(context)
        vim.cmd('TSContextDisable')
        vim.cmd([[g/\v(^qa?!?|^wq?a?!?)$/d]])
        vim.opt_local.number = false
        vim.opt_local.signcolumn = 'no'
        local save_cmdheight = vim.opt.cmdheight
        vim.opt.cmdheight = 0
        vim.keymap.set('n', '<ESC>', '<Cmd>:q<CR>', { buffer = context.buf })
        autocmd 'CmdwinLeave' {
            callback = function()
                vim.cmd('TSContextEnable')
                vim.opt.cmdheight = save_cmdheight
            end,
            once = true
        }
    end
}
