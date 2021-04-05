local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")

function createVehicle(source, plyPed, modelHash, coords)
    for k, v in pairs(Config.spawnLocations) do
        local heading = GetEntityHeading(plyPed)
        local spawnZone = vector3(v.x, v.y, v.z)
        local spawnDistance = #(GetEntityCoords(plyPed) - spawnZone)
        local inVehicle = GetVehiclePedIsIn(plyPed)
        if spawnDistance <= Config.spawnRange then
            if inVehicle ~= 0 then
                DeleteEntity(inVehicle)
                Wait(300)
                Utils.Debug('inform', "Player was in a vehicle.")
            else
                Utils.Debug('inform', "Player was not in a vehicle.")
            end
            local veh = Citizen.InvokeNative(CreateAutomobile, modelHash, v.x, v.y, v.z, heading, true, false)
            if not DoesEntityExist(veh) then 
                return nil 
            end
            local entState = Entity(veh).state
            entState:set('owner', GetPlayerName(source), true)
            entState:set('finishedSpawning', false, true)
        
            while GetVehiclePedIsIn(plyPed) ~= veh do
                Wait(50)
                SetPedIntoVehicle(plyPed, veh, -1)
            end
        
            while NetworkGetEntityOwner(veh) ~= source do
                Wait(50)
            end
            if GetVehiclePedIsIn(plyPed) == veh then
                Utils.Debug('success', "" .. modelHash .. " has spawned successfully.")
            end
            return NetworkGetNetworkIdFromEntity(veh), veh 
        end
    end
end