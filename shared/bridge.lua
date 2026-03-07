TS.Bridge = {}

--- Check if a player has a specific permission
---@param source number
---@param permission string
---@return boolean
TS.Bridge.HasPermission = function(source, permission)
    -- Default fallback uses standard FiveM Aces
    return IsPlayerAceAllowed(source, permission)
end

-- Global namespaces for dynamically loaded bridges
TS.Bridge.Garage = {}
TS.Bridge.Keys = {}

--- Get a vehicle type based on a model string/hash
---@param model string|number
---@return string
TS.Bridge.GetVehicleType = function(model)
    -- Default fallback
    return 'automobile'
end
