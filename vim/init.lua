local dein_snip = vim.fn.fnamemodify('~/.cache/dein/repos/github.com/ryota2357/dein-snip.lua', ':p')
-- local dein_snip = vim.fn.fnamemodify('~/Projects/VimPlugin/dein-snip.lua', ':p')
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
    val = {
        two_cell_char = {},
        custom_hls = {}
    },
    fn = {}
}

function Config.fn.setcellwidths2(char, apply)
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

function Config.fn.modified_bg_bufs()
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

function Config.fn.table_insert_pairs(dict, source)
    if source == nil then return end
    for key, value in pairs(source) do
        if dict[key] ~= nil then
            error('Invalid key: `' .. tostring(key) .. '`, already defined.', 2)
        end
        dict[key] = value
    end
end

function Config.fn.statusline()
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
            local mark = vim.o.modified and '' or ''
            local bg_modifed_cnt = #Config.fn.modified_bg_bufs()
            if bg_modifed_cnt ~= 0 then
                mark = mark .. ' ( ' .. tostring(bg_modifed_cnt) .. ')'
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

Config.fn.table_insert_pairs(
    Config.val.custom_hls,
    {
        StatusLine = { link = 'Normal' },
        StatusLineNormal = { fg = '#4caf50', bg = 'NONE' },
        StatusLineInsert = { fg = '#03a9f4', bg = 'NONE' },
        StatusLineVisual = { fg = '#ff9800', bg = 'NONE' },
        StatusLineReplace = { fg = '#ff5722', bg = 'NONE' },
        StatusLineCommand = { fg = '#8eacbb', bg = 'NONE' },
    }
)

function Config.fn.tabline()
    local s = ''
    for i = 1, vim.fn.tabpagenr('$') do
        local current = i == vim.fn.tabpagenr()
        local hl = current and '%#TabLineSel#' or '%#TabLine#'
        local id = '%' .. tostring(i) .. 'T'
        local label = (function()
            local buflist = vim.fn.tabpagebuflist(i)
            local winnr = vim.fn.tabpagewinnr(i)
            local name = vim.fn.bufname(buflist[winnr])
            local count = ''
            if not current then
                count = #buflist == 1 and '' or ' (' .. #buflist .. ')'
            end
            return ' ' .. vim.fn.fnamemodify(name, ':t') .. count .. ' '
        end)()
        s = s .. hl .. id .. label
    end
    return s .. '%#TabLineFill#%T'
end

Config.fn.table_insert_pairs(
    Config.val.custom_hls,
    {
        TabLine = { fg = '#707070', bg = '#202020' },
        TabLineSel = { link = 'Normal' },
        TabLineFill = { fg = 'NONE', bg = '#000000' }
    }
)

require('dein-snip').setup {
    load = {
        vim = {
            '~/dotfiles/vim/rc/maping.rc.vim',
            '~/dotfiles/vim/rc/option.rc.vim',
        },
        toml = {
            '~/dotfiles/vim/rc/dein.toml',
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

for hl, value in pairs(Config.val.custom_hls) do
    vim.api.nvim_set_hl(0, hl, value)
end

-- LuaCacheClear / LuaCacheLog / LuaCacheProfile
require('impatient')

vim.notify = require('notify')

vim.o.secure = true
