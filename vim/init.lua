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

local ui = require('rc.ui')
Statusline = ui.statusline()
Tabline = ui.tabline()
vim.api.nvim_set_option('statusline', '%!v:lua.Statusline()')
vim.api.nvim_set_option('tabline', '%!v:lua.Tabline()')

require('rc.autocmd')
require('rc.filetype')

vim.notify = require('notify')

vim.opt.secure = true
