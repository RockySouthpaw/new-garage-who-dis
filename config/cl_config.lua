Config = {}

    --Config Variables (Blips)
Config.enableBlips = true
Config.enableRangedBlip = false -- Only show blip if you're in range.

Config.blipRange = 100 -- How far until the blip shows..
Config.blipColor = 1 -- https://docs.fivem.net/natives/?_0x03D7FB09E75D6B7E
Config.blipDisplay = 2 -- 2 = Map/Minimap, 5 = ONLY Minimap, 8 = Map/Minimap + Not selectable

-- Config Variables (Markers)
Config.markerRotate = true -- Faces the player

Config.markerRange = 25.0 -- Distance for creating the marker.
Config.markerType = 20 -- Type of marker https://docs.fivem.net/docs/game-references/markers/
Config.markerSize = {x = 1.0, y = 1.0, z = 1.0}
Config.markerColor = {r = 255, g = 0, b = 0, a = 100}

    -- Config (Markers)
Config.markerLocations = -- Markers if we decide to use one
{
[1] = {name = "Legion", x = 213.43267822266, y = -809.05993652344, z = 31.014888763428},
[2] = {name = "Pink Cage", x = 273.77542114258, y = -344.17346191406, z = 44.919834136963}
}

    -- Config (Parking Locations)
Config.parkingLocations = -- location to park your vehicle.
{
[1] = {name = "Legion", x = 217.58685302734, y = -802.31695556641, z = 30.768518447876},
[2] = {name = "Pink Cage", x = 266.5002746582, y = -332.10998535156, z = 43.949834136963}
}

    -- Config (Blips)
Config.blipLocations = 
{
[1] = {name = "Legion", x = 217.58685302734, y = -802.31695556641, z = 30.768518447876},
[2] = {name = "Pink Cage", x = 273.77542114258, y = -344.17346191406, z = 44.919834136963}
}
 