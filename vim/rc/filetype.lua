local autocmd = require('rc.util').autocmd
vim.g.tex_flavor = 'latex'

for filetype, config in pairs({
    tex = {
        indentwidth = 2,
        sidescrolloff = 10,
        foldmarker = { '!!!>', '<!!!' },
        autocmd = {{
            event = 'BufWritePre',
            pattern = '*.tex',
            command = [[
                let pos = getpos('.')
                silent! execute ':%s/。/. /g'
                silent! execute ':%s/、/, /g'
                silent! execute ':%s/\\\@<!\s\+$//'
                call setpos('.', pos)
            ]]
        }}
    },
    typescript = {
        indentwidth = 2
    },
    dart = {
        indentwidth = 2
    },
    json = {
        indentwidth = 2
    },
    help = {
        list = false,
        expandtab = false,
        indentwidth = 8
    }
}) do
    autocmd 'FileType' {
        pattern = filetype,
        callback = function()
            local indentwidth = config.indentwidth
            config.indentwidth = nil
            if indentwidth then
                vim.opt_local.tabstop = indentwidth
                vim.opt_local.softtabstop = indentwidth
                vim.opt_local.shiftwidth = indentwidth
            end

            local cmds = config.autocmd
            config.autocmd = nil
            if cmds then
                for _, cmd in ipairs(cmds) do
                    local event = cmd.event
                    cmd.event = nil
                    autocmd(event)(cmd)
                end
            end

            for name, value in pairs(config) do
                vim.opt_local[name] = value
            end
        end
    }
end
