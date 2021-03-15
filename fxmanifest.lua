fx_version 'cerulean'

game 'gta5'
lua54 'yes'

description 'New-Garage-Who-Dis'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config/sv_config.lua',
	'server/sv_main.lua'
}

client_scripts {
	'config/cl_config.lua',
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'client/*.lua',
}

dependencies { 'PolyZone' } -- https://github.com/mkafrin/PolyZone

export 'getVehicleProperties'
export 'getVehicleModkits'
export 'getVehicleCondition'
