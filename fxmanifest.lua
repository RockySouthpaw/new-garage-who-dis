fx_version 'cerulean'

game 'gta5'
lua54 'yes'
version '1.1.0'
description 'New-Garage-Who-Dis'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config/sv_config.lua',
	'server/*.lua'
}

client_scripts {
	'config/cl_config.lua',
    'config/cl_zone.lua',
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'client/**/*.lua',
}

dependencies {
	'PolyZone' -- https://github.com/mkafrin/PolyZone
}

provide 'ngwd'