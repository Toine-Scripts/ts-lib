Bridge.VehicleKeys.Client.Functions.SetDoorStatus = function(entity, status)
    TriggerEvent('qb-vehiclekeys:server:setVehLockState', NetworkGetNetworkIdFromEntity(entity), status)
end
