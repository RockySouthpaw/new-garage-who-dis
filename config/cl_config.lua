Config = {}
-- Config Interactions (Keys)
Config.storageKey = 'E' -- https://docs.fivem.net/docs/game-references/controls/
Config.retrieveKey = 'E'
-- Config Notifications
Config.successLength = 2 -- Length of success Notification
Config.errorLength = 2 -- Length of error Notification
-- Config Variables (T-Notify)
Config.tNotify = true
Config.tLocation = 'top-right' -- (top-left, top-center, top-right, bottom-left, bottom-center, bottom-right
-- Config Variables (Myhtic Notify)
Config.mythicNotify = false
Config.backgroundColor = '#292929'
-- Config Variables (pNotify)
Config.pNotify = false
Config.Layout = "centerRight" -- top, topLeft, topCenter, topRight, center, cenerLeft, centerRight, bottom, bottomLeft, bottomCenter, bottomRight
Config.Duration = 5 -- Duration of prompt and alert lengths.
Config.Theme = "gta" -- gta, mint, relax, metroui
-- Config Variables (Barier)
Config.deleteBariers = true
--Config Variables (Blips)
Config.enableBlips = true
Config.enableBlipNames = true -- Set to false if you need to consolidate blips.
Config.enableRangedBlip = false -- Only show blip if you're in range.

Config.blipRange = 100 -- How far until the blip shows.
Config.blipColor = 1 -- https://docs.fivem.net/natives/?_0x03D7FB09E75D6B7E
Config.blipDisplay = 2 -- 2 = Map/Minimap, 3 = Only Map 5 = ONLY Minimap, 8 = Map/Minimap + Not selectable https://docs.fivem.net/natives/?_0x9029B2F3DA924928

-- Config Variables (PolyZone)
Config.zoneCheck = 1 -- Seconds to check if in the zone.

-- Config Variables (Spawning)
Config.spawnRange = 10 -- Distance of the player to the spawn range. 10 is roughly 3 parking spaces.
-- Config (Blips)
Config.blipLocations = { -- The index number corresponds to the garage number.
	[1] = {name = "Legion", pos = vector3(217.58, -802.31, 30.76)},
	{name = "Pink Cage", pos = vector3(273.77, -344.17, 44.91)},
	{name = "Mirror Park", pos = vector3(1036.25, -763.19, 57.99)},
	{name = "Pillbox Hill", pos = vector3(44.58, -843.09, 31.127)},
	{name = "Mission Row", pos = vector3(458.22, -895.58, 35.97)},
	{name = "Alta Street", pos = vector3(-280.97, -887.98, 31.31)},
	{name = "Mission Row", pos = vector3(453.33, -1146.18, 29.51)},
	{name = "East Vinewood", pos = vector3(984.27, -206.19, 71.06)},
	{name = "Underground Garage", pos = vector3(126.01, -714.44, 33.13)},
	{name = "Davis", pos = vector3(-54.26, -1835.74, 26.57)},
	{name = "Banning", pos = vector3(-36.02, -2096.27, 16.93)},
	{name = "Davis", pos = vector3(-73.31, -2004.03, 18.27)},
	{name = "Vespuci Beach", pos = vector3(-1183.96, -1509.88, 4.64)},
	{name = "Del Perro", pos = vector3(-2030.96, -465.92, 11.60)},
	{name = "West Vinewood", pos = vector3(-554.99, 331.64, 84.37)},
	{name = "West Vinewood", pos = vector3(-340.53, 266.64, 85.67)},
	{name = "Downtown Vinewood", pos = vector3(362.45, 298.58, 103.88)},
	{name = "Downtown Vinewood", pos = vector3(638.73, 206.56, 97.60)},
	{name = "Pillbox Hill", pos = vector3(65.84, -616.36, 30.93)}
}

Config.spawnLocations = { -- The index number corresponds to the garage number.
	[1] = {name = "Legion", x = 227.46684265137, y = -811.34936523438, z = 29.527854232788, heading = 161.44157409668},
	[2] = {name = "Pink Cage", x = 286.7854309082, y = -345.6882019043, z = 43.949834136963, heading = 154.09780883789}
}

Config.barrierLocations = {
	[1] = {pos = vector3(266.09, -349.35, 44.74)}, -- Pink Cage 1
	{pos = vector3(285.28, -355.78, 45.13)}, -- Pink Cage 2
	{pos = vector3(206.52, -803.47, 30.95)}, -- Legion 1
	{pos = vector3(230.96, -816.36, 30.32)}, -- Legion 2
	{pos = vector3(223.87, -740.16, 33.42)}, -- Legion 3
	{pos = vector3(1038.61, -763.18, 57.77)}, -- Mirror Park 1
	{pos = vector3(1030.61, -758.09, 57.77)}, -- Mirror Park 2 
	{pos = vector3(451.45, -1144.53, 29.35)}, -- Mission Row
}

Config.barrierProps = {
	[GetHashKey('prop_sec_barier_02b')] = true,
	[GetHashKey('prop_sec_barier_02a')] = true,
	[GetHashKey('prop_sec_barrier_ld_01a')] = true,
}