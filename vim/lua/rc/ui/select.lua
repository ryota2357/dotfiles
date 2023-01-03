local M = {}
local save_on_choice = nil

---@param items table<any>
---@param opts table<any, any>
---@param on_choice function
---@return nil
function M.select(items, opts, on_choice)
    opts.format_item = opts.format_item or function(e) return tostring(e) end
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
    save_on_choice(item, index)
    save_on_choice = nil
end

setmetatable(M, {
    __call = function(_, item, opts, on_choice)
        if vim.in_fast_event() then
            vim.schedule(function ()
                M.select(item, opts, on_choice)
            end)
        else
            M.select(item, opts, on_choice)
        end
    end
})

return M
