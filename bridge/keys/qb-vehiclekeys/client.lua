if TS.Config.KeysSystem ~= "qb-vehiclekeys" then
    return
end

if not TS.Utils.IsRessourceLoaded("qb-vehiclekeys") then
    TS.ErrorPrint("qb-vehiclekeys is not loaded, please select the right keys system in the config https://docs.toine.me/scripts/persistence/keys")
    return
end

TS.DebugPrint("qb-vehiclekeys loaded successfully")

--- QS-vehiclekeys client bridge
function TS.Bridge.Keys.SetDoorStatus(entity, status)
    TriggerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(entity), status)
end
