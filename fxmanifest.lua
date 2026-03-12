fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ts-lib'
version '1.0.3'
description 'Toine Scripts Library'
author 'Toine'
contact 'store.toine.me'

ui_page 'ui/build/index.html'
--ui_page 'http://localhost:3000'

files {
    'imports.lua',
    'lib/*.lua',
    'modules/**/*.lua',
    'shared/*.lua',
    'bridge/framework/**/*.lua',
    'bridge/garage/**/*.lua',
    'bridge/keys/**/*.lua',
    "ui/build/index.html",
    "ui/build/assets/*.*",
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/init.lua',
    'shared/config.lua',
    'shared/utils.lua',
    'shared/events.lua'
}

client_scripts {
    'bridge/framework/detect.lua',
    'bridge/framework/**/client.lua',

    'modules/**/client.lua'
}

server_scripts {
    'server/sv_version.lua'
}

dependency {
    'oxmysql', 
    'ox_lib' 
}
