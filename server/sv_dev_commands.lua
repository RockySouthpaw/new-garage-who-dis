
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

RegisterCommand('getmodel', function(source, args, rawCommand)
    local playerId <const> = source
    local vehicle = GetVehiclePedIsIn(GetPlayerPed(playerId), false)
    local modelHash = GetEntityModel(vehicle)
    local modelName = Utils.getVehicleModelName(modelHash)
    Utils.Debug('inform', "Model Hash: "..tostring(modelHash).." Model Name: "..tostring(modelName).."")
end, false)

RegisterCommand('stateCheck', function(source, args, rawCommand)
    local playerId <const> = source
    if args[1] then
        local validState = Utils.getState(playerId, tostring(args[1]))
        if not validState then
            Utils.failedCheck(playerId, ""..tostring(args[1]).." State Bag")
        else
            Utils.Debug('success', "State Bag "..tostring(args[1]).." found.")
        end
    end
end, false)