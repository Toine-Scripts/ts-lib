TS.Config = {
    debug = true,

    -- Update checker
    -- Point this to any URL that returns a plain version string (e.g. "1.2.3")
    -- or a JSON object with a "version" key (e.g. {"version":"1.2.3"}).
    -- Set to '' or nil to disable the update check.
    UpdateCheckURL = 'https://raw.githubusercontent.com/toine-scripts/ts-lib/main/version.txt',
    UpdateCheckChangelogURL = 'https://store.toine.me/download/ts-lib', -- Optional: link shown in the console box when outdated

    -- Active systems
    Framework = 'auto', -- 'auto', 'qb-core', 'qbx_core', 'es_extended', 'standalone'
    Garage = 'qb-garages', -- 'qb-garages', 'esx_garage', 'vms_garagesv2', 'jg-advancedgarages', 'standalone'
    KeysSystem = 'qb-vehiclekeys', -- 'qb-vehiclekeys', 'qs-vehiclekeys', 'standalone'
}