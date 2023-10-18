fx_version 'cerulean'
description 'AV Boosting'
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

dependency 'ox_lib'
dependency '/assetpacks'