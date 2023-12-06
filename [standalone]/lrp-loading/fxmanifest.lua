fx_version 'cerulean'
author 'Haiku'
description 'Logic Roleplay loading screen'
version '1.0.0'
loadscreen_cursor 'yes'
game 'gta5'
loadscreen 'html/index.html'
lua54 'yes'
loadscreen_manual_shutdown "yes"

files {
    'html/index.html',
    'html/logo.png',
    'html/index.css',
    'html/index.js',
    'html/img/bkg.png',
    'html/song.mp3'
}

client_script 'client.lua'
server_script 'server.lua'
