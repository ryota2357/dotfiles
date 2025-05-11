local root_pattern = require("lspconfig.util").root_pattern

---@type vim.lsp.Config
return {
    single_file_support = false,
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local node_root = root_pattern("package.json")(fname)
        local other_root = root_pattern("deno.json", "astro.config.mjs", "astro.config.ts")(fname)
        if node_root and other_root ~= nil then
            on_dir(fname)
            return
        end
    end,
}
