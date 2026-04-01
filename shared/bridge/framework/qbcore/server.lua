QBCore = exports['qb-core']:GetCoreObject()

Bridge.Framework.Server.Functions.GetPlayerJob = function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return false, 'Player not found, please check if the player is loaded'
    end

    local jobData = {
        name = Player.PlayerData.job.name,
        label = Player.PlayerData.job.label,
        onduty = Player.PlayerData.job.onduty,
        type = Player.PlayerData.job.type,
        grade = Player.PlayerData.job.grade,
        grade_name = Player.PlayerData.job.grade.name,
        grade_label = Player.PlayerData.job.grade.label,
        grade_salary = Player.PlayerData.job.grade.salary,
    }

    return true, jobData
end

Bridge.Framework.Server.Functions.GetPlayersByJobName = function(job, checkOnDuty) 
    if not job then
        return false, 'Job not found, please check if the job is valid or not provided'
    end
    if checkOnDuty == nil then checkOnDuty = false end

    local players, count = QBCore.Functions.GetPlayersByJob(job, checkOnDuty)
    if not players then
        return false, 'No players found in job: ' .. job .. ' (checkOnDuty: ' .. checkOnDuty .. ')'
    end

    local playerData = {}
    for _, playerId in ipairs(players) do
        local Player = QBCore.Functions.GetPlayer(playerId)
        if Player and Player.PlayerData and Player.PlayerData.job then
            playerData[#playerData + 1] = {
                id = playerId,
                job = {
                    name = Player.PlayerData.job.name,
                    label = Player.PlayerData.job.label,
                    onduty = Player.PlayerData.job.onduty,
                    type = Player.PlayerData.job.type,
                    grade = Player.PlayerData.job.grade,
                    grade_name = Player.PlayerData.job.grade.name,
                    grade_label = Player.PlayerData.job.grade.label,
                    grade_salary = Player.PlayerData.job.grade.salary,
                }
            }
        end
    end
    return true, playerData
end

Bridge.Framework.Server.Functions.GetPlayers = function()
    local players = QBCore.Functions.GetPlayers()
    if not players then
        return false, 'No players found'
    end
    return true, players
end

Bridge.Framework.Server.Functions.HasPermission = function(source, permission)
    if not source then return false end
    permission = permission or 'admin'

    if QBCore and QBCore.Functions and QBCore.Functions.HasPermission then
        return QBCore.Functions.HasPermission(source, permission) == true
    end

    -- Fallback for older cores / custom stacks using ACE groups.
    return IsPlayerAceAllowed(source, ('group.%s'):format(permission))
end

RegisterNetEvent('QBCore:Server:PlayerLoaded')
AddEventHandler('QBCore:Server:PlayerLoaded', function()
    local source = source
    Utils.DebugPrint('Player loaded: ' .. source)
    TriggerEvent('ts-lib:server:onPlayerLoaded', source)

    Bridge.Framework.Server.Emit('onPlayerLoaded', source)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload')
AddEventHandler('QBCore:Server:OnPlayerUnload', function()
    local source = source
    Utils.DebugPrint('Player unloaded: ' .. source)
    TriggerEvent('ts-lib:server:onPlayerUnloaded')

    Bridge.Framework.Server.Emit('onPlayerUnloaded')
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate')
AddEventHandler('QBCore:Server:OnJobUpdate', function(job)
    local source = source
    Utils.DebugPrint('Job updated: ' .. source .. ' ' .. job)
    TriggerEvent('ts-lib:server:onJobUpdated', source, job)

    Bridge.Framework.Server.Emit('onJobUpdated', source, job)
end)


Bridge.Framework.Server.Functions.GetVehicleType = function(model)
    return QBCore.Shared.Vehicles[model] and QBCore.Shared.Vehicles[model].type or 'automobile'
end


Bridge.Framework.Server.Functions.GetCharId = function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return false, 'Player not found, please check if the player is loaded'
    end
    return Player.PlayerData.citizenid
end

Bridge.Framework.Server.Functions.GetSourceByCharId = function(charId)
    local players = QBCore.Functions.GetPlayers()
    if not players then
        return false, 'No players found'
    end
    for _, player in ipairs(players) do
        local Player = QBCore.Functions.GetPlayer(player)
        if Player and Player.PlayerData and Player.PlayerData.citizenid == charId then
            return player
        end
    end
    return false, 'Player not found'
end