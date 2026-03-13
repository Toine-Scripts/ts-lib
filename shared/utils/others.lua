Utils = Utils or {}

Utils.IsServer = function()
    return IsDuplicityVersion()
end

Utils.ErrorHandler = function(err)
    Utils.ErrorPrint('An error occurred: ' .. err)
    Utils.Print(debug.traceback())
    Utils.PrintContact()
    return false, err
end

Utils.IsTableEmpty = function(table)
    if not tbl then
        return true
    end

    return next(tbl) == nil
end
