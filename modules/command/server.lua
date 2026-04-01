if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

TS.Lib.Command = TS.Lib.Command or {}

-- Based on https://github.com/CommunityOx/ox_lib/blob/main/imports/addCommand/server.lua
-- Copyright © 2025 Linden <https://github.com/thelindat>
-- This file is licensed under LGPL-3.0 or higher <https://www.gnu.org/licenses/lgpl-3.0.en.html>

---@class TsCommandParams
---@field name string
---@field help? string
---@field type? 'number' | 'playerId' | 'string' | 'longString' | 'boolean'
---@field optional? boolean

---@class TsCommandProperties
---@field help? string
---@field params? TsCommandParams[]
---@field restricted? boolean | string | string[]

---@type TsCommandProperties[]
local registeredCommands = {}
local shouldSendCommands = false

SetTimeout(1000, function()
    shouldSendCommands = true
    TriggerClientEvent('chat:addSuggestions', -1, registeredCommands)
end)

AddEventHandler('playerJoining', function()
    TriggerClientEvent('chat:addSuggestions', source, registeredCommands)
end)

---@param source number
---@param args table
---@param raw string
---@param params TsCommandParams[]?
---@return table?
local function parseArguments(source, args, raw, params)
    if not params then return args end

    local paramsNum = #params
    for i = 1, paramsNum do
        local arg, param = args[i], params[i]
        local value

        if param.type == 'number' then
            value = tonumber(arg)
        elseif param.type == 'boolean' then
            local lower = type(arg) == 'string' and string.lower(arg) or arg
            if lower == true or lower == 'true' or lower == '1' or lower == 1 or lower == 'yes' or lower == 'on' then
                value = true
            elseif lower == false or lower == 'false' or lower == '0' or lower == 0 or lower == 'no' or lower == 'off' then
                value = false
            else
                value = nil
            end
        elseif param.type == 'string' then
            value = not tonumber(arg) and arg
        elseif param.type == 'playerId' then
            value = arg == 'me' and source or tonumber(arg)

            if not value or not DoesPlayerExist(tostring(value)) then
                value = false
            end
        elseif param.type == 'longString' and i == paramsNum then
            if arg then
                local start = raw:find(arg, 1, true)
                value = start and raw:sub(start)
            else
                value = nil
            end
        else
            value = arg
        end

        if not value and (not param.optional or (param.optional and arg)) then
            local cmd = (raw:match('^(%S+)') or raw or 'unknown'):gsub('^/', '')
            Citizen.Trace(("^1command '%s' received an invalid %s for argument %s (%s), received '%s'^0\n"):format(
                cmd,
                param.type or 'value',
                i,
                param.name or ('arg' .. i),
                tostring(arg)
            ))
            return nil
        end

        args[param.name] = value
        args[i] = nil
    end

    return args
end

---@param commandName string | string[]
---@param properties TsCommandProperties | false
---@param cb fun(source: number, args: table, raw: string)
function TS.Lib.Command.add(commandName, properties, cb)
    local restricted, params

    if properties then
        restricted = properties.restricted
        params = properties.params
    end

    if params then
        for i = 1, #params do
            local param = params[i]
            if param.type then
                param.help = param.help and ('%s (type: %s)'):format(param.help, param.type) or ('(type: %s)'):format(param.type)
            end
        end
    end
    
    if Config and Config.Debug then
        local okProps, propsStr = pcall(json.encode, properties)
        local okRestricted, restrictedStr = pcall(json.encode, restricted)
        local okParams, paramsStr = pcall(json.encode, params)

        Utils.Print('Adding command: ' .. tostring(commandName))
        Utils.Print('Properties: ' .. (okProps and propsStr or tostring(properties)))
        Utils.Print('Callback: ' .. tostring(cb))
        Utils.Print('Restricted: ' .. (okRestricted and restrictedStr or tostring(restricted)))
        Utils.Print('Params: ' .. (okParams and paramsStr or tostring(params)))
    end

    local commands = type(commandName) ~= 'table' and { commandName } or commandName
    local numCommands = #commands
    local totalCommands = #registeredCommands

    local function commandHandler(source, args, raw)
        local parsedArgs = parseArguments(source, args, raw, params)
        if not parsedArgs then return end

        local success, resp = pcall(cb, source, parsedArgs, raw)
        if not success then
            local cmd = (raw:match('^(%S+)') or raw or 'unknown'):gsub('^/', '')
            Citizen.Trace(("^1command '%s' failed to execute!\n%s^0\n"):format(cmd, tostring(resp)))
        end
    end

    for i = 1, numCommands do
        totalCommands = totalCommands + 1
        local currentCommand = commands[i]

        RegisterCommand(currentCommand, commandHandler, restricted and true)

        if restricted then
            local ace = ('command.%s'):format(currentCommand)
            local restrictedType = type(restricted)

            if restrictedType == 'string' then
                if not IsPrincipalAceAllowed(restricted, ace) and TS.Lib.Ace and TS.Lib.Ace.add then
                    TS.Lib.Ace.add(restricted, ace)
                end
            elseif restrictedType == 'table' then
                for j = 1, #restricted do
                    if not IsPrincipalAceAllowed(restricted[j], ace) and TS.Lib.Ace and TS.Lib.Ace.add then
                        TS.Lib.Ace.add(restricted[j], ace)
                    end
                end
            end
        end

        if properties then
            local commandProperties = {}
            for k, v in pairs(properties) do
                commandProperties[k] = v
            end

            commandProperties.name = ('/%s'):format(currentCommand)
            commandProperties.restricted = nil
            registeredCommands[totalCommands] = commandProperties

            if shouldSendCommands then
                TriggerClientEvent('chat:addSuggestions', -1, commandProperties)
            end
        end
    end
end

TS.Lib.Command.addCommand = TS.Lib.Command.add

return TS.Lib.Command.add