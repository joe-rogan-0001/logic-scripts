fx_version 'cerulean'
game 'gta5'

edited 'kevin'
description 'QB-RadialMenu'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    '@lrp-core/shared/locale.lua',
    'locales/en.lua' -- Change this to your preferred language
}

client_scripts {
    'client/blips.lua',
    'client/main.lua',
    'client/clothing.lua',
    'client/trunk.lua',
    'client/stretcher.lua'
}

server_scripts {
    'server/trunk.lua',
    'server/stretcher.lua'
}

files {
    'html/index.html',
    'html/css/main.css',
    'html/js/main.js',
    'html/js/RadialMenu.js',
}

lua54 'yes'