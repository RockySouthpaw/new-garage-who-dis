-- Varibles
local blipCreated = false
local blipInRange = false 

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
                    if Config.enableBlipNames then
                        AddTextComponentString(v.name.. " Garage")
                    else
                        AddTextComponentString("Garage")
                    end
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
                        if Config.enableBlipNames then
                            AddTextComponentString(v.name.. " Garage")
                        else
                            AddTextComponentString("Garage")
                        end
                        EndTextCommandSetBlipName(blip)
                        if DoesBlipExist(blip) then
                            activeGarage = blip
                            Wait(5000) -- Prevents the blip from being re-created if it already exist and stores it so it can be removed later once we're out of range.
                        end
                    elseif blipDistance >= Config.blipRange then -- Curently assumes you're out of range for ALL blips. :Deskchan:
                        RemoveBlip(activeGarage)
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if Config.deleteBariers then
            for k, v in pairs(Config.barierLocations) do
                local playerCoords = GetEntityCoords(PlayerPedId())
                local barrierZone = vector3(v.x, v.y, v.z)
                local barrierDistance = #(playerCoords - barrierZone)
                if barrierDistance <= 75 then
                    local objectEntity = GetClosestObjectOfType(Config.barierLocations[k].x, Config.barierLocations[k].y, Config.barierLocations[k].z, 2.0, GetHashKey(Config.barierLocations[k].model), false, false, false)
                    SetEntityAsMissionEntity(objectEntity, true, true)
                    DeleteObject(objectEntity)
                    SetEntityAsNoLongerNeeded(objectEntity)
                end
            end
        end
    end
end)