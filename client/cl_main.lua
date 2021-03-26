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
            for i = 1, #Config.blipLocations do
                local zone = Config.blipLocations[i]
                local blipDistance = #(playerCoords - zone.pos)

                if not Config.enableRangedBlip then -- Shows all blips if they don't already exist
                    blip = AddBlipForCoord(zone.pos)
                    SetBlipDisplay(blip, Config.blipDisplay)
                    SetBlipSprite(blip, 357)
                    SetBlipColour(blip, Config.blipColor)
                    BeginTextCommandSetBlipName("STRING")
                    if Config.enableBlipNames then
                        AddTextComponentString(zone.name.. " Garage")
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
                        blip = AddBlipForCoord(zone.pos)
                        SetBlipDisplay(blip, Config.blipDisplay)
                        SetBlipSprite(blip, 357)
                        SetBlipColour(blip, Config.blipColor)
                        BeginTextCommandSetBlipName("STRING")
                        if Config.enableBlipNames then
                            AddTextComponentString(zone.name.. " Garage")
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

local propsToDelete = Config.barrierProps
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        if Config.deleteBariers then
            local plyPos = GetEntityCoords(PlayerPedId())
            for i = 1, #Config.barrierLocations do
                local zone = Config.barrierLocations[i]
                if #(plyPos - zone.pos) then
                    local objTbl = GetGamePool('CObject')
                    for i = 1, #objTbl do
                        local obj = objTbl[i]
                        if propsToDelete[GetEntityModel(obj)] then
                            SetEntityAsMissionEntity(obj, true, true)
                            DeleteObject(obj)
                            SetEntityAsNoLongerNeeded(obj)
                        end
                    end
                end
            end
        end
    end
end)
