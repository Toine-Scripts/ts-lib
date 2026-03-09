-- ts-lib | Update Checker
-- TS.CheckUpdate(versionUrl, changelogUrl?)
--   versionUrl   : URL returning a plain version string ("1.2.3") or JSON {"version":"x.y.z"}
--   changelogUrl : (optional) URL printed in the box as a "Changelog" link
-- Also exported: exports['ts-lib']:CheckUpdate(versionUrl, changelogUrl)

local function parseVersion(v)
    local parts = {}
    for n in (v .. '.'):gmatch('(%d+)%.') do
        parts[#parts + 1] = tonumber(n)
    end
    return parts
end

local function isOutdated(current, latest)
    local c = parseVersion(current)
    local l = parseVersion(latest)
    for i = 1, math.max(#c, #l) do
        local cv = c[i] or 0
        local lv = l[i] or 0
        if lv > cv then return true end
        if lv < cv then return false end
    end
    return false
end

-- Build box strings WITHOUT color codes so #str == visual width.
-- Width is computed dynamically from content so nothing ever gets truncated.
local LABEL_W = 10  -- width of the label column ("Current", "Latest", "Changelog")

local function buildBox(title, rows)
    -- Find the minimum width that fits every row
    local minW = #title + 4  -- title + 2 spaces each side
    for _, row in ipairs(rows) do
        local label, value = row[1], row[2]
        -- "  label      : value  " → 2 + LABEL_W + 4 + #value + 2
        local needed = 2 + LABEL_W + 4 + #value + 2
        if needed > minW then minW = needed end
    end

    local W = minW

    local function center(s)
        local p = W - #s
        return '║' .. string.rep(' ', math.floor(p / 2)) .. s .. string.rep(' ', math.ceil(p / 2)) .. '║'
    end

    local function row(label, value)
        local prefix = ('  %-' .. LABEL_W .. 's: '):format(label)
        local line = prefix .. value
        return '║' .. line .. string.rep(' ', W - #line) .. '║'
    end

    local border = '╔' .. string.rep('═', W) .. '╗'
    local sep    = '╠' .. string.rep('═', W) .. '╣'
    local bottom = '╚' .. string.rep('═', W) .. '╝'

    local lines = {}
    lines[#lines + 1] = '^7' .. border
    lines[#lines + 1] = '^7' .. center(title)
    lines[#lines + 1] = '^7' .. sep
    for _, r in ipairs(rows) do
        lines[#lines + 1] = '^7' .. row(r[1], r[2])
    end
    lines[#lines + 1] = '^7' .. bottom

    return lines
end

---Check for updates by fetching a version from a remote URL.
---Prints a coloured warning in the server console if outdated.
---@param versionUrl  string   URL returning a plain version string or JSON {"version":"x.y.z"}
---@param changelogUrl string? (optional) Changelog / update page URL shown in the box
TS.CheckUpdate = function(versionUrl, changelogUrl)
    if not versionUrl or versionUrl == '' then return end

    local resourceName   = GetCurrentResourceName()
    local currentVersion = GetResourceMetadata(resourceName, 'version', 0) or '1.0.0'

    PerformHttpRequest(versionUrl, function(statusCode, responseText, _)
        if statusCode ~= 200 or not responseText then
            print(('^3[%s] Update check failed (HTTP %s). Could not reach: %s^0')
                :format(resourceName, statusCode, versionUrl))
            return
        end

        local latestVersion = responseText:match('"version"%s*:%s*"[vV]?([%d%.]+)"')
                           or responseText:match('^%s*[vV]?([%d%.]+)%s*$')

        if not latestVersion then
            print(('^3[%s] Update check: could not parse version from response.^0'):format(resourceName))
            return
        end

        latestVersion = latestVersion:gsub('%s+', '')

        if isOutdated(currentVersion, latestVersion) then
            local title = resourceName .. ' — Update Available!'
            local rows = {
                { 'Current',   currentVersion },
                { 'Latest',    latestVersion  },
            }
            if changelogUrl and changelogUrl ~= '' then
                rows[#rows + 1] = { 'Changelog', changelogUrl }
            end

            local boxLines = buildBox(title, rows)
            print(' ')
            for _, line in ipairs(boxLines) do
                print(line .. '^0')
            end
            print(' ')
        else
            print(('^2[%s] Up to date (v%s).^0'):format(resourceName, currentVersion))
        end
    end, 'GET', '', { ['Content-Type'] = 'application/json' })
end

-- Export so other resources can call: exports['ts-lib']:CheckUpdate(versionUrl, changelogUrl)
exports('CheckUpdate', TS.CheckUpdate)

-- Auto-check for ts-lib itself on startup.
if GetCurrentResourceName() == 'ts-lib' then
    CreateThread(function()
        Wait(3000)
        local url = TS.Config and TS.Config.UpdateCheckURL
        if url and url ~= '' then
            TS.CheckUpdate(url, TS.Config.UpdateCheckChangelogURL)
        end
    end)
end
