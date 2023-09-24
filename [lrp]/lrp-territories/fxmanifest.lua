fx_version 'cerulean'
game 'gta5'
author 'QP scripts - Territories'

lua54 'yes'

escrow_ignore {
    'config.lua',
    'colors-rgb.lua',
}

shared_script {
    --'@qb-core/import.lua', --descoment it if you want to use the config importSharedConfigQBCoreObject = true
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'utils.lua',
    'colors-rgb.lua',
    'client/main.lua',
}


server_scripts {
    --'@oxmysql/lib/MySQL.lua', --use it if you have the oxmysql latest version
    'utils.lua',
    'server/main.lua',
}

dependencies {
	'lrp-core',
	'lrp-target',
    'PolyZone',
}