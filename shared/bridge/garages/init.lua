Bridge.Garages = {}

Bridge.Garages.Client = {
    Functions = {},
    Events = {},
}
Bridge.Garages.Server = {
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

EmitSystem(Bridge.Garages.Server)
EmitSystem(Bridge.Garages.Client)

Bridge.Garages.Load = function(garage)
    if not Utils.LoadFile(string.format('shared/bridge/garages/%s/shared.lua', garage)) then
        return false, 'Failed to load garages shared: ' .. garage .. ' (shared.lua), please check if the file exists'
    end

    if Utils.IsServer() then
        if not Utils.LoadFile(string.format('shared/bridge/garages/%s/server.lua', garage)) then
            return false, 'Failed to load garages server: ' .. garage .. ' (server.lua), please check if the file exists'
        end
    else
        if not Utils.LoadFile(string.format('shared/bridge/garages/%s/client.lua', garage)) then
            return false, 'Failed to load garages client: ' .. garage .. ' (client.lua), please check if the file exists'
        end
    end

    return true, 'Garage loaded successfully: ' .. garage
end

function Bridge.Garages.Initialize()
    if Config.Garages == 'auto' then
        Utils.DebugPrint('Garages auto detected')
        for garage, resource in pairs(Config.Data.Garages or {}) do
            if Utils.IsResourceStarted(resource) then
                Config.Garages = garage
                break
            end
        end

        if not Config.Garages then
            Utils.ErrorPrint('No garages system detected')
            return false
        end

        Utils.DebugPrint('Garages detected: ' .. Config.Garages)

        local success, message = Bridge.Garages.Load(Config.Garages)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end

        return true
    else
        if not (Config.Data.Garages and Config.Data.Garages[Config.Garages]) then
            Utils.ErrorPrint('Garages system not found in config: ' .. tostring(Config.Garages))
            return false
        end

        local success, message = Bridge.Garages.Load(Config.Garages)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end
    end
end

Bridge.Garages.Initialize()
