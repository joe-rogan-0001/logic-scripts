fx_version 'cerulean'
game 'gta5'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
	'config.lua',
	'client/main.lua'
    
}

server_script {
    'server/main.lua',
    'server/blueprints.lua',
    '@oxmysql/lib/MySQL.lua'
}

lua54 'yes'