if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

local inputData = {
    receivedData = false,
    hasCanceled = false,
    data = "",
}

local zUI = nil

if Config.zUIFix then
    zUI = exports["zUI-v2"]:getObject()
end

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
