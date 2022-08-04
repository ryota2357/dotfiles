vim.opt.runtimepath:prepend(vim.fn.fnamemodify('~/Projects/VimPlugin/dein-snip.lua', ':p'))

vim.cmd([[
    let mapleader = "\<Space>"
    let g:do_filetype_lua = 1
    let g:did_load_filetypes = 0
]])

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
            { '~/dotfiles/vim/rc/filetype.toml' }
        }
    },
    notification = {
        enable = true,
        time = 3000
    },
    install = {
        progress_type = 'floating',
        max_processes = 1 -- 時間かかるけど、エラーは出なくなる
    },
    auto_recache = true
}

vim.o.secure = true
