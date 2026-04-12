Bridge.Target.Client.Functions.AddTargetToEntity = function(entity, options, distance)
    if not entity or not options then
        return Utils.ErrorPrint('No entity or options provided')
    end

    if not DoesEntityExist(entity) then
        return Utils.ErrorPrint('Entity does not exist')
    end

    local maxDistance = distance or 2.0
    local targetOptions = {}
    local index = 0

    for _, option in pairs(options) do
        index = index + 1
        local name = option.name or ('ts_bridge_target_%s'):format(option.id or index)

        local oxOption = {
            name = name,
            label = option.label,
            icon = option.icon,
            distance = option.distance or maxDistance,
        }

        if option.canInteract then
            oxOption.canInteract = function(entityHit, _dist, _endCoords, _optName, _bone)
                return option.canInteract(entityHit)
            end
        end

        if option.action then
            oxOption.onSelect = function(data)
                local ent = type(data) == 'table' and data.entity or data
                return option.action(ent)
            end
        end

        if option.groups then
            oxOption.groups = option.groups
        elseif option.job then
            oxOption.groups = option.job
        elseif option.gang then
            oxOption.groups = option.gang
        end

        if option.items then
            oxOption.items = option.items
        elseif option.item then
            oxOption.items = option.item
        end

        targetOptions[#targetOptions + 1] = oxOption
    end

    if NetworkGetEntityIsNetworked(entity) then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        if NetworkDoesNetworkIdExist(netId) then
            exports.ox_target:addEntity(netId, targetOptions)
            return
        end
    end

    exports.ox_target:addLocalEntity(entity, targetOptions)
end


Bridge.Target.Client.Functions.RemoveTargetFromEntity = function(entity)
    if not entity then
        return Utils.ErrorPrint('No entity provided')
    end

    if not DoesEntityExist(entity) then
        return Utils.ErrorPrint('Entity does not exist')
    end

    if NetworkGetEntityIsNetworked(entity) then
        local netId = NetworkGetNetworkIdFromEntity(entity)
        if NetworkDoesNetworkIdExist(netId) then
            exports.ox_target:removeEntity(netId)
            Utils.DebugPrint('Target removed from entity (netId): ' .. netId)
            return
        end
    end

    exports.ox_target:removeLocalEntity(entity)
    Utils.DebugPrint('Target removed from local entity: ' .. entity)
end
