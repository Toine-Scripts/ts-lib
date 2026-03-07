if TS.Config.Garage ~= "qb-garages" then
    return
end

if not TS.Utils.IsRessourceLoaded("qb-garages") then
    TS.ErrorPrint("qb-garages is not loaded.")
    return
end

TS.DebugPrint("qb-garages bridge loaded")

TS.Bridge.Garage.SetVehicleOutsideState = function(plate, state)
    if not plate then return end
    
    local storedState = state and 0 or 1

    local result = MySQL.update.await('UPDATE player_vehicles SET state = ? WHERE plate = ?', {
        storedState,
        plate
    })

    TriggerEvent('qb-garages:server:UpdateOutsideVehicle', plate, nil)

    return result
end

TS.Bridge.Garage.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    local owner = MySQL.scalar.await('SELECT citizenid FROM player_vehicles WHERE plate = ? LIMIT 1', { plate })
    return owner ~= nil
end
