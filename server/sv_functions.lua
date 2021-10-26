local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")

function createVehicle(playerId, plyPed, modelHash, coords)
    for i = 1, #Config.spawnLocations do
        local spawnZone = Config.spawnLocations[i]
        local spawnDistance = #(GetEntityCoords(plyPed) - spawnZone.pos)
        local inVehicle = GetVehiclePedIsIn(plyPed)

        if spawnDistance <= Config.spawnRange then
            if inVehicle ~= 0 then
                DeleteEntity(inVehicle)
                Wait(300)
                Utils.Debug('inform', "Player was in a vehicle.")
            else
                Utils.Debug('inform', "Player was not in a vehicle.")
            end
            local veh = Citizen.InvokeNative(CreateAutomobile, modelHash, spawnZone.pos, spawnZone.heading, true, false)
            if not DoesEntityExist(veh) then 
                return nil 
            end
            local entState = Entity(veh).state
            entState:set('owner', GetPlayerName(playerId), true)
            entState:set('finishedSpawning', false, true)
        
            while GetVehiclePedIsIn(plyPed) ~= veh do
                Wait(50)
                SetPedIntoVehicle(plyPed, veh, -1)
            end
        
            while NetworkGetEntityOwner(veh) ~= playerId do
                Wait(50)
            end
            if GetVehiclePedIsIn(plyPed) == veh then
                Utils.Debug('success', ""..modelHash.." has spawned successfully.")
                Utils.Debug('inform', ""..GetPlayerName(playerId).." has spawned a vehicle "..spawnDistance.." units away.")
            end
            return NetworkGetNetworkIdFromEntity(veh), veh 
        end
    end
end