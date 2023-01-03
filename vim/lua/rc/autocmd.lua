local autocmd = require('rc.util').autocmd

autocmd 'WinEnter' {
    desc = 'ファイルの変更チェックの頻度を強化 (https://vim-jp.org/vim-users-jp/2011/03/12/Hack-206.html)',
    command = "checktime"
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
    pattern = {'/', '?'},
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
        vim.fn['pum#set_option']('auto_select', false)
        autocmd 'CmdlineLeave' {
            callback = function ()
                if string.match(save, 'noinsert') then
                    vim.fn['pum#set_option']('auto_select', true)
                end
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
        ---@diagnostic disable-next-line: assign-type-mismatch
        vim.opt_local.number = false
        ---@diagnostic disable-next-line: assign-type-mismatch
        vim.opt_local.signcolumn = 'no'
        local save_cmdheight = vim.opt.cmdheight
        vim.opt.cmdheight = 0
        vim.keymap.set('n', '<ESC>', '<Cmd>:q<CR>', { buffer = context.buf })
        autocmd 'CmdwinLeave'  {
            callback = function ()
                vim.cmd('TSContextEnable')
                vim.opt.cmdheight = save_cmdheight
            end,
            once = true
        }
    end
}
