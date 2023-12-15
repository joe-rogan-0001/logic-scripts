shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'


ui_page 'html/ui.html'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'html/ui.html',
    'html/ui.css',
    'html/ui.js',
    'html/icon.png',
}

lua54 'yes'