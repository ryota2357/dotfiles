local M = {}

---@param source string
---@param config_fn fun(ctx: { lines: integer, columns: integer }):table
---@return nil
local function ddu_start(source, config_fn)
    local config = config_fn({
        lines = vim.opt.lines:get(),
        columns = vim.opt.columns:get()
    })
    config.name = source
    config.sources = { { name = source } }
    vim.fn["ddu#start"](config)
end

M.start = {}

---@param mode string
---@param key string
---@param source string
---@param config_fn fun(ctx: { lines: integer, columns: integer }):table
---@return nil
function M.start.keymap(mode, key, source, config_fn)
    vim.keymap.set(mode, key, function()
        ddu_start(source, config_fn)
    end)
end

---@param command string
---@param source string
---@param config_fn fun(ctx: { lines: integer, columns: integer }):table
---@return nil
function M.start.command(command, source, config_fn)
    vim.api.nvim_create_user_command(command, function()
        ddu_start(source, config_fn)
    end, {})
end

---@param lhs string
---@param rhs string|function
---@return nil
function M.nmap(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { buffer = true })
end

---@param lhs string
---@param rhs string|function
---@return nil
function M.imap(lhs, rhs)
    vim.keymap.set('i', lhs, rhs, { buffer = true })
end

local set_fn_metatable = require('rc.util').set_fn_metatable
M.ui = set_fn_metatable('ddu#ui#')
M.custom = set_fn_metatable('ddu#custom#')

return M
