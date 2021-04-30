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
Config.enableBlipNames 	= false -- Set to false if you need to consolidate blips.
Config.enableRangedBlip = false -- Only show blip if you're in range.
Config.blipRange 		= 75 -- How far until the blip shows.
Config.blipColor 		= 1 -- https://docs.fivem.net/natives/?_0x03D7FB09E75D6B7E
Config.blipDisplay 		= 2 -- 2 = Map/Minimap, 3 = Only Map 5 = ONLY Minimap, 8 = Map/Minimap + Not selectable https://docs.fivem.net/natives/?_0x9029B2F3DA924928

-- Config Variables (PolyZone)
Config.zoneCheck 		= 1 	-- Seconds to check if in the zone.
Config.polyBlipRange 	= 85 	-- Distance of the garage blip from the polyzone
Config.useGabzPD		= false	-- Enables polyzone for Gabz Police Department. Will use the side of the building if set to false.

-- Config (Blips)
Config.blipLocations = {
	[1]  = {pos = vector3(217.58, -802.31, 30.76), 		name = "Legion"}, 		-- Done 		
	[2]  = {pos = vector3(273.77, -344.17, 44.91), 		name = "Pink Cage"}, 	-- Done	
	[3]  = {pos = vector3(1036.25, -763.19, 57.99), 	name = "Mirror Park"}, 	-- Done	
	[4]  = {pos = vector3(44.58, -843.09, 31.127), 		name = "Pillbox Hill"},	-- Done
	[5]  = {pos = vector3(438.97, -1006.49, 27.41), 	name = "Mission Row"},	-- Police Department
	[6]  = {pos = vector3(-280.97, -887.98, 31.31), 	name = "Alta Street"},	
	[7]  = {pos = vector3(453.33, -1146.18, 29.51), 	name = "Speedophile"}, 	
	[8]  = {pos = vector3(984.27, -206.19, 71.06), 		name = "East Vinewood"},
	[9]  = {pos = vector3(-97.64, -2117.46, 16.87), 	name = "Davis"},		 
	[10] = {pos = vector3(-73.31, -2004.03, 18.27), 	name = "Banning"},	
	[11] = {pos = vector3(-1183.96, -1509.88, 4.64), 	name = "Vespuci Beach"},
	[12] = {pos = vector3(-2030.96, -465.92, 11.60), 	name = "Del Perro"},
	[13] = {pos = vector3(-340.53, 266.64, 85.67), 		name = "Last Train Diner"},
	[14] = {pos = vector3(362.45, 298.58, 103.88), 		name = "SuperMarket"},
	[15] = {pos = vector3(638.73, 206.56, 97.60), 		name = "Downtown Vinewood"},
	[16] = {pos = vector3(65.84, -616.36, 30.93), 		name = "Union Depository"},
	[17] = {pos = vector3(105.73, -1070.88, 29.21), 	name = "Ceasars Auto Parking"},
	[18] = {pos = vector3(-1159.51, -740.10, 19.88), 	name = "Vespucci Canals"},
	[19] = {pos = vector3(-1027.80, -1304.83, 6.12), 	name = "La Puerta"},
	[20] = {pos = vector3(68.74, 13.59, 69.21), 		name = "New Garage 1"},
	[21] = {pos = vector3(596.10, 90.87, 93.12), 		name = "New Garage 2"},
	[22] = {pos = vector3(528.55, -145.92, 58.37), 		name = "New Garage 3"},
	[23] = {pos = vector3(485.62, -1233.27, 29.65), 	name = "New Garage 4"},
	[24] = {pos = vector3(-34.21, -1255.372, 29.43), 	name = "New Garage 5"},
	[25] = {pos = vector3(85.24, -1192.64, 29.55), 		name = "New Garage 6"},
	[26] = {pos = vector3(-128.85, -2183.54, 10.39), 	name = "New Garage 7"},
	[27] = {pos = vector3(-614.04, -2240.60, 5.99), 	name = "New Garage 8"},
	[28] = {pos = vector3(-786.47, -2083.31, 8.90), 	name = "New Garage 9"},
	[29] = {pos = vector3(-665.94, -2002.41, 7.60), 	name = "New Garage 10"},
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

--[[
Config.parkingPropsLocations = {
	{pos = vector3(170.0, -729.0, 32.16), 		heading = 160.0, name = "Underground"},
	{pos = vector3(-65.85, -1839.53, 25.77), 	heading = 230.0, name = "Davis"}
}
]]