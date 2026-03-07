TS.FrameworkName = nil
TS.FrameworkObject = nil

if TS.Config.Framework == 'auto' then
    if TS.Utils.IsRessourceLoaded('qbx_core') then
        TS.FrameworkName = 'qbx_core'
        TS.FrameworkObject = exports['qbx_core']:GetCoreObject()
        if TS.Debug then TS.Debug('qbx_core detected') end
    elseif TS.Utils.IsRessourceLoaded('qb-core') then
        TS.FrameworkName = 'qb-core'
        TS.FrameworkObject = exports['qb-core']:GetCoreObject()
        if TS.Debug then TS.Debug('qb-core detected') end
    elseif TS.Utils.IsRessourceLoaded('es_extended') then
        TS.FrameworkName = 'es_extended'
        TS.FrameworkObject = exports['es_extended']:getSharedObject()
        if TS.Debug then TS.Debug('es_extended detected') end
    else
        TS.FrameworkName = 'standalone'
        if TS.Debug then TS.Debug('No framework detected, running standalone') end
    end
else
    TS.FrameworkName = TS.Config.Framework
    if TS.FrameworkName == 'qbx_core' and TS.Utils.IsRessourceLoaded('qbx_core') then
        TS.FrameworkObject = exports['qbx_core']:GetCoreObject()
    elseif TS.FrameworkName == 'qb-core' and TS.Utils.IsRessourceLoaded('qb-core') then
        TS.FrameworkObject = exports['qb-core']:GetCoreObject()
    elseif TS.FrameworkName == 'es_extended' and TS.Utils.IsRessourceLoaded('es_extended') then
        TS.FrameworkObject = exports['es_extended']:getSharedObject()
    end
    if TS.Debug then TS.Debug(TS.FrameworkName .. ' forced via config') end
end

TS.On('playerloaded', function()
    print('playerloaded')
end)