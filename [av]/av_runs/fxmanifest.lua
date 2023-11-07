fx_version 'cerulean'
description 'AV Drug Runs'
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
'server/**/*'
}

escrow_ignore { 
'config/*.lua',
'client/framework/*.lua',
'server/framework/*.lua',
}

dependencies {
    'ox_lib',
    'ps-ui',
}
dependency '/assetpacks'