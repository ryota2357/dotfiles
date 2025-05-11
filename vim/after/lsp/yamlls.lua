local yaml_schemas = nil
local ok, schemastore = pcall(require, "schemastore")
if ok then
    yaml_schemas = schemastore.yaml.schemas()
end

---@type vim.lsp.Config
return {
    settings = {
        yaml = {
            keyOrdering = false,
            schemaStore = {
                enable = false,
                url = "", -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
            },
            schemas = yaml_schemas,
        },
    },
}
