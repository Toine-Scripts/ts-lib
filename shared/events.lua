TS.Events = {}
local registeredEvents = {}

--- Register a callback for a specific event
---@param eventName string
---@param callback function
TS.On = function(eventName, callback)
    if not registeredEvents[eventName] then
        registeredEvents[eventName] = {}
    end
    table.insert(registeredEvents[eventName], callback)
end

--- Internal function to trigger registered callbacks
---@param eventName string
---@param ... any
TS.TriggerEvent = function(eventName, ...)
    if registeredEvents[eventName] then
        for _, callback in ipairs(registeredEvents[eventName]) do
            callback(...)
        end
    end
end

