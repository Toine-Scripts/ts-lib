if TS.Config.Framework ~= "standalone" then
    return
end

TS.DebugPrint("standalone framework loaded successfully")

--- Standalone server bridge
function TS.Bridge.HasPermission(source, permission)
    if IsPlayerAceAllowed(source, "admin") then return true end
    return false
end

function TS.Bridge.GetVehicleType(model)
    return 'automobile' -- Default to automobile 
end

function TS.Bridge.GetPlayers()
    local players = GetPlayers()
    for i = 1, #players do
        players[i] = tonumber(players[i]) or players[i]
    end
    return players
end



