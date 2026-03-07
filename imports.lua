local resourceName = 'ts-lib'

local function loadFile(path)
    local content = LoadResourceFile(resourceName, path)
    if not content then
        print(('^1[ts-lib] Error: Could not load %s^7'):format(path))
        return
    end
    
    local func, err = load(content, ('@@%s/%s'):format(resourceName, path))
    if not func then
        print(('^1[ts-lib] Error: Syntax error in %s: %s^7'):format(path, err))
        return
    end
    
    local success, result = pcall(func)
    if not success then
        print(('^1[ts-lib] Error: Execution error in %s: %s^7'):format(path, result))
    end
end

-- Dynamically load ox_lib for the consuming resource
local ox_lib_init = LoadResourceFile('ox_lib', 'init.lua')
if ox_lib_init then
    local func, err = load(ox_lib_init, '@@ox_lib/init.lua')
    if func then
        pcall(func)
    else
        print(('^1[ts-lib] Error loading ox_lib/init.lua logic: %s^7'):format(err))
    end
else
    print('^1[ts-lib] Error: ox_lib is required but its init.lua could not be found!^7')
end

-- Load shared modules
loadFile('shared/init.lua')
loadFile('lib/main.lua') -- Loaded early for intervals usage

-- Load modules
loadFile('modules/ox_lib/shared.lua')

if IsDuplicityVersion() then -- Server side
    loadFile('modules/ox_lib/server.lua')
else -- Client side
    loadFile('modules/ox_lib/client.lua')
end

loadFile('shared/config.lua')
loadFile('shared/utils.lua')
loadFile('shared/events.lua')
loadFile('shared/bridge.lua')

-- Load framework detection and bridges
if not IsDuplicityVersion() then -- Client side
    loadFile('bridge/framework/detect.lua')
    loadFile('bridge/framework/qb/client.lua')
    loadFile('bridge/framework/qbox/client.lua')
    loadFile('bridge/framework/esx/client.lua')
    loadFile('bridge/framework/standalone/client.lua')
    
    loadFile('bridge/keys/qb-vehiclekeys/client.lua')
    loadFile('bridge/keys/qs-vehiclekeys/client.lua')
    loadFile('bridge/keys/standalone/client.lua')
else -- Server side
    loadFile('bridge/framework/detect.lua')
    loadFile('bridge/framework/qb/server.lua')
    loadFile('bridge/framework/qbox/server.lua')
    loadFile('bridge/framework/esx/server.lua')
    loadFile('bridge/framework/standalone/server.lua')
    
    loadFile('bridge/garage/qb-garages/server.lua')
    loadFile('bridge/garage/esx_garage/server.lua')
    loadFile('bridge/garage/vms_garagesv2/server.lua')
    loadFile('bridge/garage/jg-advancedgarages/server.lua')
    loadFile('bridge/garage/standalone/server.lua')
end

