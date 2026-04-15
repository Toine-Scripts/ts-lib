local ESX = exports['es_extended']:getSharedObject()

Bridge.Notify.Client.Functions.Notify = function(message, type)
    return ESX.ShowNotification(message, type)
end