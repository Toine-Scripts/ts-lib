if TS.Config.Garage ~= "jg-advancedgarages" then
    return
end

if not TS.Utils.IsRessourceLoaded("jg-advancedgarages") then
    TS.ErrorPrint("jg-advancedgarages is not loaded.")
    return
end

TS.DebugPrint("jg-advancedgarages bridge loaded")

local table = (Config.Framework == "qb" or Config.Framework == "qbox") and "player_vehicles" or "owned_vehicles"
local ownerCol = (Config.Framework == "qb" or Config.Framework == "qbox") and "citizenid" or "owner"

TS.Bridge.Garage.SetVehicleOutsideState = function(plate, state)
    if not plate then return end
    local storedState = state and 0 or 1

    local result = MySQL.update.await('UPDATE '..table..' SET in_garage = ? WHERE plate = ?', {
        storedState,
        plate
    })

    return result
end

TS.Bridge.Garage.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    local owner = MySQL.scalar.await('SELECT '..ownerCol..' FROM '..table..' WHERE plate = ? LIMIT 1', { plate })
    return owner ~= nil
end
