----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

fx_version 'adamant'

game 'gta5'

author 'case#1993'

description 'BOII | Development - Best Buds Job Script'

version '1.0.1'

lua54 'yes'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/index.js',
    'html/index.css',
    'html/reset.css',
    'html/images/**/*.png',
}
shared_scripts {
    'config.lua',
}
client_scripts{
    'client/*.lua',
}
server_scripts{
    'server/*.lua',
}
escrow_ignore{
    'config.lua',
    'client/bestbuds_c.lua',
    'server/bestbuds_s.lua',
    'html/index.html',
    'html/index.css',
    'html/images/**/*.png',
}
dependency '/assetpacks'