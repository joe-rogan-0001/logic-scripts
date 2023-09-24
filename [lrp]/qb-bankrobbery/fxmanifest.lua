fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Lionh34rt#4305'
description 'Reworked bank robbery script for QBCore'
version '3.0'

dependencies {
    'PolyZone',
    'lrp-target',
    'mka-lasers'
}

shared_script 'shared/sh_config.lua'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@mka-lasers/client/client.lua',
    'client/cl_*.lua'
}

server_scripts {
    'server/sv_*.lua'
}
