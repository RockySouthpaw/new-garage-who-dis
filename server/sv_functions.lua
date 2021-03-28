local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")

function createVehicle(plyPed, model, coords)
    local veh = Citizen.InvokeNative(CreateAutomobile, model --[[ model ]], coords --[[ spawn coords]])
    if not DoesEntityExist(veh) then return nil end
    local entState = Entity(veh).state
    entState:set('owner', GetPlayerName(plyPed), true)
    entState:set('finishedSpawning', false, true)

    while GetVehiclePedIsIn(plyPed) ~= veh do
        Wait(50)
        SetPedIntoVehicle(plyPed, veh, -1)
    end

    while NetworkGetEntityOwner(veh) ~= source do
        Wait(50)
    end
    return NetworkGetNetworkIdFromEntity(veh), veh
end