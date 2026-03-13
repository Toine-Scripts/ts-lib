local tableName = (Config.Framework == "qbcore" or Config.Framework == "qbox") and "player_vehicles" or "owned_vehicles"
local ownerCol = (Config.Framework == "qbcore" or Config.Framework == "qbox") and "citizenid" or "owner"

Bridge.Garages.Server.Functions.SetVehicleOutsideState = function(plate, state)
    if not plate then return end

    if state then
        local result = MySQL.update.await('UPDATE '..tableName..' SET garage = NULL, garageSpotID = NULL, parking_date = NULL WHERE plate = ?', {
            plate
        })
        return result
    end
end

Bridge.Garages.Server.Functions.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    local owner = MySQL.scalar.await('SELECT '..ownerCol..' FROM '..tableName..' WHERE plate = ? LIMIT 1', { plate })
    return owner ~= nil
end

