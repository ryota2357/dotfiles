local M = {}

---@param hls table<string, vim.api.keyset.highlight>
---@return nil
function M.set(hls)
    for group, value in pairs(hls) do
        vim.api.nvim_set_hl(0, group, value)
    end
end

---@param links table<string, string>
---@return nil
function M.link(links)
    for from, to in pairs(links) do
        vim.api.nvim_set_hl(0, from, {
            link = to,
        })
    end
end

return M
