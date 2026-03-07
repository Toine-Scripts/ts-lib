if TS.Config.Garage ~= "vms_garagesv2" then
    return
end

if not TS.Utils.IsRessourceLoaded("vms_garagesv2") then
    TS.ErrorPrint("vms_garagesv2 is not loaded.")
    return
end

TS.DebugPrint("vms_garagesv2 bridge loaded")

local table = (Config.Framework == "qb" or Config.Framework == "qbox") and "player_vehicles" or "owned_vehicles"
local ownerCol = (Config.Framework == "qb" or Config.Framework == "qbox") and "citizenid" or "owner"

TS.Bridge.Garage.SetVehicleOutsideState = function(plate, state)
    if not plate then return end
    
    -- state=true means we want it unstored
    if state then
        local result = MySQL.update.await('UPDATE '..table..' SET garage = NULL, garageSpotID = NULL, parking_date = NULL WHERE plate = ?', {
            plate
        })
        return result
    end
end

TS.Bridge.Garage.IsVehicleOwned = function(plate, netId)
    if not plate then return false end
    local owner = MySQL.scalar.await('SELECT '..ownerCol..' FROM '..table..' WHERE plate = ? LIMIT 1', { plate })
    return owner ~= nil
end
