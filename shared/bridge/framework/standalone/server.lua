Bridge.Framework.Server.Functions.GetPlayerJob = function(source)
    return false, 'Standalone framework has no job system configured'
end

Bridge.Framework.Server.Functions.GetPlayersByJobName = function(job, checkOnDuty)
    return true, {}
end

Bridge.Framework.Server.Functions.GetPlayers = function()
    local players = GetPlayers()
    for i = 1, #players do
        players[i] = tonumber(players[i]) or players[i]
    end
    return true, players
end

Bridge.Framework.Server.Functions.GetVehicleType = function(model)
    return 'automobile'
end

