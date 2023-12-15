shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'

game 'gta5'

shared_scripts {
    '@lrp-core/shared/locale.lua',
    'locales/en.lua', -- change en to your language
    'config.lua',
}

client_scripts{
    'client/*.lua',
}

server_scripts{
    'server/*.lua',
}
