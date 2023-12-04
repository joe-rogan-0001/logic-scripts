fx_version 'adamant'
game 'gta5'
lua54 'yes'





author 'Haiku'
description 'Temporary pawnshop with sf-houserobbery items'
version '6.9'






shared_scripts{
    '@ox_lib/init.lua',
}

files {
    'locales/*.json'
}

client_scripts{
    'config.lua',
    'client/main.lua',
}

server_scripts{
    'server/main.lua',
    'config.lua'
}