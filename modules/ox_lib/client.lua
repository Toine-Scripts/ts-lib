-- TS-Lib Wrapper for ox_lib (Client)
if not TS then TS = {} end
if not TS.Lib then TS.Lib = {} end

---@class TS.Lib.Grid
TS.Lib.Grid = {}

--- Add an entry to the grid
---@param data table The entry data containing coords
---@return number entryId The ID of the new entry
TS.Lib.Grid.AddEntry = function(data)
    return lib.grid.addEntry(data)
end

--- Remove an entry from the grid
---@param id number The entry ID to remove
TS.Lib.Grid.RemoveEntry = function(id)
    return lib.grid.removeEntry(id)
end

--- Get nearby entries from the grid
---@param coords vector3 The coordinates to check from
---@param cb function Filter callback
---@return table entries
TS.Lib.Grid.GetNearbyEntries = function(coords, cb)
    return lib.grid.getNearbyEntries(coords, cb)
end

--- Trigger a cache callback
---@param key string The cache key
---@param cb function Callback function
TS.Lib.OnCache = function(key, cb)
    lib.onCache(key, cb)
end

---@class TS.Lib.Vehicle
TS.Lib.Vehicle = {}

--- Get vehicle properties
---@param vehicle number Vehicle entity
---@return table properties
TS.Lib.Vehicle.GetProperties = function(vehicle)
    return lib.getVehicleProperties(vehicle)
end

--- Set vehicle properties
---@param vehicle number Vehicle entity
---@param props table Properties to apply
TS.Lib.Vehicle.SetProperties = function(vehicle, props)
    lib.setVehicleProperties(vehicle, props)
end
