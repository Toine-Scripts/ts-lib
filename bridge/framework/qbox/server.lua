if TS.Config.Framework ~= "qbox" then
    return
end

if not TS.Utils.IsRessourceLoaded("qbx_core") then
    TS.ErrorPrint("qbx_core is not loaded, please select the right framework in the config https://docs.toine.me/scripts/persistence#2-framework-support")
    return
end

TS.DebugPrint("qbx_core loaded successfully")

--- qbx_core server bridge
function TS.Bridge.HasPermission(source, permission)
    if IsPlayerAceAllowed(source, "group.admin") then return true end
    return false
end

function TS.Bridge.GetVehicleType(model)
    local vehicle = exports.qbx_core:GetVehiclesByName(model)

    if not vehicle then return 'automobile' end
    return vehicle.type or 'automobile' -- Default to automobile if not found, this is needed for the vehicle to be created server side
end


