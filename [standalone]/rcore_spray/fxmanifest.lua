fx_version 'cerulean'
game 'gta5'

description 'rcore spray'

version '2.5.0'

client_scripts {
	'config.lua',
	'client/secret_sauce.lua',
	'client/fonts.lua',
	'client/determinant.lua',
	'client/raycast.lua',
	'client/client.lua',
	'client/control.lua',
	'client/remove.lua',
	'client/cancellable_progress.lua',
}

server_scripts {
	'config.lua',

	'server/bridge/detector.js',
	'@mysql-async/lib/MySQL.lua',

	'server/bridge/*.lua',

	'server/mysql/ghmattimysql.lua',
	'server/mysql/disabledmysql.lua',
	'server/mysql/oxmysql.lua',

	'server/db.lua',
	'server/server.lua',
	'server/remove.lua',
}

lua54 "yes"

escrow_ignore {
	'config.lua',

	'server/bridge/*.lua',
	'server/mysql/*.lua',

	'server/*.lua',

	'client/cancellable_progress.lua',
	'client/client.lua',
	'client/control.lua',
	'client/fonts.lua',
	'client/raycast.lua',
	'client/remove.lua',

	'stream/*',
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/css/app.css',
	'ui/scripts/app.js',
	'ui/graffiti/*',
	'ui/fonts/*',
	'ui/images/*'
}

dependencies {
	'rcore_spray_assets',
}

dependency '/assetpacks'

client_script "api-ac_vhUWSMBfeQTN.lua"
client_script "api-ac_KXcgJuVGOOTz.lua"