-- QBCore specific overrides for server bridge
if TS.FrameworkName ~= 'qb-core' then return end

local QBCore = TS.FrameworkObject

TS.Bridge.HasPermission = function(source, permission)
    if IsPlayerAceAllowed(source, permission) then return true end
    
    if QBCore and QBCore.Functions.HasPermission(source, permission) then return true end
    return false
end

TS.Bridge.GetVehicleType = function(model)
    if not QBCore or not QBCore.Shared.Vehicles[model] then return 'automobile' end
    return QBCore.Shared.Vehicles[model].type or 'automobile'
end
