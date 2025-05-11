---@type vim.lsp.Config
return {
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("lua", true) },
            telemetry = { enable = false },
        },
    },
}
