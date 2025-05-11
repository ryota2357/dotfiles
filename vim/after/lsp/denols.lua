local root_pattern = require("lspconfig.util").root_pattern

---@type vim.lsp.Config
return {
    single_file_support = false,
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local deno_root = root_pattern("deno.json", "deno.jsonc", "denops")(fname)
        if deno_root then
            on_dir(deno_root)
            return
        end
        local other_root = root_pattern("package.json", "astro.config.mjs", "astro.config.ts")(fname)
        if other_root then
            return
        end
        on_dir(root_pattern(".")(fname))
    end,
    init_options = {
        enable = true,
        lint = true,
    },
    settings = {
        deno = {
            unstable = true,
        },
    },
}
