Bridge.VehicleKeys = {}

Bridge.VehicleKeys.Client = {
    Functions = {},
    Events = {},
}
Bridge.VehicleKeys.Server = {
    Functions = {},
    Events = {},
}

local function EmitSystem(sideTable)
    local registered = sideTable.Events

    function sideTable.On(eventName, callback)
        if type(eventName) ~= 'string' or type(callback) ~= 'function' then
            return
        end

        if not registered[eventName] then
            registered[eventName] = {}
        end

        registered[eventName][#registered[eventName] + 1] = callback
    end

    function sideTable.Emit(eventName, ...)
        local listeners = registered[eventName]
        if not listeners then return end

        for _, cb in ipairs(listeners) do
            cb(...)
        end
    end
end

EmitSystem(Bridge.VehicleKeys.Server)
EmitSystem(Bridge.VehicleKeys.Client)

Bridge.VehicleKeys.Load = function(keysSystem)
    if not Utils.LoadFile(string.format('shared/bridge/vehiclekeys/%s/shared.lua', keysSystem)) then
        return false, 'Failed to load vehicle keys shared: ' .. keysSystem .. ' (shared.lua), please check if the file exists'
    end

    if Utils.IsServer() then
        if not Utils.LoadFile(string.format('shared/bridge/vehiclekeys/%s/server.lua', keysSystem)) then
            return false, 'Failed to load vehicle keys server: ' .. keysSystem .. ' (server.lua), please check if the file exists'
        end
    else
        if not Utils.LoadFile(string.format('shared/bridge/vehiclekeys/%s/client.lua', keysSystem)) then
            return false, 'Failed to load vehicle keys client: ' .. keysSystem .. ' (client.lua), please check if the file exists'
        end
    end

    return true, 'Vehicle keys system loaded successfully: ' .. keysSystem
end

function Bridge.VehicleKeys.Initialize()
    if Config.VehicleKeys == 'auto' then
        Utils.DebugPrint('Vehicle keys system auto detected')
        for keysSystem, resource in pairs(Config.Data.VehicleKeys or {}) do
            if Utils.IsResourceStarted(resource) then
                Config.VehicleKeys = keysSystem
                break
            end
        end

        if not Config.VehicleKeys then
            Utils.ErrorPrint('No vehicle keys system detected')
            return false
        end

        Utils.DebugPrint('Vehicle keys system detected: ' .. Config.VehicleKeys)

        local success, message = Bridge.VehicleKeys.Load(Config.VehicleKeys)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end

        return true
    else
        if not (Config.Data.VehicleKeys and Config.Data.VehicleKeys[Config.VehicleKeys]) then
            Utils.ErrorPrint('Vehicle keys system not found in config: ' .. tostring(Config.VehicleKeys))
            return false
        end

        local success, message = Bridge.VehicleKeys.Load(Config.VehicleKeys)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end
    end
end

Bridge.VehicleKeys.Initialize()
