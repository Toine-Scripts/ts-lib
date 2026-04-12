TS_LIB_RESOURCE_NAME = 'ts-lib'

LoadFile = function(path)
    local file = LoadResourceFile(TS_LIB_RESOURCE_NAME, path)
    if file then
        assert(load(file, "@"..path))()
        return true
    end
    return false
end

local files = {
    'config.lua',
    'shared/utils/load.lua',
    'shared/utils/others.lua',
    'shared/utils/print.lua',
    'shared/utils/ressourceStates.lua',
    'shared/utils/intervals.lua',
    'shared/utils/table.lua',
    'shared/main_init.lua',
    'modules/command/server.lua',
}

for _, file in ipairs(files) do
    LoadFile(file)
end

TS_LIB_CONFIG = TS_LIB_CONFIG or Config

if not IsDuplicityVersion() then
    TS = TS or {}
    TS.Lib = TS.Lib or {}

    TS.Lib.Subtitle = TS.Lib.Subtitle or {}
    TS.Lib.TextUI = TS.Lib.TextUI or {}
    TS.Lib.Command = TS.Lib.Command or {}

    TS.Lib.Subtitle.Show = function(text)
        exports['ts-lib']:SendSubtitle(text)
    end

    TS.Lib.Subtitle.Hide = function()
        exports['ts-lib']:HideSubtitle()
    end

    TS.Lib.TextUI.Show = function(text, position)
        exports['ts-lib']:SendTextUI(text, position)
    end

    TS.Lib.TextUI.Hide = function()
        exports['ts-lib']:HideTextUI()
    end

    TS.Lib.TextInput = function(data)
        return exports['ts-lib']:TextInput(data)
    end
end

if IsDuplicityVersion() then
    TS = TS or {}
    TS.Lib = TS.Lib or {}
    TS.Lib.Command = TS.Lib.Command or {}
    TS.Bridge = TS.Bridge or {}

    TS.CheckUpdate = function(versionUrl, changelogUrl)
        exports['ts-lib']:CheckUpdate(versionUrl, changelogUrl)
    end

    TS.Bridge.GetPlayers = function()
        if Bridge and Bridge.Framework and Bridge.Framework.Server and Bridge.Framework.Server.Functions and Bridge.Framework.Server.Functions.GetPlayers then
            local success, players = Bridge.Framework.Server.Functions.GetPlayers()
            if success then
                return players
            end
        end
        return {}
    end

    TS.Bridge.HasPermission = function(source, permission)
        if Bridge and Bridge.Framework and Bridge.Framework.Server and Bridge.Framework.Server.Functions and Bridge.Framework.Server.Functions.HasPermission then
            return Bridge.Framework.Server.Functions.HasPermission(source, permission)
        end

        return IsPlayerAceAllowed(source, ('group.%s'):format(permission or 'admin'))
    end
end