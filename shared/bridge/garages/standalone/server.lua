Bridge.Garages.Server.Functions.SetVehicleOutsideState = function(plate, state)
    if not plate then return end
    return true
end

Bridge.Garages.Server.Functions.IsVehicleOwned = function(plate, netId)
    if not plate or not netId then return false end

    local entity = NetworkGetEntityFromNetworkId(netId)
    if not entity then return false end

    local owned = Entity(entity).state.owned
    if not owned then return false end

    return owned
end

