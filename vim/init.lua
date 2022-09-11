local dein_snip = vim.fn.fnamemodify('~/.cache/dein/repos/github.com/ryota2357/dein-snip.lua', ':p')
if not string.match(vim.o.runtimepath, '/dein-snip.lua') then
    if vim.fn.isdirectory(dein_snip) == 0 then
        os.execute('git clone https://github.com/ryota2357/dein-snip.lua.git ' .. dein_snip)
    end
    vim.opt.runtimepath:prepend(dein_snip)
end

vim.g.mapleader = ' ' -- <Space>
vim.g.do_filetype_lua = true
vim.g.did_load_filetypes = false

Config = {
    val = {},
    fn = {}
}

Config.val.two_cell_char = {}
Config.fn.setcellwidths2 = function(char, apply)
    char = char or {}
    apply = apply or true
    if char ~= {} then
        if type(char) == "number" then
            table.insert(Config.val.two_cell_char, { char, char, 2 });
        elseif type(char) == "table" then
            for _, c in ipairs(char) do
                table.insert(Config.val.two_cell_char, { c, c, 2 });
            end
        end
    end
    if apply then
        vim.fn.setcellwidths(Config.val.two_cell_char)
    end
end

Config.fn.modified_bg_bufs = function()
    local ret = {}
    for i = 1, vim.fn.bufnr('$') do
        if vim.fn.bufexists(i) == 1 and vim.fn.buflisted(i) == 1 and vim.fn.getbufvar(i, 'buftype') == '' and
            vim.fn.filereadable(vim.fn.expand('#' .. i .. ':p')) and i ~= vim.fn.bufnr('%') and
            vim.fn.getbufvar(i, '&modified') == 1 then
            table.insert(ret, i)
        end
    end
    return ret
end

Config.fn.statusline = function()
    local mode = (function()
        local match = {
            ['n'] = 'normal',
            ['no'] = 'normal',
            ['v'] = 'visual',
            ['V'] = 'visual',
            [''] = 'visual',
            ['s'] = 'visual',
            ['S'] = 'visual',
            ['i'] = 'insert',
            ['ic'] = 'insert',
            ['R'] = 'replace',
            ['Rv'] = 'replace',
            ['c'] = 'command'
        }
        return match[vim.fn.mode()] or 'other'
    end)()
    local bar = function(count)
        local hl = (function()
            local match = {
                normal = '%#StatusLineNormal#',
                visual = '%#StatusLineVisual#',
                insert = '%#StatusLineInsert#',
                replace = '%#StatusLineReplace#',
                command = '%#StatusLineCommand#'
            }
            return match[mode] or '%#StatusLine#'
        end)()
        return hl .. string.rep('━', count)
    end
    local component = {
        filePath = function()
            local path = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.")
            if path == '' then
                return '', 0
            end
            path = ' ' .. path .. ' '
            return '%#StatusLine#' .. path, vim.fn.strdisplaywidth(path)
        end,
        modified = function()
            local mark = ''
            if vim.o.modified then
                mark = ' '
            else
                mark = ' '
            end
            local bg_modifed_cnt = #Config.fn.modified_bg_bufs()
            if bg_modifed_cnt ~= 0 then
                mark = mark .. '( ' .. tostring(bg_modifed_cnt) .. ')'
            end
            mark = ' ' .. mark .. ' '
            return '%#StatusLine#' .. mark, vim.fn.strdisplaywidth(mark)
        end,
        position = function()
            local l = tostring(vim.fn.line('.'))
            local c = tostring(vim.fn.col('.'))
            local pos = ' ' .. l .. ':' .. c .. ' '
            return '%#StatusLine#' .. pos, vim.fn.strdisplaywidth(pos)
        end
    }

    local column = vim.o.columns
    local file, fileWidth = component.filePath()
    local modify, modifyWidth = component.modified()
    local pos, posWidth = component.position()
    return bar(1)
        .. modify
        .. bar(math.floor((column - modifyWidth - fileWidth - posWidth - 2) / 2))
        .. file
        .. bar(math.ceil((column - modifyWidth - fileWidth - posWidth - 2) / 2))
        .. pos
        .. bar(1)
end

require('dein-snip').setup {
    load = {
        vim = {
            '~/dotfiles/vim/rc/maping.rc.vim',
            '~/dotfiles/vim/rc/option.rc.vim',
        },
        toml = {
            { '~/dotfiles/vim/rc/dein.toml' },
            { '~/dotfiles/vim/rc/dein-lazy.toml', { lazy = true } },
            { '~/dotfiles/vim/rc/ddc.toml', { lazy = true } },
            { '~/dotfiles/vim/rc/ddu.toml', { lazy = true } },
            { '~/dotfiles/vim/rc/dap.toml', { lazy = true } },
            { '~/dotfiles/vim/rc/lsp.toml', { lazy = true } },
            { '~/dotfiles/vim/rc/filetype.toml' }
        }
    },
    notification = {
        enable = true,
        time = 3000
    },
    install = {
        progress_type = 'floating',
        max_processes = 2
    },
    auto_recache = true
}

vim.api.nvim_set_hl(0, "StatusLine", { link = 'Normal' })
vim.api.nvim_set_hl(0, "StatusLineNormal", { fg = '#4caf50', bg = 'NONE' })
vim.api.nvim_set_hl(0, "StatusLineInsert", { fg = '#03a9f4', bg = 'NONE' })
vim.api.nvim_set_hl(0, "StatusLineVisual", { fg = '#ff9800', bg = 'NONE' })
vim.api.nvim_set_hl(0, "StatusLineReplace", { fg = '#ff5722', bg = 'NONE' })
vim.api.nvim_set_hl(0, "StatusLineCommand", { fg = '#8eacbb', bg = 'NONE' })

vim.notify = require('notify')

vim.opt.secure = true
