fx_version 'cerulean'

game 'gta5'

description 'New-Garage-Who-Dis'

server_scripts {
	'config/sv_config.lua',
	'server/sv_main.lua'
}

client_scripts {
	'config/cl_config.lua',
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'client/*.lua',
}
shared_scripts {
	'cl_functions.lua'
}

dependencies { 'PolyZone' } -- https://github.com/mkafrin/PolyZone