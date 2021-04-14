fx_version 'cerulean'

game 'gta5'
lua54 'yes'

description 'New-Garage-Who-Dis'

server_scripts {
	'config/sv_config.lua',
	'server/*.lua'
}

client_scripts {
	'config/cl_config.lua',
	'@PolyZone/client.lua',
	'@PolyZone/ComboZone.lua',
	'client/**/*.lua',
}

dependencies {
    'ghmattimysql',
    'PolyZone' -- https://github.com/mkafrin/PolyZone
} 