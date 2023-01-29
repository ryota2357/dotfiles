-- 参考: matsui54/ddu-vim-ui-select (https://github.com/matsui54/ddu-vim-ui-select/blob/main/lua/ddu-vim-ui-select/init.lua)

local M = {}
local save_on_choice = nil

---@param items table<any>
---@param opts table<any, any>
---@param on_choice fun(item:table<string>|nil, idx:number|nil)
---@return nil
function M.select(items, opts, on_choice)
    opts = opts or {}
    opts.format_item = vim.F.if_nil(opts.format_item, function(e) return tostring(e) end)
    save_on_choice = on_choice

    local indexed_items = {}
    for index, item in ipairs(items) do
        local text = opts.format_item(item)
        table.insert(indexed_items, { index = index, raw = item, text = text })
    end
    print("called 1")

    vim.fn['ddu#start'] {
        ui = 'ff',
        sources = { {
            name = 'ui_select',
            params = { items = indexed_items, }
        } },
        uiParams = {
            ff = {
                startFilter = false,
                autoResize = true,
            }
        },
        kindOptions = {
            ui_select = {
                defaultAction = 'select'
            }
        }
    }
end

---@param item? any
---@param index? number
function M.on_choice(item, index)
    if save_on_choice == nil then
        return
    end
    local on_choice = save_on_choice
    save_on_choice = nil
    on_choice(item, index)
end

setmetatable(M, {
    ---@param items table<any>
    ---@param opts table<any, any>
    ---@param on_choice fun(item:table<string>|nil, idx:number|nil)
    __call = function(_, items, opts, on_choice)
        if vim.in_fast_event() then
            vim.schedule(function ()
                M.select(items, opts, on_choice)
            end)
        else
            M.select(items, opts, on_choice)
        end
    end
})

return M
