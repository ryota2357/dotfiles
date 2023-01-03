local M = {}

local fn = vim.fn
local util = require('rc.util')

function M.setup()
    util.highlight.set {
        TabLine = { fg = '#707070', bg = '#202020' },
        TabLineFill = { fg = 'NONE', bg = '#000000' }
    }
    -- util.highlight.link { TabLineSel = 'Normal' }
end

---@return string
function M.tabline()
    local s = ''
    for i = 1, fn.tabpagenr('$') do
        local current = i == fn.tabpagenr()
        local hl = current and '%#TabLineSel#' or '%#TabLine#'
        local id = '%' .. tostring(i) .. 'T'
        local label = (function()
            local buflist = fn.tabpagebuflist(i)
            local winnr = fn.tabpagewinnr(i)
            local name = fn.bufname(buflist[winnr])
            local count = ''
            if not current then
                count = #buflist == 1 and '' or ' (' .. #buflist .. ')'
            end
            return ' ' .. fn.fnamemodify(name, ':t') .. count .. ' '
        end)()
        s = s .. hl .. id .. label
    end
    return s .. '%#TabLineFill#%T'
end

setmetatable(M, {
    __call = function()
        return M.tabline()
    end
})

return M
