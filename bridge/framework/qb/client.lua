RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TS.TriggerEvent('playerloaded')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TS.TriggerEvent('playerunloaded')
end)