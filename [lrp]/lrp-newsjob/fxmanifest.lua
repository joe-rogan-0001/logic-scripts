shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'



shared_script 'config.lua'

client_scripts {
    'client/main.lua',
    'client/camera.lua',
}

server_script 'server/main.lua'

lua54 'yes'