if TS.Config.Framework ~= "qbx" then
    return
end

if not TS.Utils.IsRessourceLoaded("qbx_core") then
    TS.ErrorPrint("qbx_core is not loaded, please select the right framework in the config https://docs.toine.me/scripts/persistence#2-framework-support")
    return
end

TS.DebugPrint("qbx_core loaded successfully")

--- QBx_core player loaded bridge
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TS.TriggerEvent('playerloaded')()
    TS.DebugPrint("Player loaded successfully")
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    TS.TriggerEvent('playerunloaded')()
    TS.DebugPrint("Player unloaded successfully")
end)
