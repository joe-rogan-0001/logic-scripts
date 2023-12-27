fx_version 'cerulean'
game 'gta5'

description 'QB-SmallResources'
version '1.0.0'

shared_scripts {
    '@lrp-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
    'config.lua'
}
server_script 'server/*.lua'
client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/ComboZone.lua',
    'client/*.lua'
}


data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'
ui_page 'ui/index.html'

files {
	'events.meta',
	'relationships.dat',
	'ui/index.html'
}

exports {
	'HasHarness'
}

lua54 'yes'