Bridge.Garages.Server.Functions.SetVehicleOutsideState = function(plate, state)
    if not plate then return end

    local storedState = state and false or true

    local result = MySQL.update.await('UPDATE owned_vehicles SET `stored` = ? WHERE `plate` = ?', {
        storedState,
        plate
    })

    return result
end

Bridge.Garages.Server.Functions.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    local owner = MySQL.scalar.await('SELECT owner FROM owned_vehicles WHERE plate = ? LIMIT 1', { plate })
    return owner ~= nil
end

