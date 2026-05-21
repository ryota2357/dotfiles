---@type vim.lsp.Config
return {
    cmd = { "astro-ls", "--stdio" },
    filetypes = { "astro", "typescript", "javascript" },
    root_markers = { "astro.config.mjs", "astro.config.ts" },
}
