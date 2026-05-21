---@type vim.lsp.Config
return {
    cmd = { "tailwindcss-language-server", "--stdio" },
    filetypes = { "astro", "css", "scss", "javascriptreact", "typescriptreact" },
}
