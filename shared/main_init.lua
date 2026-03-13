Bridge = {}
TS = TS or {}

local modules = {
    'framework',
    'garages',
    'vehiclekeys',
}

Utils.Print('Initializing modules... (' .. #modules .. ' modules)')

local loadedModules = 0

for _, module in ipairs(modules) do
    local path = ('shared/bridge/%s/init.lua'):format(module)

    local success, err = pcall(function()
        local loaded = Utils.LoadFile(path)
        if not loaded then
            error('Failed to load module file: ' .. path)
        end
    end)

    if not success then
        Utils.ErrorPrint(('Error loading module %s: %s'):format(module, err))
    else
        loadedModules += 1
    end
end

Utils.Print('Modules initialized (' .. loadedModules .. '/' .. #modules .. ' modules)')

-- if Utils.IsServer() then
--     local success, players = Bridge.Framework.Server.Functions.GetPlayersByJobName('police', true)
--     if success then
--         Utils.Print('Players in job: ' .. #players)
--     else
--         Utils.ErrorPrint(players, 'error')
--     end
-- end

