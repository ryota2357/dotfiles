local M = {}

local save = {
    augroup = vim.api.nvim_create_augroup('vimrc', { clear = true }),
    two_cell_char = {}
}

---@param events string|string[]
---@return fun(opts:table<string, any>):nil
function M.autocmd(events)
    ---@param opts table<string, any>
    ---@return nil
    return function(opts)
        opts.group = opts.group or save.augroup
        vim.api.nvim_create_autocmd(events, opts)
    end
end


---@param char number
---@param apply? boolean
---@return nil
function M.setcellwidths2(char, apply)
    if char == nil then
        save.two_cell_char = {}
        return
    end
    apply = apply or true
    if char ~= {} then
        if type(char) == "number" then
            table.insert(save.two_cell_char, { char, char, 2 });
        elseif type(char) == "table" then
            for _, c in ipairs(char) do
                table.insert(save.two_cell_char, { c, c, 2 });
            end
        end
    end
    if apply then
        vim.fn.setcellwidths(save.two_cell_char)
    end
end

M.highlight = {}

---@param hls table
---@return nil
function M.highlight.set(hls)
    for group, value in pairs(hls) do
        vim.api.nvim_set_hl(0, group, value)
    end
end

---@param links table
---@return nil
function M.highlight.link(links)
    for from, to in pairs(links) do
        vim.api.nvim_set_hl(0, from, {
            link = to,
        })
    end
end

return M
