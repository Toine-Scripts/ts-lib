Utils = Utils or {}

local function GetTsLibResourceName()
    if TS_LIB_RESOURCE_NAME ~= nil then
        return TS_LIB_RESOURCE_NAME
    end
    return GetCurrentResourceName()
end

Utils.LoadFile = function(path)
    local file = LoadResourceFile(GetTsLibResourceName(), path)
    if file then
        assert(load(file, "@"..path))()
        return true
    end
    return false
end