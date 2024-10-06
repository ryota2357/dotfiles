local M = {}

local api = vim.api
local cache_bufnr = nil

require("rcutil.highlight").set {
    InputFloatBorder = { fg = "#006db3" },
    InputFloatTitle = { fg = "#6ab7ff" },
    InputPrompt = { fg = "#5c6370" },
}

vim.fn.sign_define("InputPrompt", {
    text = "❯",
    texthl = "InputPrompt",
})

---@return number
local function get_buffer()
    if cache_bufnr ~= nil and vim.fn.bufexists(cache_bufnr) then
        return cache_bufnr
    end
    local buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_name(buf, "vim-ui-input")
    api.nvim_set_option_value("filetype", "vim-ui-input", { buf = buf })
    cache_bufnr = buf
    return buf
end

---@param buffer number
---@param title? string|table<table<string>>
---@return number
local function open_window(buffer, title)
    if title ~= nil and type(title) == "string" then
        title = { { title, "InputFloatTitle" } }
    end
    local win = api.nvim_open_win(buffer, true, {
        relative = "cursor",
        row = 1,
        col = 1,
        width = 40,
        height = 1,
        focusable = true,
        border = "rounded",
        title = title,
        title_pos = "left",
        noautocmd = true,
    })
    api.nvim_set_option_value("number", false, { win = win })
    api.nvim_set_option_value("relativenumber", false, { win = win })
    api.nvim_set_option_value("wrap", false, { win = win })
    api.nvim_set_option_value("cursorline", false, { win = win })
    api.nvim_set_option_value("winhighlight", "FloatBorder:InputFloatBorder,NormalFloat:Normal", { win = win })
    vim.fn.sign_place(1, "", "InputPrompt", buffer, { lnum = vim.fn.line(".") })
    return win
end

---@param opts table<string, any>
---@param on_confirm fun(input?:any):nil
function M.input(opts, on_confirm)
    opts = vim.F.if_nil(opts, {})
    on_confirm = vim.F.if_nil(on_confirm, function(i)
        print(i)
    end)

    local default = opts.default
    local prompt = opts.prompt

    local buffer = get_buffer()
    if default ~= nil then
        api.nvim_buf_set_lines(buffer, 0, 1, true, { default })
    end

    if prompt ~= nil and type(prompt) == "string" then
        if prompt[1] ~= " " then
            prompt = " " .. prompt
        end
        if string.sub(prompt, #prompt - 1) == ": " then
            prompt = string.sub(prompt, 1, #prompt - 2)
        end
        if prompt[#prompt] ~= " " then
            prompt = prompt .. " "
        end
    end
    local window = open_window(buffer, prompt)
    vim.cmd("startinsert!")

    vim.keymap.set("i", "<ESC>", function()
        vim.cmd("stopinsert")
        api.nvim_win_close(window, false)
    end, { buffer = buffer })
    vim.keymap.set("i", "<CR>", function()
        vim.cmd("stopinsert")
        local input = vim.fn.getline(".")
        api.nvim_win_close(window, false)
        on_confirm(input)
    end, { buffer = buffer })
end

setmetatable(M, {
    ---@param opts table<string, any>
    ---@param on_confirm fun(input?:any):nil
    __call = function(_, opts, on_confirm)
        if vim.in_fast_event() then
            vim.schedule(function()
                M.input(opts, on_confirm)
            end)
        else
            M.input(opts, on_confirm)
        end
    end,
})

return M
