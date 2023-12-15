shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version "adamant"

game "gta5"

description 'qb-pursuitmode'

client_scripts { 
    "config.lua", 
    "handling.lua", 
    "client.lua" 
}

exports {
    'GetVehicleMode',
}