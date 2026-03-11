-- QBCore specific overrides for server bridge
if TS.FrameworkName ~= 'qb-core' then return end

local QBCore = TS.FrameworkObject

TS.Bridge.HasPermission = function(source, permission)
    if not QBCore then return false end
    
    if IsPlayerAceAllowed(source, 'qbcore.god') then return true end
    if QBCore.Functions.HasPermission(source, permission) then return true end

    return false
end

TS.Bridge.GetVehicleType = function(model)
    if not QBCore or not QBCore.Shared.Vehicles[model] then return 'automobile' end
    return QBCore.Shared.Vehicles[model].type or 'automobile'
end

TS.Bridge.GetPlayers = function()
    return QBCore.Functions.GetPlayers()
end