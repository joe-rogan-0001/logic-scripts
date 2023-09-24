fx_version 'cerulean'
game 'gta5'



ui_page 'html/index.html'

shared_script 'config.lua'
client_script 'client/main.lua'
server_script 'server/main.lua'

server_exports {
    'AddHouseItem',
    'RemoveHouseItem',
    'GetInventoryData',
    'CanItemBeSaled'
}

files {
    'html/*'
}

lua54 'yes'