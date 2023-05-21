local M = {}
local set_fn_metatable = require('rc.util').set_fn_metatable

local source_options = {}

---@param name string
---@param config any
---@return nil
function M.set_source_options(name, config)
    source_options[name] = config
end

---@return table
function M.get_source_options()
    return source_options
end

---@param opts table
---@return nil
function M.enable(opts)
    vim.fn["ddc#enable"](vim.F.if_nil(opts, {}))
end

---@param map_key string
---@param config_fn fun(cmap: fun(lhs: string|string[], rhs: function), pum: table)
---@return nil
function M.enable_cmdline_completion_with(map_key, config_fn)
    local cmap_config = {}
    local cmap = function(lhs, rhs)
        if type(lhs) == 'table' then
            for _, v in ipairs(lhs) do
                cmap_config[v] = rhs
            end
        else
            cmap_config[lhs] = rhs
        end
    end
    local pum = set_fn_metatable('pum#', {
        map = set_fn_metatable('pum#map#')
    })

    config_fn(cmap, pum)

    vim.keymap.set('n', map_key, function()
        if require('dein').tap('pum.vim') == 0 then
            return map_key
        end
        for lhs, rhs in pairs(cmap_config) do
            vim.keymap.set('c', lhs, rhs, { expr = true })
        end
        require('rc.util').autocmd 'User' {
            pattern = 'DDCCmdlineLeave',
            once = true,
            callback = function()
                for lhs, _ in pairs(cmap_config) do
                    vim.keymap.del('c', lhs)
                end
                return true
            end
        }
        vim.fn["ddc#enable_cmdline_completion"]()
        return map_key
    end, { expr = true })
end

M.custom = set_fn_metatable('ddc#custom#')
M.map = set_fn_metatable('ddc#map#')

return M
