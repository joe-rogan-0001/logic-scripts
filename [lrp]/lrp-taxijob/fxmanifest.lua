fx_version 'cerulean'
game 'gta5'

description 'QB-TaxiJob'
version '1.0.0'

ui_page 'html/meter.html'

shared_scripts {
    '@lrp-core/shared/locale.lua',
    'locales/en.lua', -- Change to the language you want to use
    'config.lua',
}

client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'html/meter.css',
    'html/meter.html',
    'html/meter.js',
    'html/reset.css',
    'html/g5-meter.png'
}

lua54 'yes'