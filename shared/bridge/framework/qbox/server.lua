QBCore = exports['qbx_core']:GetCoreObject()

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

    local players = {}
    local qbPlayers = exports.qbx_core:GetQBPlayers()

    for _, Player in pairs(qbPlayers or {}) do
        if Player.PlayerData and Player.PlayerData.job and Player.PlayerData.job.name == job then
            if (not checkOnDuty) or Player.PlayerData.job.onduty then
                players[#players + 1] = {
                    id = Player.PlayerData.source or Player.source,
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
    end

    if #players == 0 then
        return false, 'No players found in job: ' .. job .. ' (checkOnDuty: ' .. tostring(checkOnDuty) .. ')'
    end

    return true, players
end

Bridge.Framework.Server.Functions.GetPlayers = function()
    local players = {}
    local qbPlayers = exports.qbx_core:GetQBPlayers()

    for _, Player in pairs(qbPlayers or {}) do
        players[#players + 1] = Player.PlayerData and Player.PlayerData.source or Player.source
    end

    if #players == 0 then
        return false, 'No players found'
    end

    return true, players
end

Bridge.Framework.Server.Functions.HasPermission = function(source, permission)
    if not source then return false end
    permission = permission or 'admin'

    -- qbx_core moved away from its own permission abstraction.
    -- Use native ACE groups by default.
    return IsPlayerAceAllowed(source, ('group.%s'):format(permission))
end

RegisterNetEvent('QBCore:Server:PlayerLoaded', function(source)
    Utils.DebugPrint('Player loaded: ' .. source)
    TriggerEvent('ts-lib:server:onPlayerLoaded', source)
    Bridge.Framework.Server.Emit('onPlayerLoaded', source)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload', function(source)
    Utils.DebugPrint('Player unloaded: ' .. source)
    TriggerEvent('ts-lib:server:onPlayerUnloaded', source)
    Bridge.Framework.Server.Emit('onPlayerUnloaded', source)
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate', function(source, job)
    Utils.DebugPrint('Job updated: ' .. job)
    TriggerEvent('ts-lib:server:onJobUpdated', job)
    Bridge.Framework.Server.Emit('onJobUpdated', job)
end)

Bridge.Framework.Server.Functions.GetVehicleType = function(model)
    local vehicle = exports.qbx_core:GetVehiclesByName(model)
    if not vehicle then return 'automobile' end
    return vehicle.type or 'automobile'
end

