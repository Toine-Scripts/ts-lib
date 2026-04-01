Bridge.VehicleKeys.Server.Functions.SetDoorStatus = function(entity, status)

    local netId = NetworkGetNetworkIdFromEntity(entity)
    if not netId then return end

    local lockStatus = status
    local isLocking = status ~= 0 and status ~= 1

    TriggerClientEvent('vehicle:syncLockClient', -1, netId, lockStatus, isLocking)
end