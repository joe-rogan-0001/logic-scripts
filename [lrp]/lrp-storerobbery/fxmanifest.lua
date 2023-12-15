shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'



ui_page 'html/index.html'

shared_script 'config.lua'
client_script 'client/*.lua'
server_script 'server/*.lua'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css'
}

lua54 'yes'