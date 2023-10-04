name "Jim-Mechanic"
author "Jimathy"
version "v2.9.8spamfix"
description "Mechanic Script By Jimathy"
fx_version "cerulean"
game "gta5"
lua54 'yes'

dependencies { 'lrp-menu', 'lrp-input', }

shared_scripts { 'config.lua', 'locales/*.lua', 'shared/*.lua', }
client_scripts { '@PolyZone/client.lua', '@PolyZone/BoxZone.lua', '@PolyZone/EntityZone.lua', '@PolyZone/CircleZone.lua', '@PolyZone/ComboZone.lua', 'client/*.lua', 'html/drawtext.lua', }
server_scripts { '@oxmysql/lib/MySQL.lua', 'server/*.lua', }
files { 'html/*.html', 'html/*.css', 'html/*.js', 'html/img/*.png', "stream/carcols_gen9.meta", "stream/carmodcols_gen9.meta" }
ui_page 'html/index.html'
data_file "CARCOLS_GEN9_FILE" "stream/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "stream/carmodcols_gen9.meta"