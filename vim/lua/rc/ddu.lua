local M = {}

---@param config table
---@return nil
local function fix_config_sources(config)
    for lua_key, source_name in pairs(config.sources or {}) do
        config.sources[lua_key] = { name = source_name }
    end
end

M.start = {}

---@param mode string
---@param key string
---@param config table
---@return nil
function M.start.keymap(mode, key, config)
    fix_config_sources(config)
    local callback = function()
        vim.fn["ddu#start"](config)
    end
    vim.keymap.set(mode, key, callback)
end

---@param command string
---@param config table
---@return nil
function M.start.command(command, config)
    fix_config_sources(config)
    local callback = function()
        vim.fn["ddu#start"](config)
    end
    vim.api.nvim_create_user_command(command, callback, {})
end

M.ui = setmetatable({}, {
    __index = function(_, key)
        return function(...)
            return vim.fn["ddu#ui#" .. key](...)
        end
    end,
})
M.custom = setmetatable({}, {
    __index = function(_, key)
        return function(...)
            return vim.fn["ddu#custom#" .. key](...)
        end
    end,
})

return M
