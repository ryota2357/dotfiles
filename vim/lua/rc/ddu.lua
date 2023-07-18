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
    vim.keymap.set(mode, key, function()
        vim.fn['ddu#start'](config)
    end)
end

---@param command string
---@param config table
---@return nil
function M.start.command(command, config)
    fix_config_sources(config)
    vim.api.nvim_create_user_command(command, function()
        vim.fn['ddu#start'](config)
    end, {})
end

local set_fn_metatable = require('rc.util').set_fn_metatable
M.ui = set_fn_metatable('ddu#ui#')
M.custom = set_fn_metatable('ddu#custom#')

return M
