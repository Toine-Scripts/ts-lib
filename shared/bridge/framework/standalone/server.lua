Bridge.Framework.Server.Functions.GetPlayerJob = function(source)
    return false, 'Standalone framework has no job system configured'
end

Bridge.Framework.Server.Functions.GetPlayersByJobName = function(job, checkOnDuty)
    return true, {}
end


---@alias PlayerId number
---@alias PlayersIdList PlayerId[]
---@return boolean, PlayersIdList
Bridge.Framework.Server.Functions.GetPlayers = function()
    local players = GetPlayers()
    for i = 1, #players do
        players[i] = tonumber(players[i]) or players[i]
    end
    return true, players
end

Bridge.Framework.Server.Functions.HasPermission = function(source, permission)
    if not source then return false end
    permission = permission or 'admin'
    return IsPlayerAceAllowed(source, ('group.%s'):format(permission))
end

Bridge.Framework.Server.Functions.GetVehicleType = function(model)
    return 'automobile'
end

