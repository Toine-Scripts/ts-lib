if TS.Config.KeysSystem ~= "qs-vehiclekeys" then
    return
end

if not TS.Utils.IsRessourceLoaded("qs-vehiclekeys") then
    TS.ErrorPrint("qs-vehiclekeys is not loaded, please select the right keys system in the config https://docs.toine.me/scripts/persistence/keys")
    return
end

TS.DebugPrint("qs-vehiclekeys loaded successfully")

--- qs-vehiclekeys client bridge
function TS.Bridge.Keys.SetDoorStatus(entity, status)
    exports["qs-vehiclekeys"]:DoorLogic(entity, true, status, true, true, true)
end
