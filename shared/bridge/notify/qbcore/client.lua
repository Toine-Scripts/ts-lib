Bridge.Notify.Client.Functions.Notify = function(message, type)
    return QBCore.Functions.Notify(message, type)
end

local currentResource = GetCurrentResourceName()
local libResource = TS_LIB_RESOURCE_NAME or 'ts-lib'

if currentResource == libResource then
    RegisterNetEvent('ts-lib:client:bridge:Notify', function(message, type)
        Bridge.Notify.Client.Functions.Notify(message, type)
    end)
end