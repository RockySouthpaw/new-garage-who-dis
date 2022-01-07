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

ui_page 'html/index.html'

files {
	--'html/index.html',
	--'html/js/*.js',
	--'html/css/*.css',
	'html/img/*.png'
}

dependencies {
	'mysql-async', -- https://github.com/brouznouf/fivem-mysql-async
	'PolyZone' -- https://github.com/mkafrin/PolyZone
}

provide 'ngwd'