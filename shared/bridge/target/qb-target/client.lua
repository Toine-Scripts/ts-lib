Bridge.Target.Client.Functions.AddTargetToEntity = function(entity, options, distance)
    if not entity or not options then
        return Utils.ErrorPrint('No entity or options provided')
    end

    if not DoesEntityExist(entity) then
        return Utils.ErrorPrint('Entity does not exist')
    end

    local targetOptions = {}

    for _, option in pairs(options) do
        table.insert(targetOptions, {
            num = option.id,
            icon = option.icon,
            label = option.label,
            targeticon = option.targeticon,
            item = option.item,
            action = option.action,
            canInteract = option.canInteract,
            job = option.job,
            gang = option.gang,
            citizenid = option.citizenid
        })
    end

    exports['qb-target']:AddTargetEntity(entity, {
        options = targetOptions,
        distance = distance or 2.0
    })
end


Bridge.Target.Client.Functions.RemoveTargetFromEntity = function(entity)
    if not entity then
        return Utils.ErrorPrint('No entity provided')
    end

    if not DoesEntityExist(entity) then
        return Utils.ErrorPrint('Entity does not exist')
    end

    exports['qb-target']:RemoveTargetEntity(entity)

    Utils.DebugPrint('Target removed from entity: ' .. entity)
end