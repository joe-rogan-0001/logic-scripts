shared_script '@lrp-blips/ai_module_fg-obfuscated.lua'
fx_version 'cerulean'

games { 'gta5' }

client_scripts {
  'client/cl_*.lua',
}

client_exports {
	'registerKeyMapping'
}
