local tableName = (Config.Framework == "qbcore" or Config.Framework == "qbox") and "player_vehicles" or "owned_vehicles"
local ownerCol = (Config.Framework == "qbcore" or Config.Framework == "qbox") and "citizenid" or "owner"

Bridge.Garages.Server.Functions.SetVehicleOutsideState = function(plate, state)
    if not plate then return end
    local storedState = state and 0 or 1

    local result = MySQL.update.await('UPDATE '..tableName..' SET in_garage = ? WHERE plate = ?', {
        storedState,
        plate
    })

    return result
end

Bridge.Garages.Server.Functions.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    local owner = MySQL.scalar.await('SELECT '..ownerCol..' FROM '..tableName..' WHERE plate = ? LIMIT 1', { plate })
    return owner ~= nil
end

