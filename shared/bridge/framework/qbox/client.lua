QBCore = exports['qbx_core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    Bridge.Framework.Client.PlayerData = QBCore.Functions.GetPlayerData()
    TriggerEvent('ts-lib:client:onPlayerLoaded', Bridge.Framework.Client.PlayerData)
    Bridge.Framework.Client.Emit('onPlayerLoaded', Bridge.Framework.Client.PlayerData)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    Bridge.Framework.Client.PlayerData = {}
    TriggerEvent('ts-lib:client:onPlayerUnloaded')
    Bridge.Framework.Client.Emit('onPlayerUnloaded')
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
    Bridge.Framework.Client.PlayerData.job = job
    TriggerEvent('ts-lib:client:onJobUpdated', job)
    Bridge.Framework.Client.Emit('onJobUpdated', job)
end)

-- Get player job 
---@return boolean, table|string
Bridge.Framework.Client.Functions.GetPlayerJob = function()
    if not Bridge.Framework.Client.PlayerData.job then
        return false, 'Player job not found, please check if the player is loaded'
    end
    return true, Bridge.Framework.Client.PlayerData.job
end


Bridge.Framework.Client.Functions.Notify = function(message, type)
    QBCore.Functions.Notify(message, type)
end

