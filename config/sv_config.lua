Config = {}

-- Config Variables (Database)
Config.useMysqlAsync        = true
Config.useGhmattimysql      = false
Config.identifier           = 'license:'

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
	[9]  = {pos = vector3(156.18, -720.32, 32.13),     heading = 251.75,   name = "Underground"},
	[10] = {pos = vector3(-52.22, -1835.40, 25.53),    heading = 316.13,   name = "Davis"},
	[11] = {pos = vector3(-37.91, -2085.91, 15.70),    heading = 107.48,   name = "Banning"},
	[12] = {pos = vector3(-68.75, -1996.15, 17.01),    heading = 80.74,    name = "PlaceHolder1"},
	[13] = {pos = vector3(-1185.27, -1499.89, 3.37),   heading = 214.26,   name = "Vespuci Beach"},
	[14] = {pos = vector3(-2036.04, -469.62, 10.35),   heading = 227.84,   name = "Del Perro"},
	[15] = {pos = vector3(-564.25, 326.40, 83.40),     heading = 263.92,   name = "West Vinewood"},
	[16] = {pos = vector3(-337.99, 274.48, 84.77),     heading = 184.58,   name = "Last Train Diner"},
	[17] = {pos = vector3(365.60, 291.04, 102.40),     heading = 157.92,   name = "SuperMarket"},
	[18] = {pos = vector3(643.51, 196.67, 95.21),      heading = 342.71,   name = "Downtown Vinewood"},
	[19] = {pos = vector3(58.69, -612.58, 30.63),      heading = 331.78,   name = "Union Depository"},
}

Debug = {}

Debug.debugLevel           = 3
--[[
    This sets the debug level which controls the prints you get in the console:
    0 - Disabled (Not Recomended)
    1 - Only errors
    2 - Errors and Success
    3 - Errors, Success and Informs (Everything)
]]

Debug.successDebugColor    = "^2"
Debug.informDebugColor     = "^5"
Debug.errorDebugColor      = "^1"

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