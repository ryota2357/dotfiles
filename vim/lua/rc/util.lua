local M = {}

local vimrc_augroup = vim.api.nvim_create_augroup('vimrc', { clear = true })

---@param events string|string[]
---@return fun(opts:table<string, any>):nil
function M.autocmd(events)
    ---@param opts table<string, any>
    ---@return nil
    return function(opts)
        opts.group = vim.F.if_nil(opts.group, vimrc_augroup)
        vim.api.nvim_create_autocmd(events, opts)
    end
end

---@param table table
---@param keys string[]
---@param default? any
---@return any
function M.tbl_get(table, keys, default)
    default = vim.F.if_nil(default, nil)
    local result = table
    for _, key in ipairs(keys) do
        if result == nil then
            return default
        end
        result = result[key]
    end
    return vim.F.if_nil(result, default)
end

---@param prefix string
---@param table? table
---@return table
function M.set_fn_metatable(prefix, table)
    return setmetatable(table or {}, {
        __index = function(_, key)
            return function(...)
                return vim.fn[prefix .. key](...)
            end
        end
    })
end

local arch = nil

function M.if_arch(cond)
    if arch == nil then
        local res = vim.system({"uname", "-m"}, { text = true }):wait()
        if res.code == 0 and res.signal == 0 and res.stderr == "" then
            arch = vim.fn.substitute(res.stdout, "\n", "", "")
        else
            error(vim.inspect(res))
        end
    end
    local ret = cond[arch]
    if ret == nil then
        error("Unknown arch: " .. arch)
    end
    return ret
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
