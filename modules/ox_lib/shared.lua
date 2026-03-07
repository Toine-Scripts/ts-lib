-- TS-Lib Wrapper for ox_lib (Shared)
if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

---@class TS.Lib.Callback
TS.Lib.Callback = {}

--- Await a server callback (client) or a client callback (server)
---@param name string Event name
---@param playerId number|false Player ID (only used on server to target a client, false on client)
---@param ... any Arguments to pass
---@return any
TS.Lib.Callback.Await = function(name, playerId, ...)
    return lib.callback.await(name, playerId, ...)
end

--- Register a callback
---@param name string Event name
---@param cb function Callback function
TS.Lib.Callback.Register = function(name, cb)
    lib.callback.register(name, cb)
end
