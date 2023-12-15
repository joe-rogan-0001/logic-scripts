shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'
game 'gta5'

ui_page 'html/index.html'

files {
  "html/index.html",
  "html/*.js",
  "html/*.css"
}

client_scripts {
  "client/*.lua",
}

export "taskBar"