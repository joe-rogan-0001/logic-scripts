fx_version "cerulean"
games {"gta5"}

ui_page "client/ui/html/index.html"

files {
  "client/ui/html/index.html", 
  "client/ui/html/js/ui.js", 
  "client/ui/html/css/menu.css", 
  "client/ui/html/imgs/logo.png",
}

shared_script "_configs/cfg_general.lua"

client_scripts {
  "client/cl_*.lua"
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  "server/sv_*.lua"
}

