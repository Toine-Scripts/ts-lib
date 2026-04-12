---@type any -- That kind of obvious...
QBCore = exports['qb-core']:GetCoreObject()

-- Get player job from their source
---@param source number -- Player source
---@return boolean, table|string
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

-- Get all players by job name
---@param job string -- Need to rename this args by the way, because it's not a "job", it's a job name (a string).
---@param checkOnDuty boolean
---@return boolean, number[]|string
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

-- Get all players
---@return boolean, table|string
Bridge.Framework.Server.Functions.GetPlayers = function()
    local players = QBCore.Functions.GetPlayers()
    if not players then
        return false, 'No players found'
    end
    return true, players
end

-- Check if the player has a permission
---@param source number
---@param permission string
---@return boolean
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
AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    local source = Player.PlayerData.source
    if not source then return end
    Utils.DebugPrint('Player loaded: ' .. source)
    TriggerEvent('ts-lib:server:onPlayerLoaded', source)

    Bridge.Framework.Server.Emit('onPlayerLoaded', source)
end)

RegisterNetEvent('QBCore:Server:OnPlayerUnload')
AddEventHandler('QBCore:Server:OnPlayerUnload', function(source)
    if not source then return end
    Utils.DebugPrint('Player unloaded: ' .. source)
    TriggerEvent('ts-lib:server:onPlayerUnloaded', source)

    Bridge.Framework.Server.Emit('onPlayerUnloaded', source)
end)

RegisterNetEvent('QBCore:Server:OnJobUpdate')
AddEventHandler('QBCore:Server:OnJobUpdate', function(job)
    local source = source
    Utils.DebugPrint('Job updated: ' .. source .. ' ' .. job)
    TriggerEvent('ts-lib:server:onJobUpdated', source, job)

    Bridge.Framework.Server.Emit('onJobUpdated', source, job)
end)

-- Get vehicle type from model
---@param model number
---@return string
Bridge.Framework.Server.Functions.GetVehicleType = function(model)
    return QBCore.Shared.Vehicles[model] and QBCore.Shared.Vehicles[model].type or 'automobile'
end

-- Get character id from player source (citizenId etc...)
---@param source number
---@return boolean, string|string
Bridge.Framework.Server.Functions.GetCharId = function(source)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then
        return false, 'Player not found, please check if the player is loaded'
    end
    return true, Player.PlayerData.citizenid
end

-- Get player source by character id (citizenId etc...)
---@param charId string
---@return boolean, number|string
Bridge.Framework.Server.Functions.GetSourceByCharId = function(charId)
    if charId == nil or charId == '' then
        return false, 'Invalid character id'
    end
    if type(charId) ~= 'string' then
        charId = tostring(charId)
    end
    local Player = QBCore.Functions.GetPlayerByCitizenId(charId)
    if not Player or not Player.PlayerData then
        return false, 'Player not found with character id: ' .. charId
    end
    local src = Player.PlayerData.source
    if not src then
        return false, 'Player not found with character id: ' .. charId
    end
    return true, src
end