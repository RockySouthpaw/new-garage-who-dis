if Config.esxNotify then
    ESX              = nil
    local PlayerData = {}

    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(0)
        end
    end)
end

RegisterNetEvent('NGWD:notifySuccess', function(message)
    notifyEnd("garageNotify")
    Wait(150) -- Ensures all notifications are removed in time before creating new ones.
    length = Config.successLength * 1000
    if Config.tNotify then
        exports['t-notify']:Alert({
            style  =  'success',
            message  =  "✔️ "..message,
            length = length
        })
    end
    if Config.mythicNotify then
        exports['mythic_notify']:SendAlert('success', "✔️ "..message, length)
    end
    if Config.pNotify then
        exports.pNotify:SetQueueMax(id, 1)
        exports.pNotify:SendNotification({
            text = "✔️ "..message,
            type = "success",
            timeout = length,
            layout = Config.layout,
            theme = Config.theme,
            queue = "id"
        })
    end
    if Config.esxNotify then
        ESX.ShowNotification(
            "✔️ "..message,
            false,
            false,
            140
        )
    end
end)

RegisterNetEvent('NGWD:notifyError', function(message)
    notifyEnd("garageNotify")
    Wait(150) -- Ensures all notifications are removed in time before creating new ones.
    length = Config.errorLength * 1000
    if Config.tNotify then
        exports['t-notify']:Alert({
            style  =  'error',
            message  =  "❌ "..message,
            length = length
        })
    end
    if Config.mythicNotify then
        exports['mythic_notify']:SendAlert('error', "❌ "..message, length)
    end
    if Config.pNotify then
        exports.pNotify:SetQueueMax(id, 1)
        exports.pNotify:SendNotification({
            text = "❌ "..message,
            type = "error",
            timeout = length,
            layout = Config.layout,
            theme = Config.theme,
            queue = "id"
        })
    end
    if Config.esxNotify then
        ESX.ShowNotification(
            "❌ "..message,
            false,
            false,
            140
        )
    end
end)

RegisterNetEvent('NGWD:openMenu', function(garageData)
    local data = {}
    for k, v in pairs(garageData) do
        data[k] = v
    end
    SendNUIMessage({
        action = "openMenu",
        vehicles = data
    })
    SetNuiFocus(true, true)
end)

RegisterNetEvent('NGWD:setVehicleProperties', function(vehNet, plate, vehicleProperties, vehicleCondition, vehicleMods)
    while not NetworkDoesEntityExistWithNetworkId(vehNet) do
        -- vehicles wont instantly exist on the client, even though they exist on the server.
        Wait(50)
    end
    local vehicle = NetworkGetEntityFromNetworkId(vehNet)
    -- Shouldn't be needed after storing a vehicle but will toss a nil erorr otherwise.
    if vehicleProperties then
        setVehicleProperties(vehicle, plate, vehicleProperties)
    end
    if vehicleCondition then
        setVehicleCondition(vehicle, vehicleCondition)
    end
    if vehicleMods then
        setVehicleMods(vehicle, vehicleMods)
    end
end)

RegisterNetEvent('NGWD:leaveVehicle', function(vehicle)
    for i = -1, 7 do
        ped = GetPedInVehicleSeat(vehicle, i)
        TaskLeaveVehicle(ped, vehicle, 0)
        notifyEnd("garageNotify")
    end
end)

RegisterNetEvent('NGWD:previewVehicle', function(garageName)
    -- Triggered by the menu to spawn vehicle
    print(garageName)
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        notifyEnd("garageNotify")
    end
end)