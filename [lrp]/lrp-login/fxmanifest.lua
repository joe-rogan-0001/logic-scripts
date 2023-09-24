fx_version 'cerulean'
games {'gta5'}

ui_page "html/index.html"
files({
	"html/*",
	"html/images/*",
	"html/css/*",
	"html/webfonts/*",
	"html/js/*"
})

client_script "client/*"

shared_script "shared/sh_spawn.lua"

server_scripts {
    '@oxmysql/lib/MySQL.lua'
}


server_script "server/*"
