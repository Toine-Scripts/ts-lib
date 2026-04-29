Config = {}
Config.Framework = 'auto'
Config.Garages = 'auto'
Config.VehicleKeys = 'auto'
Config.Notify = 'auto'
Config.Target = 'auto'

Config.debug = true
Config.zUIFix = true -- Not needed anymore, auto detect zUI-v2

Config.UpdateCheckURL = 'https://raw.githubusercontent.com/toine-scripts/ts-lib/main/version.json'
Config.UpdateCheckChangelogURL = 'https://docs.toine.me/scripts/ts-lib/changelog'

Config.Data = {
    Framework = {
        ['qbcore'] = 'qb-core',
        ['esx'] = 'es_extended',
        ['qbox'] = 'qbx_core',
        ['standalone'] = 'standalone',
    },
    Garages = {
        ['qb-garages'] = 'qb-garages',
        ['esx_garage'] = 'esx_garage',
        ['vms_garagesv2'] = 'vms_garagesv2',
        ['jg-advancedgarages'] = 'jg-advancedgarages',
        ['standalone'] = 'standalone',
    },
    VehicleKeys = {
        ['qb-vehiclekeys'] = 'qb-vehiclekeys',
        ['qs-vehiclekeys'] = 'qs-vehiclekeys',
        ['lfKeys'] = 'lfKeys',
        ['standalone'] = 'standalone',
    },
    Notify = {
        ['qbcore'] = 'qb-core',
        ['esx'] = 'esx_notify',
        -- Add more notify systems here
    },

    Target = {
        ['qb-target'] = 'qb-target',
        ['ox_target'] = 'ox_target',
        
    },
}
        