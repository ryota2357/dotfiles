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

vim.notify = require('notify')

vim.opt.secure = true
