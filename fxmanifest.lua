fx_version 'cerulean'

game 'gta5'

description 'New-Garage-Who-Dis'

server_scripts {
	'server/sv_main.lua',
	'config/sv_config.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'client/*.lua',
	'config/cl_config.lua'
}

dependencies { 'PolyZone' } -- https://github.com/mkafrin/PolyZone