local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    Bridge.Framework.Client.PlayerData = xPlayer or {}
    TriggerEvent('ts-lib:client:onPlayerLoaded', Bridge.Framework.Client.PlayerData)
    Bridge.Framework.Client.Emit('onPlayerLoaded', Bridge.Framework.Client.PlayerData)
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    Bridge.Framework.Client.PlayerData = {}
    TriggerEvent('ts-lib:client:onPlayerUnloaded')
    Bridge.Framework.Client.Emit('onPlayerUnloaded')
end)

RegisterNetEvent('esx:setJob', function(job)
    Bridge.Framework.Client.PlayerData.job = job
    TriggerEvent('ts-lib:client:onJobUpdated', job)
    Bridge.Framework.Client.Emit('onJobUpdated', job)
end)

Bridge.Framework.Client.Functions.GetPlayerJob = function()
    if not Bridge.Framework.Client.PlayerData.job then
        return false, 'Player job not found, please check if the player is loaded'
    end
    return true, Bridge.Framework.Client.PlayerData.job
end

Bridge.Framework.Client.Functions.Notify = function(message, type)
    if ESX and ESX.ShowNotification then
        ESX.ShowNotification(message)
    else
        BeginTextCommandThefeedPost('STRING')
        AddTextComponentSubstringPlayerName(message)
        EndTextCommandThefeedPostTicker(false, false)
    end
end

Bridge.Framework.Client.Functions.GetPlayerData = function()
    return ESX.GetPlayerData()
end

Bridge.Framework.Client.Functions.GetCharId = function()
    return ESX.PlayerData.identifier
end
