Utils = Utils or {}

Utils.Colors = {
    -- FiveM Colors
    redOrange = '^1',
    lightGreen = '^2',
    lightYellow = '^3',
    darkBlue = '^4',
    lightBlue = '^5',
    violet = '^6',
    white = '^7',
    bloodRed = '^8',
    fuchsia = '^9',

    -- Formatting
    bold = '^*',
    underline = '^_',
    strikethrough = '^~',
    underlineStrikethrough = '^=',
    boldUnderlineStrikethrough = '^*^=',

    -- Control
    reset = '^7',

    -- Compatibility aliases
    cyan = '^5',
    yellow = '^3',
    green = '^2',
    red = '^8',
}

Utils.Print = function(message, ressourceName)
    local c = Utils.Colors
    local ressourceName = ressourceName or GetCurrentResourceName()
    print(('%s[%s]%s %s'):format(c.cyan, ressourceName, c.reset, message))
end

Utils.DebugPrint = function(message, ressourceName)
    local debug = false

    if TS_LIB_CONFIG and TS_LIB_CONFIG.debug ~= nil then
        debug = TS_LIB_CONFIG.debug
    end

    if Config then
        if Config.Server and Config.Server.debug ~= nil then
            debug = Config.Server.debug
        end
        if Config.Client and Config.Client.debug ~= nil then
            debug = Config.Client.debug
        end
        if Config.debug ~= nil then
            debug = Config.debug
        end
    end

    if debug then
        local c = Utils.Colors
        local ressourceName = ressourceName or GetCurrentResourceName()
        print(('%s[%s]%s %s[DEBUG]%s %s'):format(c.cyan, ressourceName, c.reset, c.yellow, c.reset, message))
    end
end

Utils.SuccessPrint = function(message, ressourceName)
    local c = Utils.Colors
    local ressourceName = ressourceName or GetCurrentResourceName()
    print(('%s[%s]%s %s%s%s'):format(c.cyan, ressourceName, c.reset, c.green, message, c.reset))
end

Utils.ErrorPrint = function(message, ressourceName)
    local c = Utils.Colors
    local ressourceName = ressourceName or GetCurrentResourceName()
    print(('%s[%s]%s %s%s%s'):format(c.cyan, ressourceName, c.reset, c.red, message, c.reset))
end

Utils.PrintContact = function()
    Utils.Print('Contact support on discord: https://store.toine.me/discord')
end
