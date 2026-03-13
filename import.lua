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
    'shared/main_init.lua',
}

for _, file in ipairs(files) do
    LoadFile(file)
end

TS_LIB_CONFIG = TS_LIB_CONFIG or Config

-- UI helpers proxy
if not IsDuplicityVersion() then
    TS = TS or {}
    TS.Lib = TS.Lib or {}

    TS.Lib.Subtitle = TS.Lib.Subtitle or {}
    TS.Lib.TextUI = TS.Lib.TextUI or {}

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
end

-- Update checker (server only): TS.CheckUpdate(versionUrl, changelogUrl?)
-- versionUrl must return JSON {"version":"x.y.z"}
if IsDuplicityVersion() then
    TS = TS or {}
    TS.CheckUpdate = function(versionUrl, changelogUrl)
        exports['ts-lib']:CheckUpdate(versionUrl, changelogUrl)
    end
end