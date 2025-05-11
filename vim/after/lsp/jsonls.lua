local json_schemas = nil
local ok, schemastore = pcall(require, "schemastore")
if ok then
    json_schemas = schemastore.json.schemas()
end

---@type vim.lsp.Config
return {
    settings = {
        json = {
            validate = { enable = true },
            schemas = json_schemas,
        },
    },
}
