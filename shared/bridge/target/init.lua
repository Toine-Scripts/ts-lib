Bridge.Target = {}

Bridge.Target.Client = {
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

EmitSystem(Bridge.Target.Client)

Bridge.Target.Load = function(targetSystem)
    if not Utils.IsServer() then
        if not Utils.LoadFile(string.format('shared/bridge/target/%s/client.lua', targetSystem)) then
            return false, 'Failed to load target client: ' .. targetSystem .. ' (client.lua), please check if the file exists'
        end
    end

    return true, 'Target system loaded successfully: ' .. targetSystem
end

function Bridge.Target.Initialize()
    if Config.Target == 'none' or not Config.Target then
        return true, 'No target system selected'
    end

    if Config.Target == 'auto' then
        Utils.DebugPrint('Target system auto detected')

        for targetSystem, resource in pairs(Config.Data.Target or {}) do
            if Utils.IsResourceStarted(resource) then
                Config.Target = targetSystem
                break
            end
        end

        if not Config.Notify then
            Utils.ErrorPrint('No target system detected')
            return false
        end

        Utils.DebugPrint('Target system detected: ' .. Config.Target)

        local success, message = Bridge.Target.Load(Config.Target)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end

        return true
    else
        if not (Config.Data.Target and Config.Data.Target[Config.Target]) then
            Utils.ErrorPrint('Target system not found in config: ' .. tostring(Config.Target))
            return false
        end

        local success, message = Bridge.Target.Load(Config.Target)
        if success then
            Utils.SuccessPrint(message)
        else
            Utils.ErrorPrint(message)
            return false
        end
    end
end

Bridge.Target.Initialize()