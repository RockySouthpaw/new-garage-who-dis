RegisterCommand('buy', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)

    TriggerServerEvent('NGWD:purchaseVehicle', plate, modelHash, localizedName)
end)

RegisterCommand('sell', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)

    TriggerServerEvent('NGWD:sellVehicle', plate, modelHash)
end)

RegisterCommand('spawn', function(source, args, rawCommand)
    local plate = '23HSO859'
    local garageName = 'Legion'

    TriggerServerEvent('NGWD:spawnVehicle', plate, garageName)
end)