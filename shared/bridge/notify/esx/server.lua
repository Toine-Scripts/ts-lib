Bridge.Notify.Server.Functions.Notify = function(source, message, type, length)
    local target = source or -1
    TriggerClientEvent('ts-lib:client:bridge:Notify', target, message, type, length)
end

Bridge.Notify.Server.Functions.NotifyAll = function(message, type, length)
    TriggerClientEvent('ts-lib:client:bridge:Notify', -1, message, type, length)
end