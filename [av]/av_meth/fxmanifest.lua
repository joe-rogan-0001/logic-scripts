fx_version 'cerulean'
description 'AV Meth'
author 'Avilchiis'
version '1.0.0'
lua54 'yes'
games {
'gta5' 
}

ui_page 'web/build/index.html'

shared_scripts {
'@ox_lib/init.lua',
-- '@es_extended/imports.lua', -- Uncomment this if you are using latest ESX
'config/*.lua'
}

client_scripts {
'client/**/*',
} 

server_scripts {
'@oxmysql/lib/MySQL.lua',
'server/**/*'
}

files {
 'web/build/index.html',
 'web/build/**/*',
}

escrow_ignore {
'config/*.lua',
'client/framework/*.lua',
'server/framework/*.lua'
}
dependency '/assetpacks'