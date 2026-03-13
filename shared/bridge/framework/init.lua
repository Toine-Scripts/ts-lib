Bridge.Framework = {}

Bridge.Framework.Client = {
    PlayerData = {},
    Functions = {},
    Events = {},
}
Bridge.Framework.Server = {
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

EmitSystem(Bridge.Framework.Server)
EmitSystem(Bridge.Framework.Client)

Bridge.Framework.Load = function(framework)
    if not Utils.LoadFile(string.format('shared/bridge/framework/%s/shared.lua', framework)) then
        return false, 'Failed to load framework shared: ' .. framework .. ' (shared.lua), please check if the file exists'
    end

    if Utils.IsServer() then
        if not Utils.LoadFile(string.format('shared/bridge/framework/%s/server.lua', framework)) then
            return false, 'Failed to load framework server: ' .. framework .. ' (server.lua), please check if the file exists'
        end
    else
        if not Utils.LoadFile(string.format('shared/bridge/framework/%s/client.lua', framework)) then
            return false, 'Failed to load framework client: ' .. framework .. ' (client.lua), please check if the file exists'
        end
    end

    return true, 'Framework loaded successfully: ' .. framework
end

function Bridge.Framework.Initialize()
    if Config.Framework == 'auto' then
        Utils.DebugPrint('Framework auto detected')
        for framework, resource in pairs(Config.Data.Framework) do
            if Utils.IsResourceStarted(resource) then
                Config.Framework = framework
                break
            end
        end

        if not Config.Framework then
            Utils.ErrorPrint('No framework detected')
            return false
        end

        Utils.DebugPrint('Framework detected: ' .. Config.Framework)

        local success, message = Bridge.Framework.Load(Config.Framework)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end


        return true
    else
        if not Config.Data.Framework[Config.Framework] then
            Utils.ErrorPrint('Framework not found in config: ' .. Config.Framework)
            return false
        end


        local success, message = Bridge.Framework.Load(Config.Framework)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end
    end
end

Bridge.Framework.Initialize()
