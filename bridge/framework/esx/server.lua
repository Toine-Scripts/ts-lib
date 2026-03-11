-- ESX specific overrides for server bridge
if TS.FrameworkName ~= 'es_extended' then return end

local ESX = TS.FrameworkObject

TS.Bridge.HasPermission = function(source, permission)
    

    local xPlayer = ESX.GetPlayerFromId(source) 
    if not xPlayer then return false end

    return xPlayer.get(permission) or false
end

TS.Bridge.GetVehicleType = function(model)
    -- ESX does not have a native shared vehicles table easily accessible for types
    return 'automobile'
end

TS.Bridge.GetPlayers = function()
    local sources = {}

    if ESX and ESX.GetPlayers then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            sources[#sources + 1] = players[i]
        end
        return sources
    end

    local players = GetPlayers()
    for i = 1, #players do
        sources[#sources + 1] = tonumber(players[i]) or players[i]
    end

    return sources
end

