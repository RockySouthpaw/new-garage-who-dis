RegisterNetEvent('NGWD:notifySuccess')
AddEventHandler('NGWD:notifySuccess', function(message)
    notifyEnd("garageNotify")
    Wait(150) -- Ensures all notifications are removed in time before creating new ones.
    length = Config.successLength * 1000
    if Config.tNotify then 
        exports['t-notify']:Alert({
            style  =  'success',
            message  =  "✔️ " .. message,
            length = Config.successLength * 1000
        })
    end
    if Config.mythicNotify then
        exports['mythic_notify']:SendAlert('success', "✔️ " .. message, length)
    end
    if Config.pNotify then
        exports.pNotify:SetQueueMax(id, 1)
        exports.pNotify:SendNotification({
            text = "✔️ " .. message,
            type = "success",
            timeout = 1000 * Config.Duration,
            layout = Config.Layout,
            theme = Config.Theme,
            queue = "id"
        })
    end
end)

RegisterNetEvent('NGWD:notifyError')
AddEventHandler('NGWD:notifyError', function(message)
    notifyEnd("garageNotify")
    Wait(150) -- Ensures all notifications are removed in time before creating new ones.
    length = Config.successLength * 1000
    if Config.tNotify then 
        exports['t-notify']:Alert({
            style  =  'error',
            message  =  "❌ " .. message,
            length = length
        })
    end
    if Config.mythicNotify then
        exports['mythic_notify']:SendAlert('error', "❌ " .. message, length)
    end
    if Config.pNotify then
        exports.pNotify:SetQueueMax(id, 1)
        exports.pNotify:SendNotification({
            text = "❌ " .. message,
            type = "error",
            timeout = 1000 * Config.Duration,
            layout = Config.Layout,
            theme = Config.Theme,
            queue = "id"
        })
    end
end)

RegisterNetEvent('NGWD:spawnVehicle')
AddEventHandler('NGWD:spawnVehicle', function(modelHash, plate)
    if IsModelInCdimage(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(1)
        end
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)
        for k, v in pairs(Config.spawnLocations) do
            local spawnZone = vector3(v.x, v.y, v.z)
            local spawnDistance = #(playerCoords - spawnZone)

            if spawnDistance <= Config.spawnRange then
                local conflictVehicle = GetClosestVehicle(v.x, v.y, v.z,  2.0,  0,  71)
                if DoesEntityExist(conflictVehicle) then
                  deleteVehicle(conflictVehicle)
                end
                if not IsPedInAnyVehicle(ped, false) then
                    local vehicle = CreateVehicle(modelHash, v.x, v.y, v.z, heading, true, false)
                    local fuel = 100.00
                    vehicleUtils(vehicle)
                    vehicleSetters(vehicle, fuel, plate)
                    TaskWarpPedIntoVehicle(ped, vehicle, -1)
                    TriggerEvent('NGWD:notifySuccess', "" .. modelHash .. " has spawned successfully.")
                else
                    TriggerEvent('NGWD:notifyError', "Action unavailable while in a vehiclce.")
                end
            end
        end
    else
        print("Error: Failed to spawn vehicle")
    end
end)

RegisterNetEvent('NGWD:leaveVehicle')
AddEventHandler('NGWD:leaveVehicle', function(vehicle)
    for i = -1, 7 do
        ped = GetPedInVehicleSeat(vehicle, i)
        TaskLeaveVehicle(ped, vehicle, 0)
        notifyEnd("garageNotify")
    end
    Wait(1500)
    --deleteVehicle(vehicle)
end)

RegisterNetEvent('NGWD:previewVehicle')
AddEventHandler('NGWD:previewVehicle', function(garageName)
    -- Triggered by the menu to spawn vehicle
    print(garageName)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        notifyEnd("garageNotify")
    end
end)

-- only exist for testing. Will be removed
RegisterCommand('buy', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)
    local displayName = GetDisplayNameFromVehicleModel(modelHash)
    local localizedName = GetLabelText(displayName)
    --local properties = getVehicleProperties(vehicle)
    --local condition = getVehicleCondition(vehicle)

    TriggerServerEvent('NGWD:purchaseVehicle', plate, modelHash, localizedName)
end, false)

RegisterCommand('sell', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)

    TriggerServerEvent('NGWD:sellVehicle', plate, modelHash)
end, false)

RegisterCommand('spawn', function(source, args, rawCommand)
    local plate = "29NDG376"

    TriggerServerEvent('NGWD:spawnVehicle', plate)
end, false)