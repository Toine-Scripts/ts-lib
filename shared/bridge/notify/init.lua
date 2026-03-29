Bridge.Notify = {}

Bridge.Notify.Client = {
    Functions = {},
    Events = {},
}
Bridge.Notify.Server = {
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

EmitSystem(Bridge.Notify.Server)
EmitSystem(Bridge.Notify.Client)

Bridge.Notify.Load = function(notifySystem)
    if not Utils.LoadFile(string.format('shared/bridge/notify/%s/shared.lua', notifySystem)) then
        -- shared.lua est optionnel pour notify
    end

    if not Utils.IsServer() then
        if not Utils.LoadFile(string.format('shared/bridge/notify/%s/client.lua', notifySystem)) then
            return false, 'Failed to load notify client: ' .. notifySystem .. ' (client.lua), please check if the file exists'
        end
    end

    return true, 'Notify system loaded successfully: ' .. notifySystem
end

function Bridge.Notify.Initialize()
    if Config.Notify == 'auto' then
        Utils.DebugPrint('Notify system auto detected')

        for notifySystem, resource in pairs(Config.Data.Notify or {}) do
            if Utils.IsResourceStarted(resource) then
                Config.Notify = notifySystem
                break
            end
        end

        if not Config.Notify then
            Utils.ErrorPrint('No notify system detected')
            return false
        end

        Utils.DebugPrint('Notify system detected: ' .. Config.Notify)

        local success, message = Bridge.Notify.Load(Config.Notify)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end

        return true
    else
        if not (Config.Data.Notify and Config.Data.Notify[Config.Notify]) then
            Utils.ErrorPrint('Notify system not found in config: ' .. tostring(Config.Notify))
            return false
        end

        local success, message = Bridge.Notify.Load(Config.Notify)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end
    end
end

Bridge.Notify.Initialize()