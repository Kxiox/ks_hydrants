fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Kxiox'
description 'Hydrants script - Kxiox Scripts'
version '1.0'

client_scripts {
    'client/main.lua',
    'client/destroyer.lua',
    'client/main.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
    'shared/list.lua',
    'shared/locales.lua',
    'shared/config.lua',
}

server_scripts {
    'server/destroyer.lua'
}

dependencies {
    'ox_lib'
}