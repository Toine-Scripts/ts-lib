fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ts-lib'
version '1.0.0'
description 'Toine Scripts Library'
author 'Toine'
contact 'store.toine.me'

files {
    'imports.lua',
    'lib/*.lua',
    'modules/**/*.lua',
    'shared/*.lua',
    'bridge/framework/**/*.lua',
    'bridge/garage/**/*.lua',
    'bridge/keys/**/*.lua'
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
}

server_scripts {
    'server/sv_version.lua'
}

escrow_ignore {
  
}

dependency {
    'oxmysql', -- You can remove this if you don't use oxmysql
    'ox_lib' -- You need to keep this if you use certain features of this lib
}
