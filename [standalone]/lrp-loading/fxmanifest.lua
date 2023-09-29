fx_version 'cerulean'
games { 'gta5' }

description 'lj-loading'
version '1.3'
author 'github.com/loljoshie'

-- Tell server we will close the loading screen resource ourselves
loadscreen_manual_shutdown "yes"

files {
	'ui.html',
	'html/*',
	'assets/*',
}

loadscreen {
	'ui.html'
}