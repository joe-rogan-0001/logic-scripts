fx_version 'cerulean'
game 'gta5'

name "Rep Scripts -QB ver Weed"
author "Q4D#1905"
version "2.0.1"

client_scripts {
	'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}
lua54 'yes'

escrow_ignore {
    'client/cl_functions.lua',  -- Only ignore one file
    'server/sv_functions.lua',
    'config.lua',
    'stream/anim@vx_watercan@garden.ycd',
    'stream/firesans.gfx',
    'README.MD',
    'INSTALL.md'
}
dependency '/assetpacks'