-- Varibles
local blipCreated = false
local blipInRange = false 

-- Create Markers
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(10)
        local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(playerPed)
        for k, v in pairs(Config.markerLocations) do
            local markerZone = vector3(v.x, v.y, v.z)
            local markerDistance = #(playerCoords - markerZone)
            if markerDistance <= Config.markerRange then
                DrawMarker(Config.markerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.markerSize.x, Config.markerSize.y, Config.markerSize.z, Config.markerColor.r, Config.markerColor.g, Config.markerColor.b, Config.markerColor.a, false, Config.markerRotate, 2, 0, nil, nil, false)
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
        
        if Config.enableBlips and not blipCreated then -- Do the check for if they're created here so all blips get created.
            for k, v in pairs(Config.blipLocations) do
                local blipZone = vector3(v.x, v.y, v.z)
                local blipDistance = #(playerCoords - blipZone)

                if not Config.enableRangedBlip then -- Shows all blips if they don't already exist
                    blip = AddBlipForCoord(v.x, v.y, v.z)
                    SetBlipDisplay(blip, Config.blipDisplay)
                    SetBlipSprite(blip, 357)
                    SetBlipColour(blip, Config.blipColor)
                    BeginTextCommandSetBlipName("STRING")
                    AddTextComponentString(v.name.. " Garage")
                    EndTextCommandSetBlipName(blip)
                    if DoesBlipExist(blip) then
                        blipCreated = true
                    end
                end
                if Config.enableRangedBlip then -- Show only blips in range.
                    if blipDistance <= Config.blipRange then
                        blip = AddBlipForCoord(v.x, v.y, v.z)
                        SetBlipDisplay(blip, Config.blipDisplay)
                        SetBlipSprite(blip, 357)
                        SetBlipColour(blip, Config.blipColor)
                        BeginTextCommandSetBlipName("STRING")
                        AddTextComponentString(v.name.. " Garage")
                        EndTextCommandSetBlipName(blip)
                        if DoesBlipExist(blip) then
                            activeGarage = blip
                            Wait(5000) -- Prevents the blip from being re-created if it already exist and stores it so it can be removed later once we're out of range.
                        end
                    elseif blipDistance >= Config.blipRange then
                        RemoveBlip(activeGarage)
                    end
                end
            end
        end
    end
end)