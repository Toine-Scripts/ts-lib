Utils = Utils or {}

Utils.IsResourceStarted = function(resourceName)
    return GetResourceState(resourceName) == 'started' or GetResourceState(resourceName) == 'starting'
end