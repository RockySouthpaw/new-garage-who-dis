RegisterNetEvent('NGWD:notifySuccess')
AddEventHandler('NGWD:notifySuccess', function(message)
    notifyEnd("garageNotify")
    Wait(150) -- Ensurs all notifications are removed in time before creating new ones.
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
    Wait(150) -- Ensurs all notifications are removed in time before creating new ones.
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

RegisterNetEvent('NGWD:leaveVehicle')
AddEventHandler('NGWD:leaveVehicle', function(vehicle)
    for i = -1, 7 do
        ped = GetPedInVehicleSeat(vehicle, i)
        TaskLeaveVehicle(ped, vehicle, 0)
        TaskEveryoneLeaveVehicle(vehicle) -- Doesn't work
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
    local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    TriggerServerEvent('NGWD:purchaseVehicle', plate, modelName)
end, false)

RegisterCommand('sell', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelName = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))

    TriggerServerEvent('NGWD:deleteVehicle', plate, modelName)
end, false)