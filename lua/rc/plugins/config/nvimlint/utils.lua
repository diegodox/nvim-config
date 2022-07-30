local M = {}

---@param name string
---@return number?
function M.get_namespace_by_name(name)
    local nss = vim.diagnostic.get_namespaces()
    for key, ns in pairs(nss or {}) do
        if ns and ns.name == name then
            assert(type(key) == "number")
            return key
        end
    end
end

return M
