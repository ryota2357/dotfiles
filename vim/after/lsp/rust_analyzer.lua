---@type vim.lsp.Config
return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                features = "all",
                command = "clippy",
            },
        },
    },
}
