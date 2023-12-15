shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

client_scripts {
    'client/cl_*.lua',
}

files {
    'html/index.html',
    'html/*.css',
    'html/src/*.js',
    'html/assets/*.png',
    'html/assets/*.mp3'
}

exports {
    'OpenHackingGame',
    'GetHackingStatus',
}