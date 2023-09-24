-------------------------------
---------- CASE#2506 ----------
-------------------------------

fx_version 'cerulean'

game 'gta5'

author 'case#2506'
description 'BOII | Development - Salvage Driving Script'
version '0.2'

lua54 'yes'

shared_scripts {
    'config.lua',
}

client_scripts{
    'client/*.lua',
}
server_scripts{
    'server/*.lua',
}
escrow_ignore {
    'client/*.lua',
    'server/*.lua',
    'config.lua',
}
dependency '/assetpacks'