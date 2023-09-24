fx_version 'cerulean'
games { 'gta5' }

shared_scripts {
    'lua/shared/sh_*.lua',
}

client_scripts {
    'lua/client/*.lua'
}

server_scripts {
    'lua/server/*.lua',
    '@oxmysql/lib/MySQL.lua'
}

server_exports {
    'AddTransaction',
    'GetTaxByType',
    'CalculateTax',
}

ui_page 'html/index.html'

files {
	'html/index.html',
    'html/app.js',
    'html/img/*.png',
    'html/img/*.jpg',
    'html/css/*.css'
}
