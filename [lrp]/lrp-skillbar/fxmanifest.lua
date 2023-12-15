shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

description 'lrp-skillbar'
version '1.0.0'

ui_page "html/index.html"

client_script 'client/main.lua'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/VerdanaBold.ttf'
}

exports {
    'GetSkillbarObject'
}

dependencies {
    'lrp-core'
}

lua54 'yes'