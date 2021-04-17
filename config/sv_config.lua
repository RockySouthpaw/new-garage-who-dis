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
Config.spawnRange = 15 -- Distance of the player to the spawn range. 10 is roughly 3 parking spaces.

Config.spawnLocations = { -- The index number corresponds to the garage number.
    {name = "Legion", pos = vector(227.46, -811.34, 29.52)},
	{name = "Pink Cage", pos = vector(286.78, -345.68, 43.94)}
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