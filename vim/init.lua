vim.loader.enable()

local dein_snip = vim.fn.fnamemodify('~/.cache/dein/repos/github.com/ryota2357/dein-snip.lua', ':p')
-- local dein_snip = vim.fn.fnamemodify('~/Projects/VimPlugin/dein-snip.lua', ':p')
if not string.match(vim.o.runtimepath, '/dein-snip.lua') then
    if vim.fn.isdirectory(dein_snip) == 0 then
        os.execute('git clone https://github.com/ryota2357/dein-snip.lua.git ' .. dein_snip)
    end
    vim.opt.runtimepath:prepend(dein_snip)
end

require('dein-snip').setup {
    load = {
        vim = {
            '~/dotfiles/vim/rc/mapping.rc.vim',
            '~/dotfiles/vim/rc/option.rc.vim',
        },
        toml = {
            '~/dotfiles/vim/rc/dein.toml',
            '~/dotfiles/vim/rc/filetype.toml',
            { '~/dotfiles/vim/rc/dein-lazy.toml', { lazy = true } },
            { '~/dotfiles/vim/rc/ddc.toml',       { lazy = true } },
            { '~/dotfiles/vim/rc/ddu.toml',       { lazy = true } },
            { '~/dotfiles/vim/rc/dap.toml',       { lazy = true } },
            { '~/dotfiles/vim/rc/lsp.toml',       { lazy = true } },
        }
    },
    notification = {
        enable = true,
        time = 3000
    },
    install = {
        progress_type = 'floating',
        max_processes = 2,
        git = {
            partial_clone = true
        }
    },
    auto_recache = true
}

-- vim.cmd [[
--   execute 'luafile ' .. expand('~/Projects/CSharp/necodark/build/nvim/colors/necodark.lua')
-- ]]

Statusline = require('rc.ui.statusline')
vim.api.nvim_set_option('statusline', '%!v:lua.Statusline()')

Tabline = require('rc.ui.tabline')
vim.api.nvim_set_option('tabline', '%!v:lua.Tabline()')

vim.ui = {
    select = function(...)
        vim.ui.select = require('rc.ui.select')
        vim.ui.select(...)
    end,
    input = function(...)
        vim.ui.input = require('rc.ui.input')
        vim.ui.input(...)
    end
}

require('rc.autocmd')

vim.opt.secure = true
