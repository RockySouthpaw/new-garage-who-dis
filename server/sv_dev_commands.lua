
-- probs will never use these but just server side equivelent of the client commands
--[[
RegisterCommand('buy', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)

    TriggerEvent('NGWD:purchaseVehicle', source, plate, modelHash, localizedName)
end, false)

RegisterCommand('sell', function(source, args, rawCommand)
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)
    local plate = GetVehicleNumberPlateText(vehicle)
    local modelHash = GetEntityModel(vehicle)

    TriggerEvent('NGWD:sellVehicle', source, plate, modelHash)
end, false)

RegisterCommand('spawn', function(source, args, rawCommand)
    local plate = '80LQX810'
    local garageName = 'Legion'

    TriggerEvent('NGWD:spawnVehicle', source, plate, garageName)
end, false)
]]

RegisterCommand('getModel', function(source, args, rawCommand)
    local playerId <const> = source
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(playerId), false)
    local modelHash = GetEntityModel(vehicle)
    local modelName = Utils.getVehicleModelName(playerId, modelHash)
    Utils.Debug('inform', "Model Hash: "..tostring(modelHash).." Model Name: "..tostring(modelName).."")  
end, false)
