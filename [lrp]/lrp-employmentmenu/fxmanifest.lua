fx_version 'cerulean'
game 'gta5'


client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    'config.lua',
    'client.lua'
}

server_script {
    'server.lua',
    '@oxmysql/lib/MySQL.lua'
}
server_export 'GetAccount'

lua54 'yes'