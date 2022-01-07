local devPlate = '23HSO859'

RegisterCommand('buy', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)
    local displayName = GetDisplayNameFromVehicleModel(modelHash)
    local localizedName = GetLabelText(displayName)
    local modelClass = GetVehicleClass(vehicle)

    TriggerServerEvent('NGWD:purchaseVehicle', plate, modelHash, modelClass, localizedName)
end)

RegisterCommand('sell', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)

    TriggerServerEvent('NGWD:sellVehicle', plate, modelHash)
end)

RegisterCommand('spawn', function(source, args, rawCommand)
    local plate = devPlate
    local garageName = 'Legion'

    TriggerServerEvent('NGWD:spawnVehicle', plate, garageName)
end)

RegisterCommand('dp_name', function(source, args, rawCommand)
    local plate = devPlate
    local garageName = 'Legion'
    
    TriggerServerEvent('NGWD:spawnVehicle', plate, garageName)
end)