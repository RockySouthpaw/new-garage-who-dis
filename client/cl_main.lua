-- WiLL MOVE TO CL_CONFIG WHEN DONE

--Local Variables (Blips)
local enableBlips = true
local enableRangedBlip = true -- Only show blip if you're in range.

local blipRange = 100 -- How far until the blip shows..
local blipColor = 1 -- https://docs.fivem.net/natives/?_0x03D7FB09E75D6B7E
local blipDisplay = 2 -- 2 = Map/Minimap, 5 = ONLY Minimap, 8 = Map/Minimap + Not selectable

local blipCreated = false
local blipInRange = false 

-- Local Variables (Markers)
local markerRotate = true -- Faces the player

local markerRange = 25.0 -- Distance for creating the marker.
local markerType = 20 -- Type of marker https://docs.fivem.net/docs/game-references/markers/
local markerSize = {x = 1.0, y = 1.0, z = 1.0}
local markerColor = {r = 255, g = 0, b = 0, a = 100}

-- Config (Markers)
local markerLocations = -- Markers if we decide to use one
{
  [1] = {name = "Legion", x = 217.58685302734, y = -802.31695556641, z = 30.768518447876},
  [2] = {name = "Pink Cage", x = 273.77542114258, y = -344.17346191406, z = 44.919834136963}
}

-- Config (Parking Locations)
local parkingLocations = -- location to park your vehicle.
{
  [1] = {name = "Legion", x = 217.58685302734, y = -802.31695556641, z = 30.768518447876},
  [2] = {name = "Pink Cage", x = 266.5002746582, y = -332.10998535156, z = 43.949834136963}
}

-- Config (Blips)
local blipLocations = 
{
  [1] = {name = "Legion", x = 217.58685302734, y = -802.31695556641, z = 30.768518447876},
  [2] = {name = "Pink Cage", x = 273.77542114258, y = -344.17346191406, z = 44.919834136963}
}

-- Create Markers
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(10)
        local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
        for k, v in pairs(markerLocations) do
            local markerZone = vector3(v.x, v.y, v.z)
            local markerDistance = #(playerCoords - markerZone)
            if markerDistance <= markerRange then
                DrawMarker(markerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, markerSize.x, markerSize.y, markerSize.z, markerColor.r, markerColor.g, markerColor.b, markerColor.a, false, markerRotate, 2, 0, nil, nil, false)
            end
        end
    end
end)

-- Create Blips
Citizen.CreateThread(function() 
    while true do
		Citizen.Wait(1000)
        local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
        
        if enableBlips and not blipCreated then -- Do the check for if they're created here so all blips get created.
            for k, v in pairs(blipLocations) do
                local blipZone = vector3(v.x, v.y, v.z)
                local blipDistance = #(playerCoords - blipZone)

                if not enableRangedBlip then -- Shows all blips if they don't already exist
                    blip = AddBlipForCoord(v.x, v.y, v.z)
                    SetBlipDisplay(blip, blipDisplay)
                    SetBlipSprite(blip, 357)
                    SetBlipColour(blip, blipColor)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.name.. " Garage")
                    EndTextCommandSetBlipName(blip)
                    if DoesBlipExist(blip) then
                        blipCreated = true
                    end
                end
                if enableRangedBlip then -- Show only blips in range.
                    if blipDistance <= blipRange then
                        blip = AddBlipForCoord(v.x, v.y, v.z)
                        SetBlipDisplay(blip, blipDisplay)
                        SetBlipSprite(blip, 357)
                        SetBlipColour(blip, blipColor)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.name.. " Garage")
                        EndTextCommandSetBlipName(blip)
                        if DoesBlipExist(blip) then
                            activeGarage = blip
                            Wait(5000) -- Prevents the blip from being re-created if it already exist and stores it so it can be removed later once we're out of range.
                        end
                    elseif blipDistance >= blipRange then
                        RemoveBlip(activeGarage)
                    end
                end
            end
        end
    end
end)