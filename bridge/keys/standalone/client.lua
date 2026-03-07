if TS.Config.KeysSystem ~= "standalone" then
    return
end

TS.DebugPrint("standalone keys system loaded successfully")

--- Standalone client bridge
function TS.Bridge.Keys.SetDoorStatus(entity, lockStatus)
    local isLocked = (lockStatus ~= 1 and lockStatus ~= 0)
    Entity(entity).state:set('isLocked', isLocked, true)
    SetVehicleDoorsLocked(entity, lockStatus)

    if lockStatus == 2 or lockStatus == 4 then
        SetVehicleDoorsLockedForAllPlayers(entity, true)
    else
        SetVehicleDoorsLockedForAllPlayers(entity, false)
    end
end
