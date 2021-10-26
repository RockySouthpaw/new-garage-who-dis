Config = {}

-- Config Variables (Database)
Config.Identifier           = 'license:'
Config.databaseName         = 'ngwd_vehicles'

-- Config Variables (Storing)
Config.ownerRestricted      = false -- Only allow vehicle owner to store vehicle.

-- Config Variables (Purchasing)
Config.purchaseNotification = true

-- Config Variables (Spawning)
Config.spawnRange           = 15 -- Distance of the player to the spawn range. 10 is roughly 3 parking spaces.

Config.spawnLocations       = { 
    -- Cant use vector4 here since we're comparing it to entity coords which is vector3.
    [1]  = {pos = vector3(227.46, -811.34, 29.52),     heading = 153.00,   name = "Legion"},
	[2]  = {pos = vector3(286.78, -345.68, 43.94),     heading = 160.00,   name = "Pink Cage"}, 
    [3]  = {pos = vector3(1025.36, -760.92, 56.97),    heading = 319.11,   name = "Mirror Park"},
	[4]  = {pos = vector3(36.05, -848.34, 29.77),      heading = 249.56,   name = "Pillbox Hill"},
	[5]  = {pos = vector3(458.49, -902.96, 34.97),     heading = 355.45,   name = "Mission Row"},
	[6]  = {pos = vector3(-279.47, -901.86, 30.08),    heading = 345.24,   name = "Alta Street"},
	[7]  = {pos = vector3(457.03, -1161.03, 30.29),    heading = 357.38,   name = "Speedophile"},
	[8]  = {pos = vector3(982.46, -214.80, 69.63),     heading = 327.12,   name = "East Vinewood"},
	[9]  = {pos = vector3(-37.91, -2085.91, 15.70),    heading = 107.48,   name = "Davis"},
	[10] = {pos = vector3(-68.75, -1996.15, 17.01),    heading = 80.74,    name = "Banning"},
	[11] = {pos = vector3(-1185.27, -1499.89, 3.37),   heading = 214.26,   name = "Vespuci Beach"},
	[12] = {pos = vector3(-2036.04, -469.62, 10.35),   heading = 227.84,   name = "Del Perro"},
	[13] = {pos = vector3(-337.99, 274.48, 84.77),     heading = 184.58,   name = "Last Train Diner"},
	[14] = {pos = vector3(365.60, 291.04, 102.40),     heading = 157.92,   name = "SuperMarket"},
	[15] = {pos = vector3(643.51, 196.67, 95.21),      heading = 342.71,   name = "Downtown Vinewood"},
	[16] = {pos = vector3(58.69, -612.58, 30.63),      heading = 331.78,   name = "Union Depository"},
	[17] = {pos = vector3(105.73, -1070.88, 29.21),	   heading = 331.78,   name = "Ceasars Auto Parking"},
	-- Needs Spawn Points
	[18] = {pos = vector3(-1159.51, -740.10, 19.88),   heading = 331.78,   name = "Vespucci Canals"},
	[19] = {pos = vector3(-1027.80, -1304.83, 6.12),   heading = 331.78,   name = "La Puerta"},
	[20] = {pos = vector3(68.74, 13.59, 69.21),   	   heading = 331.78,   name = "New Garage 1"},
	[21] = {pos = vector3(596.10, 90.87, 93.12),   	   heading = 331.78,   name = "New Garage 2"},
	[22] = {pos = vector3(528.55, -145.92, 58.37), 	   heading = 331.78,   name = "New Garage 3"},
	[23] = {pos = vector3(485.62, -1233.27, 29.65),    heading = 331.78,   name = "New Garage 4"},
	[24] = {pos = vector3(-34.21, -1255.372, 29.43),   heading = 331.78,   name = "New Garage 5"},
	[25] = {pos = vector3(85.24, -1192.64, 29.55), 	   heading = 331.78,   name = "New Garage 6"},
	[26] = {pos = vector3(-128.85, -2183.54, 10.39),   heading = 331.78,   name = "New Garage 7"},
	[27] = {pos = vector3(-614.04, -2240.60, 5.99),    heading = 331.78,   name = "New Garage 8"},
	[28] = {pos = vector3(-786.47, -2083.31, 8.90),    heading = 331.78,   name = "New Garage 9"},
	[29] = {pos = vector3(-665.94, -2002.41, 7.60),    heading = 331.78,   name = "New Garage 10"},
}

Debug = {}

Debug.setActive             = true -- Enables/Disables debug prints.

Debug.successDebugColor     = "^2"
Debug.informDebugColor      = "^5"
Debug.errorDebugColor       = "^1"

--[[
Example: Utils.Debug('error', "hello")
Debug Classess
"Error"
"Success"
"Inform"

^0 White
^1 Red
^2 Green
^3 Yellow
^4 Blue
^5 Light Blue
^6 Purple
^7 Default
^8 Dark Red
^9 Dark Blue
]]