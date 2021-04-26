Config = {}
-- Config Interactions (Keys)
Config.storageKey 		= 'E' -- https://docs.fivem.net/docs/game-references/controls/
Config.retrieveKey 		= 'E'

-- Config Notifications (Applies to All)
Config.successLength 	= 2 -- Length of success Notification (Seconds)
Config.errorLength 		= 2 -- Length of error Notification (Seconds)

-- Config Variables (T-Notify)
Config.tNotify 			= true
Config.tLocation 		= 'top-right' -- (top-left, top-center, top-right, bottom-left, bottom-center, bottom-right
-- Config Variables (Mythic Notify https://github.com/FlawwsX/mythic_notify)
Config.mythicNotify 	= false
Config.backgroundColor  = '#292929'
-- Config Variables (pNotify)
Config.pNotify 			= false
Config.layout 			= "centerRight" -- top, topLeft, topCenter, topRight, center, cenerLeft, centerRight, bottom, bottomLeft, bottomCenter, bottomRight
Config.theme 			= "gta" -- gta, mint, relax, metroui
-- Config Variables (ESX Notification)
Config.esxNotify		= false

-- Config Variables (Barier)
Config.deleteBarriers 	= false

--Config Variables (Blips)
Config.enableBlips 		= true
Config.enableBlipNames 	= true -- Set to false if you need to consolidate blips.
Config.enableRangedBlip = false -- Only show blip if you're in range.
Config.blipRange 		= 75 -- How far until the blip shows.
Config.blipColor 		= 1 -- https://docs.fivem.net/natives/?_0x03D7FB09E75D6B7E
Config.blipDisplay 		= 2 -- 2 = Map/Minimap, 3 = Only Map 5 = ONLY Minimap, 8 = Map/Minimap + Not selectable https://docs.fivem.net/natives/?_0x9029B2F3DA924928

-- Config Variables (PolyZone)
Config.zoneCheck 		= 1 -- Seconds to check if in the zone.
Config.polyBlipRange 	= 85 -- Distance of the garage blip from the polyzone
-- Config (Blips)
Config.blipLocations = {
	[1]  = {pos = vector3(217.58, -802.31, 30.76), 		name = "Legion"}, -- garage 1
	[2]  = {pos = vector3(273.77, -344.17, 44.91), 		name = "Pink Cage"},
	[3]  = {pos = vector3(1036.25, -763.19, 57.99), 	name = "Mirror Park"},
	[4]  = {pos = vector3(44.58, -843.09, 31.127), 		name = "Pillbox Hill"},
	[5]  = {pos = vector3(438.97, -1006.49, 27.41), 	name = "Mission Row"},
	[6]  = {pos = vector3(-280.97, -887.98, 31.31), 	name = "Alta Street"},
	[7]  = {pos = vector3(453.33, -1146.18, 29.51), 	name = "Speedophile"},
	[8]  = {pos = vector3(984.27, -206.19, 71.06), 		name = "East Vinewood"},
	[9]  = {pos = vector3(126.01, -714.44, 33.13), 		name = "Underground"},
	[10] = {pos = vector3(-54.26, -1835.74, 26.57), 	name = "Davis"},
	[11] = {pos = vector3(-36.02, -2096.27, 16.93), 	name = "Banning"},
	[12] = {pos = vector3(-73.31, -2004.03, 18.27), 	name = "PlaceHolder1"},
	[13] = {pos = vector3(-1183.96, -1509.88, 4.64), 	name = "Vespuci Beach"},
	[14] = {pos = vector3(-2030.96, -465.92, 11.60), 	name = "Del Perro"},
	[15] = {pos = vector3(-554.99, 331.64, 84.37), 		name = "West Vinewood"},
	[16] = {pos = vector3(-340.53, 266.64, 85.67), 		name = "Last Train Diner"},
	[17] = {pos = vector3(362.45, 298.58, 103.88), 		name = "SuperMarket"},
	[18] = {pos = vector3(638.73, 206.56, 97.60), 		name = "Downtown Vinewood"},
	[19] = {pos = vector3(65.84, -616.36, 30.93), 		name = "Union Depository"},
	[20] = {pos = vector3(105.73, -1070.88, 29.21), 	name = "Ceasars Auto Parking"}
}

Config.barrierLocations = {
	{pos = vector3(266.09, -349.35, 44.74)}, 	-- Pink Cage 1
	{pos = vector3(285.28, -355.78, 45.13)}, 	-- Pink Cage 2
	{pos = vector3(206.52, -803.47, 30.95)}, 	-- Legion 1
	{pos = vector3(230.96, -816.36, 30.32)}, 	-- Legion 2
	{pos = vector3(223.87, -740.16, 33.42)}, 	-- Legion 3
	{pos = vector3(1038.61, -763.18, 57.77)}, 	-- Mirror Park 1
	{pos = vector3(1030.61, -758.09, 57.77)}, 	-- Mirror Park 2 
	{pos = vector3(451.45, -1144.53, 29.35)}, 	-- Mission Row
}

Config.barrierProps = {
	[GetHashKey('prop_sec_barier_02b')] 	= true,
	[GetHashKey('prop_sec_barier_02a')] 	= true,
	[GetHashKey('prop_sec_barrier_ld_01a')] = true,
}

Config.parkingPropsLocations = {
	{pos = vector3(170.0, -729.0, 32.16), 	heading = 160.0, name = "Underground"},
	{pos = vector3(-65.85, -1839.53, 25.77), heading = 230.0, name = "Davis"}
}