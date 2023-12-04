fx_version   "cerulean"
lua54        "yes"
games        { "gta5" }

name         "sf-houserobbery"
author       "Mateq"
version      "1.0.2"
description  "House robbery script for FiveM"

dependencies {
	"/server:5848",
    "/onesync"
}

ui_page 'html/index.html'

files {
    "html/**/*",
    '**/sf_tre_alarmbox.ytyp',
}

shared_scripts {
    "modules/shared_*.lua",
    "locales/*.lua",
}

client_scripts {
    "config.lua",
    "modules/client_*.lua",
    "client/editable_client.lua",
    "client/minigameHandler.lua",
    "client/main.lua",
    "client/safeCracking.lua",
}

server_scripts {
    "config.lua",
    "config_s.lua",
    "modules/server_*.lua",
    "server/*.lua"
}

escrow_ignore {
    "config.lua",
    "config_*.lua",
    "**/editable_*.lua",
    "server/*.lua",
    "**/server_*.lua",
    "**/shared_*.lua",
    "locales/*.lua",
    "addon/*.lua",
}

data_file 'DLC_ITYP_REQUEST' '**/sf_tre_alarmbox.ytyp'
dependency '/assetpacks'