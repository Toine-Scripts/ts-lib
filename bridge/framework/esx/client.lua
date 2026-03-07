RegisterNetEvent('esx:playerLoaded', function(xPlayer)
    TS.TriggerEvent('playerloaded', xPlayer)
end)

RegisterNetEvent('esx:onPlayerLogout', function()
    TS.TriggerEvent('playerunloaded')
end)
