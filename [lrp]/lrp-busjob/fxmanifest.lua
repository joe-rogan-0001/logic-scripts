shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

description 'QB-BusJob'
version '1.0.0'

shared_scripts {
    '@lrp-core/shared/locale.lua',
	'locales/en.lua',
    'config.lua'
}

client_script 'client/main.lua'

server_script 'server/main.lua'

lua54 'yes'
