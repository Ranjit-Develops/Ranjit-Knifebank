fx_version   'cerulean'
game         'gta5'

author          'Ranjit#6511'
description     'Knife Bank System'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'lang/en.lua'
}

client_script 'client.lua'

server_scripts {
    'server.lua',
    'config.lua'
}

dependency 'qb-core'
dependency 'qb-inventory'
dependency 'qb-menu'
dependency 'qb-target'