-- ESX specific overrides for server bridge
if TS.FrameworkName ~= 'es_extended' then return end

TS.Bridge.HasPermission = function(source, permission)
    -- ESX usually relies on ACE perms or group checks
    -- Assuming a basic ACE check as per original ts-persistence logic
    if IsPlayerAceAllowed(source, permission) or IsPlayerAceAllowed(source, "admin") then return true end
    
    -- Could add ESX group checking here if needed:
    -- local xPlayer = TS.FrameworkObject.GetPlayerFromId(source)
    -- if xPlayer and (xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'superadmin') then return true end

    return false
end

TS.Bridge.GetVehicleType = function(model)
    -- ESX does not have a native shared vehicles table easily accessible for types
    return 'automobile' 
end
