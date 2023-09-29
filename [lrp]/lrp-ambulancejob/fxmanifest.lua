fx_version 'cerulean'
game 'gta5'

description 'QB-AmbulanceJob'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
	'client/main.lua',
	'client/wounding.lua',
	'client/laststand.lua',
	'client/job.lua',
	'client/dead.lua',
	'client/cl_ai.lua'
}

server_script {
	'server/main.lua',
	'@oxmysql/lib/MySQL.lua'
}

lua54 'yes'