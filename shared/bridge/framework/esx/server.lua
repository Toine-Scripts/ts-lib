local ESX = exports['es_extended']:getSharedObject()

Bridge.Framework.Server.Functions.GetPlayerJob = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return false, 'Player not found, please check if the player is loaded'
    end

    local job = xPlayer.getJob and xPlayer.getJob() or xPlayer.job
    if not job then
        return false, 'Player job not found'
    end

    local jobData = {
        name = job.name,
        label = job.label,
        onduty = job.duty or true,
        type = job.type or 'job',
        grade = job.grade,
        grade_name = job.grade_name or (type(job.grade) == 'table' and job.grade.name),
        grade_label = job.grade_label or (type(job.grade) == 'table' and job.grade.label),
        grade_salary = job.salary or (type(job.grade) == 'table' and job.grade.salary),
    }

    return true, jobData
end

Bridge.Framework.Server.Functions.GetPlayersByJobName = function(job, checkOnDuty)
    if not job then
        return false, 'Job not found, please check if the job is valid or not provided'
    end
    if checkOnDuty == nil then checkOnDuty = false end

    local players = {}
    local esxPlayers = ESX.GetExtendedPlayers and ESX.GetExtendedPlayers() or {}

    for _, xPlayer in pairs(esxPlayers) do
        local pJob = xPlayer.getJob and xPlayer.getJob() or xPlayer.job
        if pJob and pJob.name == job and (not checkOnDuty or pJob.duty ~= false) then
            players[#players + 1] = {
                id = xPlayer.source,
                job = {
                    name = pJob.name,
                    label = pJob.label,
                    onduty = pJob.duty or true,
                    type = pJob.type or 'job',
                    grade = pJob.grade,
                    grade_name = pJob.grade_name or (type(pJob.grade) == 'table' and pJob.grade.name),
                    grade_label = pJob.grade_label or (type(pJob.grade) == 'table' and pJob.grade.label),
                    grade_salary = pJob.salary or (type(pJob.grade) == 'table' and pJob.grade.salary),
                }
            }
        end
    end

    if #players == 0 then
        return false, 'No players found in job: ' .. job .. ' (checkOnDuty: ' .. tostring(checkOnDuty) .. ')'
    end

    return true, players
end

Bridge.Framework.Server.Functions.GetPlayers = function()
    local sources = {}

    if ESX and ESX.GetPlayers then
        local players = ESX.GetPlayers()
        for i = 1, #players do
            sources[#sources + 1] = players[i]
        end
        return true, sources
    end

    local players = GetPlayers()
    for i = 1, #players do
        sources[#sources + 1] = tonumber(players[i]) or players[i]
    end

    return true, sources
end

Bridge.Framework.Server.Functions.HasPermission = function(source, permission)
    if not source then return false end
    permission = permission or 'admin'

    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then return false end

    if xPlayer.hasGroup then
        return xPlayer.hasGroup(permission) == true
    end

    local group = xPlayer.getGroup and xPlayer.getGroup() or xPlayer.group
    if not group then return false end

    if permission == 'admin' then
        return group == 'admin' or group == 'superadmin'
    end

    return group == permission
end

RegisterNetEvent('esx:playerLoaded', function(source, xPlayer)
    TriggerEvent('ts-lib:server:onPlayerLoaded', source)
    Bridge.Framework.Server.Emit('onPlayerLoaded', source)
end)

RegisterNetEvent('esx:playerDropped', function(source)
    TriggerEvent('ts-lib:server:onPlayerUnloaded', source)
    Bridge.Framework.Server.Emit('onPlayerUnloaded', source)
end)

RegisterNetEvent('esx:setJob', function(source, job, lastJob)
    TriggerEvent('ts-lib:server:onJobUpdated', job)
    Bridge.Framework.Server.Emit('onJobUpdated', job)
end)

Bridge.Framework.Server.Functions.GetVehicleType = function(model)
    return 'automobile'
end

-- Get character id from player source (identifier)
---@param source number
---@return boolean, string|string
Bridge.Framework.Server.Functions.GetCharId = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not xPlayer then
        return false, 'Player not found, please check if the player is loaded'
    end

    return true, xPlayer.identifier
end

-- Get player source by character id (identifier)
---@param charId string
---@return boolean, number|string
Bridge.Framework.Server.Functions.GetSourceByCharId = function(charId)
    if charId == nil or charId == '' then
        return false, 'Invalid character id'
    end
    
    if type(charId) ~= 'string' then
        charId = tostring(charId)
    end

    local xPlayer = ESX.GetPlayerFromIdentifier(charId)
    
    if not xPlayer then
        return false, 'Player not found with character id: ' .. charId
    end

    print(json.encode(xPlayer, { indent = true }))

    local src = xPlayer.source
    if not src then
        return false, 'Player source not found for: ' .. charId
    end

    return true, src
end