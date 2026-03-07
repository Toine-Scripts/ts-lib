if TS.Config.Garage ~= "esx_garage" then
    return
end

if not TS.Utils.IsRessourceLoaded("esx_garage") then
    TS.ErrorPrint("esx_garage is not loaded, please select the right keys system in the config")
    return
end

TS.DebugPrint("esx_garage loaded successfully")

TS.Bridge.Garage.SetVehicleOutsideState = function(plate, state)
    if not plate then return end

    local storedState = state and false or true

    local result = MySQL.update.await('UPDATE owned_vehicles SET `stored` = ? WHERE `plate` = ?', {
        storedState,
        plate
    })

    return result
end

TS.Bridge.Garage.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    local owner = MySQL.scalar.await('SELECT owner FROM owned_vehicles WHERE plate = ? LIMIT 1', { plate })
    return owner ~= nil
end
