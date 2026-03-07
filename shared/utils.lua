TS.Utils = {}

--- Check whether a resource is loaded
---@param resourceName string
---@return boolean
TS.Utils.IsRessourceLoaded = function(resourceName)
    if not resourceName then resourceName = GetCurrentResourceName() end
    return GetResourceState(resourceName) == "started"
end

TS.Utils.Colors = {
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

--- Print a standard TS Persistence client message
---@param message string
---@return nil
TS.Utils.Print = function(message, ressourceName)
    local c = TS.Utils.Colors
    local ressourceName = ressourceName or GetCurrentResourceName()
    print(('%s[%s]%s %s'):format(c.cyan, ressourceName, c.reset, message))
end

TS.Print = TS.Utils.Print

--- Print a debug message when debug mode is enabled
---@param message string
---@return nil
TS.Utils.DebugPrint = function(message, ressourceName)
    if TS.Config.debug then
        local c = TS.Utils.Colors
        local ressourceName = ressourceName or GetCurrentResourceName()
        print(('%s[%s]%s %s[DEBUG]%s %s'):format(c.cyan, ressourceName, c.reset, c.yellow, c.reset, message))
    end
end

--- Print a success message
---@param message string
---@return nil
TS.Utils.SuccessPrint = function(message, ressourceName)
    local c = TS.Utils.Colors
    local ressourceName = ressourceName or GetCurrentResourceName()
    print(('%s[%s]%s %s%s%s'):format(c.cyan, ressourceName, c.reset, c.green, message, c.reset))
end

--- Print an error message
---@param message string
---@return nil
TS.Utils.ErrorPrint = function(message, ressourceName)
    local c = TS.Utils.Colors
    local ressourceName = ressourceName or GetCurrentResourceName()
    print(('%s[%s]%s %s%s%s'):format(c.cyan, ressourceName, c.reset, c.red, message, c.reset))
end

--- Print contact information for support
---@return nil
TS.Utils.PrintContact = function()
    TS.Utils.Print('Contact support on discord: https://store.toine.me/discord')
end

--- Generic error handler that prints stack trace and support contact
---@param err string
---@return nil
TS.Utils.ErrorHandler = function(err)
    TS.Utils.ErrorPrint('An error occurred: ' .. err)
    TS.Utils.Print(debug.traceback())
    TS.Utils.PrintContact()
end

TS.DebugPrint = TS.Utils.DebugPrint
TS.SuccessPrint = TS.Utils.SuccessPrint
TS.ErrorPrint = TS.Utils.ErrorPrint
TS.PrintContact = TS.Utils.PrintContact

TS.ErrorHandler = TS.Utils.ErrorHandler

--- Check whether a table is empty
---@param tbl table?
---@return boolean
TS.Utils.IsTableEmpty = function(tbl)
    if not tbl then
        return true
    end

    return next(tbl) == nil
end

TS.Utils.IsRessourceLoaded = function(resourceName)
    return GetResourceState(resourceName) == "started"
end