fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Ranjit#6511'
description 'Knife Bank System'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/en.lua',
    'config.lua'
}

client_script 'client/client.lua'

server_scripts 'server/server.lua'

dependency {
    'qb-core',
    'qb-inventory',
    'qb-menu',
    'qb-target'
}
