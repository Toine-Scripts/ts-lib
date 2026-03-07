if TS.Config.Framework ~= "standalone" then
    return
end

TS.DebugPrint("standalone framework loaded successfully")

--- Standalone player loaded bridge
---
--- This not real events but you can config here
-- RegisterNetEvent('event:playerLoaded', function()
--     TS.TriggerEvent('playerloaded')()
--     TS.DebugPrint("Player loaded successfully")
-- end)

-- RegisterNetEvent('event:playerUnload', function()
--     TS.TriggerEvent('playerunloaded')()
--     TS.DebugPrint("Player unloaded successfully")
-- end)

CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(500)
    end
    TS.TriggerEvent('playerloaded')()
    TS.DebugPrint("Player loaded successfully")
end)
