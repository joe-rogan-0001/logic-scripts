fx_version 'cerulean'
game 'gta5'

description 'QB-Garages'
version '1.0.0'

shared_script 'config.lua'
client_script {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
    'client/main.lua'
}

server_script {
    'server/main.lua',
    '@oxmysql/lib/MySQL.lua'
}

lua54 'yes'