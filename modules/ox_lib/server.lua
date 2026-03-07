-- TS-Lib Wrapper for ox_lib (Server)
if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

--- Add a chat command
---@param name string The command name
---@param params table Options (restricted, help, params)
---@param cb function Callback when executed
TS.Lib.AddCommand = function(name, params, cb)
    lib.addCommand(name, params, cb)
end

--- Send a notification to a player
---@param source number Player ID
---@param title string Title of the notification
---@param description string Description of the notification
---@param type string 'success', 'error', 'inform'
TS.Lib.Notify = function(source, title, description, type)
    TriggerClientEvent('ox_lib:notify', source, {
        title = title,
        description = description,
        type = type
    })
end
