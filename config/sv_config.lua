Config = {}

Config.ownerRestricted      = false -- Only allow vehicle owner to store vehicle.
Config.identifier           = 'license:'
Config.purchaseNotification = true

-- Config Variables (Spawning)
Config.spawnRange = 15 -- Distance of the player to the spawn range. 10 is roughly 3 parking spaces.

Config.spawnLocations = { -- The index number corresponds to the garage number.
	[1] = {name = "Legion", x = 227.46684265137, y = -811.34936523438, z = 29.527854232788, heading = 161.44157409668},
	[2] = {name = "Pink Cage", x = 286.7854309082, y = -345.6882019043, z = 43.949834136963, heading = 154.09780883789}
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