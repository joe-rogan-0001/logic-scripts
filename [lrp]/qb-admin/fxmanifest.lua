fx_version 'cerulean'
game 'gta5'

author 'Sinatra#0101'
description '919DESIGN Admin Panel'
version '1.5.1'
lua54 'yes'

ui_page 'html/index.html'

escrow_ignore {
    'config.lua',
    'server/main.lua',
    'server/adminactions.lua',

    -- NoClip Stuff
    'client/freecam/utils.lua',
    'client/freecam/config.lua',
    'client/freecam/camera.lua',
    'client/freecam/main.lua',
    'client/noclip_new.lua',
}

files {
	'html/**',
    'json/reports.json',
}

shared_scripts {
	'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/adminactions.lua',
}

client_scripts {
    'client/main.lua',
    'client/functions.lua',
    'client/freecam/utils.lua',
    'client/freecam/config.lua',
    'client/freecam/camera.lua',
    'client/freecam/main.lua',
    'client/noclip_new.lua',
}

dependencies { 'lrp-core', 'oxmysql' }
dependency '/assetpacks'