local M = {}

setmetatable(M, {
    __index = function(self, key)
        local err, data = pcall(require, "vimrc." .. key)
        if err then
            error("Module `vimrc." .. key .. "` not found")
        else
            rawset(self, key, data)
            return data
        end

    end
})

return M
