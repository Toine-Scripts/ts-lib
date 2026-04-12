if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

local inputData = {
    receivedData = false,
    hasCanceled = false,
    value = false,
}

local zUI = nil

if Config.zUIFix then
    if Utils.IsResourceStarted("zUI-v2") then
        zUI = exports["zUI-v2"]:getObject()
    end
end

TS.Lib.ConfirmInput = {}


TS.Lib.ConfirmInput = function(data)
    local defaultData = {
        title = "Confirm Input",
        text = "Are you sure you want to do this?",
        confirmLabel = "Confirm",
        cancelLabel = "Cancel",
    }

    data = table.merge(defaultData, data)

    SendNUIMessage({
        module = 'confirmInput',
        data = data
    })

    SetNuiFocus(true, true)

    local anyIsOpen = false


    if Config.zUIFix and zUI and zUI.IsAnyMenuOpen then
        anyIsOpen = zUI.IsAnyMenuOpen()

        if anyIsOpen and zUI.ManageFocus then
            zUI.ManageFocus(false)
        end
    end

    while not inputData.receivedData do
        Wait(100)
    end

    SetNuiFocus(false, false)

    if Config.zUIFix and zUI and zUI.ManageFocus then
        if anyIsOpen then
            zUI.ManageFocus(true)
        end
    end

    local returnData = {
        receivedData = inputData.receivedData,
        hasCanceled = inputData.hasCanceled,
        data = inputData.data,
    }
    inputData.receivedData = false
    inputData.hasCanceled = false
    inputData.data = ""

    return returnData
end

RegisterNuiCallback('confirmInput/submit', function(data, cb)
    inputData.receivedData = true
    inputData.value = true
    inputData.hasCanceled = false
    cb("OK")
end)

RegisterNuiCallback('confirmInput/cancel', function(data, cb)
    inputData.receivedData = true
    inputData.value = false
    inputData.hasCanceled = true
    cb("OK")
end)


exports('ConfirmInput', TS.Lib.ConfirmInput)
