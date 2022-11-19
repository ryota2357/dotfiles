local save = {
    augroup = vim.api.nvim_create_augroup('vimrc', { clear = true }),
    two_cell_char = {}
}

---@param events string|table
---@return function
local function autocmd(events)
    ---@param opts table
    ---@return nil
    return function(opts)
        opts.group = opts.group or save.augroup
        vim.api.nvim_create_autocmd(events, opts)
    end
end


---@param char number
---@param apply? boolean
---@return nil
local function setcellwidths2(char, apply)
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

---@param hls table
---@return nil
local function hl_set(hls)
    for group, value in pairs(hls) do
        vim.api.nvim_set_hl(0, group, value)
    end
end

---@param links table
---@return nil
local function hl_link(links)
    for from, to in pairs(links) do
        vim.api.nvim_set_hl(0, from, {
            link = to,
        })
    end
end


return {
    autocmd = autocmd,
    setcellwidths2 = setcellwidths2,
    highlight = {
        set = hl_set,
        link = hl_link
    }
}
