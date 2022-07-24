fx_version 'cerulean'

game 'gta5'
lua54 'yes'
version '1.1.0'
description 'New-Garage-Who-Dis'

ui_page 'dist/index.html'

files {
	'dist/**/*'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config/sv_config.lua',
	'server/*.lua'
}

client_scripts {
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'config/cl_config.lua',
	'config/cl_zone.lua',
	'client/**/*.lua',
}

dependencies {
	'oxmysql', -- https://github.com/overextended/oxmysql
	'PolyZone' -- https://github.com/mkafrin/PolyZone
}

provide 'ngwd'