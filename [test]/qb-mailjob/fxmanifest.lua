fx_version 'cerulean'
game 'gta5'

author 'Sinatra#0101'
description '919DESIGN Mail Carrier Job'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/mailjob.lua',
    'client/main.lua',
    'client/targets.lua',
}

server_scripts {
    'server/main.lua',
}