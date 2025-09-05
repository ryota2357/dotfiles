local M = {}

local api = vim.api
local fn = vim.fn
local opt = vim.opt
local keymap = vim.keymap

---@generic T
---@alias rc.select.Item { text: string, lower_text: string, raw: T, index: integer }
---@alias rc.select.ItemHighlight { start: integer, finish: integer }

local cache = {
    list_bufnr = nil, ---@type integer?
    input_bufnr = nil, ---@type integer?
    filtered = {}, ---@type table<string, [rc.select.Item[], rc.select.ItemHighlight[]]>
}

---@param name string
local function create_named_buf(name)
    local buf = fn.bufnr(name, true)
    api.nvim_buf_set_name(buf, name)
    api.nvim_set_option_value("filetype", name, { buf = buf })
    api.nvim_set_option_value("buftype", "nofile", { buf = buf })
    return buf
end

---@return integer
local function get_list_bufnr()
    if cache.list_bufnr ~= nil and fn.bufexists(cache.list_bufnr) then
        return cache.list_bufnr
    end
    local buf = create_named_buf("vim-ui-select")
    api.nvim_set_option_value("modifiable", false, { buf = buf })
    cache.list_bufnr = buf
    return buf
end

---@return integer
local function get_input_bufnr()
    if cache.input_bufnr ~= nil and fn.bufexists(cache.input_bufnr) then
        return cache.input_bufnr
    end
    local buf = create_named_buf("vim-ui-select-input")
    cache.input_bufnr = buf
    return buf
end

---@param bufnr integer
---@param config vim.api.keyset.win_config
local function open_and_enter_win(bufnr, config)
    local winid = fn.bufwinid(bufnr)
    if winid < 0 or api.nvim_win_is_valid(winid) then
        winid = api.nvim_open_win(bufnr, true, config)
    else
        fn.win_gotoid(winid)
    end
    local set_win_opt = function(name, value)
        api.nvim_set_option_value(name, value, { win = winid })
    end
    set_win_opt("number", false)
    set_win_opt("relativenumber", false)
    set_win_opt("wrap", false)
    set_win_opt("signcolumn", "no")
    set_win_opt("winhighlight", "Normal:NormalFloat,NormalNC:NormalFloat")
end

local lh_ns = api.nvim_create_namespace("vim-ui-select")

