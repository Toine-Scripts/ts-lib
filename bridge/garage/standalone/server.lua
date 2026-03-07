if TS.Config.Garage ~= "standalone" then
    return
end



TS.DebugPrint("standalone bridge loaded")

TS.Bridge.Garage.SetVehicleOutsideState = function(plate, state)
    if not plate then return end
    return true
end

TS.Bridge.Garage.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    if not plate or not netId then return false end
    
    local entity = NetworkGetEntityFromNetworkId(netId)
    if not entity then return false end
    
    local owned = Entity(entity).state.owned
    if not owned then return false end
    
    return owned
end
