Bridge.Framework.Client.PlayerData = Bridge.Framework.Client.PlayerData or {}

CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(500)
    end

    TriggerEvent('ts-lib:client:onPlayerLoaded', Bridge.Framework.Client.PlayerData)
    Bridge.Framework.Client.Emit('onPlayerLoaded', Bridge.Framework.Client.PlayerData)
end)

Bridge.Framework.Client.Functions.GetPlayerJob = function()
    return false, 'Standalone framework has no job system configured'
end

Bridge.Framework.Client.Functions.Notify = function(message, type)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(message)
    DrawNotification(false, false)
end

