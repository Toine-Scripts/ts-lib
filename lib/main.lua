-- Utility library used by the resource (timers/intervals)
-- =====================================================================
-- IMPORTANT NOTICE:
-- The code in this file (SetInterval / ClearInterval) is taken directly 
-- from `ox_lib` (Overextended). Full credit goes to the Overextended team.
-- GitHub: https://github.com/overextended/ox_lib
-- =====================================================================

if not TS then
    TS = {}
end

TS.Lib = {}

local intervals = {}

---@param callback function | number
---@param interval? number
---@param ... any

TS.Lib.SetInterval = function(callback, interval, ...)
    interval = interval or 0

    if type(interval) ~= 'number' then
        return error(('Interval must be a number. Received %s'):format(json.encode(interval --[[@as unknown]])))
    end

    local cbType = type(callback)

    if cbType == 'number' and intervals[callback] then
        intervals[callback] = interval or 0
        return
    end

    if cbType ~= 'function' then
        return error(('Callback must be a function. Received %s'):format(cbType))
    end

    local args, id = { ... }

    Citizen.CreateThreadNow(function(ref)
        id = ref
        intervals[id] = interval or 0
        repeat
            callback(table.unpack(args))
            interval = intervals[id]
            if interval < 0 then break end
            Wait(interval)
        until false
        intervals[id] = nil
    end)

    return id
end

---@param id number
---@return nil
TS.Lib.ClearInterval = function(id)
    if type(id) ~= 'number' then
        return -- Ignore invalid id
    end

    if not intervals[id] then
        return -- No interval exists
    end

    intervals[id] = -1
end