---@param items rc.select.Item[]
---@param highlights rc.select.ItemHighlight[]
local function draw_items(items, highlights)
    local buf = get_list_bufnr()
    api.nvim_set_option_value("modifiable", true, { buf = buf })
    for idx, item in ipairs(items) do
        fn.setbufline(buf, idx, item.text)
        if highlights[idx] ~= nil then
            local start_row = idx - 1
            local start_col = highlights[idx].start
            local end_row = idx - 1
            local end_col = highlights[idx].finish
            api.nvim_buf_set_extmark(buf, lh_ns, start_row, start_col, {
                hl_group = "Search",
                end_row = end_row,
                end_col = end_col,
                strict = false,
            })
        end
    end
    fn.deletebufline(buf, #items + 1, "$")
    api.nvim_set_option_value("modifiable", false, { buf = buf })
end

---@param items rc.select.Item[]
---@param query string
---@return rc.select.Item[], rc.select.ItemHighlight[]
local function filter_items(items, query)
    query = query:lower()

    local cached = cache.filtered[query]
    if cached ~= nil then
        return cached[1], cached[2]
    end

    local prev = cache.filtered[query:sub(1, #query - 1)]
    if prev ~= nil then
        items = prev[1]
    end

    local scored = {} ---@type [integer, [rc.select.Item, rc.select.ItemHighlight]][]
    for _, item in ipairs(items) do
        local start_pos, end_pos = item.lower_text:find(query, 1, true)
        if start_pos ~= nil then
            local score = math.max(200 - start_pos, 1)
            local highlight = { start = start_pos - 1, finish = end_pos }
            table.insert(scored, { score, { item, highlight } })
        end
    end
    table.sort(scored, function(a, b)
        return a[1] > b[1]
    end)

    local ret_items = {} ---@type rc.select.Item[]
    local ret_item_lhs = {} ---@type rc.select.ItemHighlight[]
    for _, value in ipairs(scored) do
        local item = value[2][1]
        local highlight = value[2][2]
        table.insert(ret_items, item)
        table.insert(ret_item_lhs, highlight)
    end
    cache.filtered[query] = { ret_items, ret_item_lhs }
    return ret_items, ret_item_lhs
end

---@param resize_height integer
---@return { row: integer, col: integer, height: integer, width: integer }
local function window_layout(resize_height)
    local round = function(x)
        return math.floor(x + 0.5)
    end
    local lines = opt.lines:get() - 2 -- 2 = statusline height + cmdline height
    local columns = opt.columns:get()

    local default_row_ratio = 0.15 -- 画面上部からの相対位置
    local max_height_ratio = 0.65 -- 最大高さの比率
    local vertical_bias = 0.4 -- 0.5=中央、0に近いほど上、1に近いほど下
    local layout = {
        row = round(lines * default_row_ratio),
        col = round(columns * 0.20),
        height = round(lines * max_height_ratio),
        width = round(columns * 0.60),
    }

    if resize_height < layout.height then
        -- リサイズ
        local free_space = layout.height - resize_height
        local vertical_adjustment = round(free_space * vertical_bias)
        layout.row = layout.row + vertical_adjustment
        layout.height = resize_height
    end

    return layout
end

---@generic T
---@param items T[]
---@param opts table<any, any>
---@param on_choice fun(item:T?, idx:number|nil)
---@return nil
function M.select(items, opts, on_choice)
    opts = opts or {}
    opts.format_item = opts.format_item or function(e)
        return tostring(e)
    end

    ---@type rc.select.Item[]
    local select_items = {}
    for idx, item in ipairs(items) do
        local text = opts.format_item(item)
        table.insert(select_items, {
            text = text,
            lower_text = text:lower(),
            raw = item,
            index = idx,
            score = 0,
        })
    end

    -- shallow copy
    local filtered_items = {}
    for _, item in ipairs(select_items) do
        table.insert(filtered_items, item)
    end
    cache.filtered = { [""] = { filtered_items, {} } }

    local filtered_item_lhs = {}
    draw_items(filtered_items, filtered_item_lhs)

    local win_layout = window_layout(#select_items)

    local list_buf = get_list_bufnr()
    open_and_enter_win(list_buf, {
        relative = "editor",
        row = win_layout.row,
        col = win_layout.col,
        height = win_layout.height,
        width = win_layout.width,
        focusable = true,
        border = "rounded",
        noautocmd = true,
    })

    local list_buf_keys = {}
    local nmap_list_buf = function(key, callback)
        keymap.set("n", key, callback, { buffer = list_buf })
        table.insert(list_buf_keys, key)
    end
    local close_list_window = function()
        for _, key in ipairs(list_buf_keys) do
            keymap.del("n", key, { buffer = list_buf })
        end
        local winid = fn.bufwinid(list_buf)
        if winid >= 0 then
            api.nvim_win_close(winid, false)
        end
    end
    local confirm_list_item = function()
        for _, key in ipairs(list_buf_keys) do
            keymap.del("n", key, { buffer = list_buf })
        end
        local winid = fn.bufwinid(list_buf)
        if winid >= 0 then
            local lnum = fn.getcurpos(winid)[2]
            api.nvim_win_close(winid, false)
            local selected = filtered_items[lnum]
            if selected ~= nil then
                on_choice(selected.raw, selected.index)
            end
        end
    end

    nmap_list_buf("<ESC>", close_list_window)
    nmap_list_buf("<CR>", confirm_list_item)
    nmap_list_buf("i", function()
        local input_buf = get_input_bufnr()
        open_and_enter_win(input_buf, {
            relative = "editor",
            row = win_layout.row - 2,
            col = win_layout.col,
            height = 1,
            width = win_layout.width,
            focusable = true,
            border = "rounded",
            noautocmd = true,
        })
        vim.cmd("startinsert!")

        local augroup = api.nvim_create_augroup("vim-ui-select-input", { clear = true })

        local input_buf_keys = {}
        local imap_list_buf = function(key, callback)
            keymap.set("i", key, callback, { buffer = input_buf })
            table.insert(input_buf_keys, key)
        end
        local close_filter_window = function()
            api.nvim_clear_autocmds({ group = augroup })
            for _, key in ipairs(input_buf_keys) do
                keymap.del("i", key, { buffer = input_buf })
            end
            -- NOTE: `fn.deletebufline(input_buf, 1, "$")` prints "No lines in buffer" message if the buffer is empty
            api.nvim_buf_set_lines(input_buf, 0, -1, false, {})
            local winid = fn.bufwinid(input_buf)
            if winid > 0 then
                fn.win_gotoid(winid)
                vim.cmd("stopinsert | close!")
            end
        end

        imap_list_buf("<CR>", function()
            close_filter_window()
            confirm_list_item()
        end)
        imap_list_buf("<ESC>", function()
            close_filter_window()
            close_list_window()
        end)
        imap_list_buf("<C-n>", function()
            local winid = fn.bufwinid(list_buf)
            if winid >= 0 then
                local lnum = fn.getcurpos(winid)[2]
                fn.win_execute(winid, "call cursor(" .. lnum + 1 .. ", 0) | redraw")
            end
        end)
        imap_list_buf("<C-p>", function()
            local winid = fn.bufwinid(list_buf)
            if winid >= 0 then
                local lnum = fn.getcurpos(winid)[2]
                fn.win_execute(winid, "call cursor(" .. lnum - 1 .. ", 0) | redraw")
            end
        end)

        api.nvim_create_autocmd("BufLeave", {
            buffer = input_buf,
            once = true,
            group = augroup,
            callback = close_filter_window,
        })
        api.nvim_create_autocmd("TextChangedI", {
            buffer = input_buf,
            group = augroup,
            callback = function()
                local winid = fn.bufwinid(input_buf)
                if winid >= 0 then
                    local lnum = fn.getcurpos(winid)[2]
                    local lines = fn.getbufline(input_buf, lnum)
                    local query
                    if #lines == 0 then
                        query = ""
                    else
                        query = lines[1]
                    end
                    filtered_items, filtered_item_lhs = filter_items(select_items, query)
                    draw_items(filtered_items, filtered_item_lhs)
                end
            end,
        })
    end)
end

setmetatable(M, {
    ---@param items table<any>
    ---@param opts table<any, any>
    ---@param on_choice fun(item:table<string>|nil, idx:number|nil)
    __call = function(_, items, opts, on_choice)
        if vim.in_fast_event() then
            vim.schedule(function()
                M.select(items, opts, on_choice)
            end)
        else
            M.select(items, opts, on_choice)
        end
    end,
})

return M
