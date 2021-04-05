if Config.esxNotify then
    ESX              = nil
    local PlayerData = {}

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end

RegisterNetEvent('NGWD:notifySuccess')
AddEventHandler('NGWD:notifySuccess', function(message)
    notifyEnd("garageNotify")
    Wait(150) -- Ensures all notifications are removed in time before creating new ones.
    length = Config.successLength * 1000
    if Config.tNotify then 
        exports['t-notify']:Alert({
            style  =  'success',
            message  =  "✔️ " .. message,
            length = length
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
            timeout = length,
            layout = Config.layout,
            theme = Config.theme,
            queue = "id"
        })
    end
    if Config.esxNotify then
        ESX.ShowNotification(
            "✔️ " .. message, 
            false, 
            false, 
            140
        )
    end
end)

RegisterNetEvent('NGWD:notifyError')
AddEventHandler('NGWD:notifyError', function(message)
    notifyEnd("garageNotify")
    Wait(150) -- Ensures all notifications are removed in time before creating new ones.
    length = Config.errorLength * 1000
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
            timeout = length,
            layout = Config.layout,
            theme = Config.theme,
            queue = "id"
        })
    end
    if Config.esxNotify then
        ESX.ShowNotification(
            "❌ " .. message, 
            false, 
            false, 
            140
        )
    end
end)

RegisterNetEvent('NGWD:openMenu')
AddEventHandler('NGWD:openMenu', function(source, garageName)
    print(garageName)
end)

RegisterNetEvent('NGWD:setVehicleProperties', function(vehNet, vehProperties)
    while not NetworkDoesEntityExistWithNetworkId(vehNet) do
        -- vehicles wont instantly exist on the client, even though they exist on the server.
        Wait(50)
    end

    -- handle vehProperties
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

    Wait(500)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    SetVehicleNumberPlateText(vehicle, plate)
end, false)