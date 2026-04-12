fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'ts-lib'version '1.0.9'
description 'Toine Scripts Library'
author 'Toine'
contact 'store.toine.me'

--ui_page 'ui/build/index.html'
ui_page 'http://localhost:3000'

files {
    'import.lua',
    'shared/bridge/**/init.lua',
    'shared/bridge/**/**/*.lua',
    'ui/build/index.html',
    'ui/build/assets/*.*',
    'ui/build/assets/**/*.*',
    'ui/build/icons/*.*',
    'ui/build/icons/**/*.*',
}

shared_scripts {
    'config.lua',
    'shared/utils/*.lua',
    'shared/main_init.lua',
}

client_scripts {
    'modules/**/client.lua',
}

server_scripts {
    'modules/**/server.lua',
    'server/update_check.lua',
}
