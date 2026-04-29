if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

local inputData = {
    receivedData = false,
    hasCanceled = false,
    data = "",
}

local zUI = nil
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == 'zUI-v2' then
        zUI = exports["zUI-v2"]:getObject()
    end
end)

TS.Lib.TextInput = {}

TS.Lib.TextInput = function(data)
    local defaultData = {
        title = "Text Input",
        placeholder = "Enter text",
        type = "text", -- text, number, password
        value = "",
    }

    data = table.merge(defaultData, data)

    SendNUIMessage({
        module = 'textInput',
        data = data
    })

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(false)

    local anyIsOpen = false

    if zUI then
        anyIsOpen = zUI.IsAnyMenuOpen()
        if anyIsOpen then
            zUI.ManageFocus(false)
            SetNuiFocus(true, true)
            SetNuiFocusKeepInput(false)
        end
    end

    Wait(100)

    SetNuiFocus(true, true)
    SetNuiFocusKeepInput(false)

    while not inputData.receivedData do
        Wait(0)
    end

    SetNuiFocus(false, false)
    SetNuiFocusKeepInput(false)

    if zUI and anyIsOpen then
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

RegisterNuiCallback('textInput/submit', function(data, cb)
    inputData.receivedData = true
    inputData.data = data.value
    inputData.hasCanceled = false
    cb("OK")
end)

RegisterNuiCallback('textInput/cancel', function(data, cb)
    inputData.receivedData = true
    inputData.data = ""
    inputData.hasCanceled = true
    cb("OK")
end)


exports('TextInput', TS.Lib.TextInput)
