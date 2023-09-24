fx_version 'adamant'

game 'gta5'

ui_page 'html/ui.html'

client_scripts {
	'config.lua',
	'client/client.lua',
	'client/editable.lua',
	'client/animations.lua',
}

server_scripts {
    'config.lua',
	'server/editable.lua',
    'server/server.lua',
}

files {
	'html/ui.html',
	'html/moment.js',
	'html/script.js',
	'html/css/*.css',
	'html/images/phone-icons/*.png',
}
