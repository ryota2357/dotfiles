local M = {}

local vimrc_augroup = vim.api.nvim_create_augroup("vimrc", { clear = true })

---@param events string|string[]
---@return fun(ops: vim.api.keyset.create_autocmd):nil
function M.autocmd(events)
    ---@param opts table<string, any>
    ---@return nil
    return function(opts)
        if opts.group == nil then
            opts.group = vimrc_augroup
        end
        vim.api.nvim_create_autocmd(events, opts)
    end
end

setmetatable(M, {
    __call = function(_, events)
        return M.autocmd(events)
    end,
})

return M --[[@as fun(events:string|string[]):fun(ops:vim.api.keyset.create_autocmd):nil]]
