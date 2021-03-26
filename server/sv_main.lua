local CreateAutomobile = GetHashKey("CREATE_AUTOMOBILE")
function createVehicle(source, model, coords)
    local veh = Citizen.InvokeNative(CreateAutomobile, model --[[ model ]], coords --[[ spawn coords]])
    if not DoesEntityExist(veh) then return nil end
    local entState = Entity(veh).state
    entState:set('owner', GetPlayerName(source), true)
    entState:set('fishedSpawning', false, true)

    while GetVehiclePedIsIn(plyPed) ~= veh do
        Wait(50)
        SetPedIntoVehicle(plyPed, veh, -1)
    end

    while NetworkGetEntityOwner(veh) ~= source do
        Wait(50)
    end
    return NetworkGetNetworkIdFromEntity(veh), veh
end

local tempModel = GetHashKey('blista')
RegisterNetEvent('NGWD:spawnVehicle', function(plate --[[could also send the vehId, would be faster to fetch from the db]])
    local source = source
    -- delete when sending actual position
    local plyPed = GetPlayerPed(source)
    local vehNet, veh = createVehicle(source, tempModel, GetEntityCoords(plyPed))
    if not vehNet then return end
    TriggerClientEvent('NGWD:setVehicleProperties', source, vehNet, {} --[[Send the vehicle data to the client]])

    Wait(100)
    if not DoesEntityExist(veh) then return end
    if not Entity(veh).state.finishedSpawning then
        -- might not even be deeded
        DeleteEntity(veh)
        local vehNet, veh = createVehicle(source, tempModel, GetEntityCoords(plyPed))
        if not vehNet then return end
        TriggerClientEvent('NGWD:setVehicleProperties', source, vehNet, {} --[[Send the vehicle data to the client]])
    end
end)

RegisterNetEvent('NGWD:purchaseVehicle', function(plate, modelHash, localizedName) -- Should also pass the modelName maybe?
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    if identifier then
        if plate ~= nil and modelHash ~= nil then
            -- can also add a distance check for the dealership cords and trigger a kick event..
            MySQL.Async.fetchAll('SELECT * FROM ngwd_vehicles WHERE (owner, modelHash, localizedName, plate) = (@owner, @modelHash, @localizedName, @plate)', {
                ['@owner']     = identifier,
                ['@modelHash']     = modelHash,
                ['@localizedName'] = localizedName,
                ['@plate']     = plate,
            }, function(results)
                if results[1] == nil then
                    MySQL.Async.execute('INSERT INTO `ngwd_vehicles` (`owner`, `modelHash`, `localizedName`, `plate`) VALUES (@owner, @modelHash, @localizedName, @plate)',
                    {
                        ['@owner']  = identifier, 
                        ['modelHash']   = modelHash,
                        ['@localizedName'] = localizedName,
                        ['@plate']  = plate;
                    })
                    if Config.Debug then
                        print("^2  [SUCCESS]: Inserted vehicle owned by: ".. identifier .. " with the plate " .. plate .. ".")
                    end
                    if Config.purchaseNotification then
                        TriggerClientEvent('NGWD:notifySuccess', source, "" .. modelHash .. " Was purchased successfully.")
                    end
                else
                    if Config.Debug then
                        print("^1 [ERROR]: Duplicate Entry for " .. modelHash .. ". User: ".. identifier .. "")
                    end
                    if Config.purchaseNotification then
                        TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be purchased.")
                    end
                end
            end)
        else
            if Config.Debug then
                print("^1 [ERROR] Purchasing Vehicle: Model and plate not found.")
            end
        end
    else
        TriggerClientEvent('NGWD:notifyError', source, "Vehicle Wasn't Purchased")
        if Config.Debug then
            print("^1 [ERROR] Purchasing Vehicle, Identifier Not Found.")
        end
    end
end)

RegisterNetEvent('NGWD:storeVehicle', function(vehicle, garageName, plate, modelHash, localizedName, vehicleProperties, vehicleCondition)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    if identifier then
        if plate ~= nil and modelHash ~= nil then
            MySQL.Async.fetchAll('SELECT * FROM ngwd_vehicles WHERE (modelHash, plate) = (@modelHash, @plate)', {
                ['@modelHash']  = modelHash,
                ['@plate']  = plate,
            }, function(results)
                if results[1] ~= nil then
                    if results[1].owner == identifier then
                        MySQL.Async.execute('UPDATE ngwd_vehicles SET garage = @garage WHERE plate = @plate', { 
                            ['@owner'] = identifier, 
                            ['@modelHash'] = modelHash,
                            ['@localizedName'] = localizedName,
                            ['@plate'] = plate, 
                            ['@garage'] = garageName 
                        }, function(affectedRows)
                        end)             
                        TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                        if Config.Debug then
                            print("^2 [SUCCESS]: Vehicle owned by: ^5".. results[1].owner .. "^2 with the plate ^5" .. plate .. "^2 has been stored at ^5" .. garageName .. " Garage")
                        end
                        Wait(1000)
                        TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. " Garage")
                    elseif results[1].owner ~= identifier then
                        if not Config.ownerRestricted then
                            MySQL.Async.execute('UPDATE ngwd_vehicles SET garage = @garage WHERE plate = @plate', { 
                                ['@owner'] = identifier, 
                                ['@modelHash'] = modelHash,
                                ['@localizedName'] = localizedName,
                                ['@plate'] = plate, 
                                ['@garage'] = garageName 
                            }, function(affectedRows)end)                       
                            TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                            Wait(1000)
                            TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. " Garage")
                            if Config.Debug then
                                print("^3 [SUCCESS]: Vehicle owned by: ^2".. results[1].owner .. "^3 with the plate ^2" .. plate .. "^3 has been stored at ^2" .. garageName .. " Garage")
                            end
                        else
                            TriggerClientEvent('NGWD:notifyError', source, "Ownership Required")
                            if Config.Debug then
                                print("^6 [INFO]: Prevented User ^5" .. identifier .. "^1 from storing ^2" .. results[1].owner .. "'s ^1 vehicle")
                            end
                        end
                    end
                else
                    if Config.Debug then
                        print("^1  [ERROR]: Couldn't find the modelHash " .. modelHash .. " owned by: ".. identifier .. " with the plate " .. plate .. ".")
                    end
                    TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be Stored")
                end
            end)
        else
            if Config.Debug then
                print("^1  [ERROR]: Unable to store vehicle, plate or modelHash is nil")
            end
        end
    else
        if Config.Debug then
            print("^1 [ERROR]: Unable to store vehicle, identifier not found.")
        end
    end
end)

RegisterNetEvent('NGWD:sellVehicle', function(plate)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    if plate ~= nil then
        MySQL.Async.fetchAll('SELECT * FROM ngwd_vehicles WHERE (owner, modelHash, plate) = (@owner, @modelHash, @plate)', {
            ['@owner']  = identifier,
            ['@modelHash']  = modelHash,
            ['@plate']  = plate,
        }, function(results)
            if results then
                MySQL.Async.execute('DELETE FROM ngwd_vehicles WHERE `owner` = @identifier AND plate = @plate',
                {
                    ['@identifier'] = identifier,
                    ['@plate']     = plate
                }, function(rowsChanged) 
                    if rowsChanged ~= 0 then
                        if Config.Debug then
                            print("^5  [SUCCESS]: Deleted " .. rowsChanged.. " vehicles owned by: ".. identifier .. " with the plate " .. plate .. ".")
                        end                 
                    else
                        if Config.Debug then
                            print("^1  [ERROR]: No vehicle found with the plate: " .. plate .. "")
                        end   
                    end
                end)
            end
        end)
    else
        if Config.Debug then
            print("^1  [ERROR]: Unable to sell vehice, no plate was found.")
        end  
    end
end)

RegisterNetEvent('NGWD:spawnVehicle', function(plate)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    if plate ~= nil then
        MySQL.Async.fetchAll('SELECT * FROM ngwd_vehicles WHERE (owner, plate) = (@owner, @plate)', {
            ['@owner']  = identifier,
            ['@plate']  = plate
        }, function(results)
            if results then
                modelHash = results[1].modelHash
                plate = results[1].plate
                TriggerClientEvent('NGWD:spawnVehicle', source, modelHash, plate)
            else
                if Config.Debug then
                    print("^1  [ERROR]: No vehicle found with the plate: " .. plate .. " owned by " .. identifier .. "")
                end  
            end
        end)
    else
        if Config.Debug then
            print("^1  [ERROR]: Unable to spawn vehice, no plate was found.")
        end  
    end
end)

RegisterNetEvent('NGWD:giveVehicle', function()
    -- This will be used to give ownership of the vehicle to another player.
        -- Might use for keys or just peer to peer selling.
end)

RegisterNetEvent('NGWD:impoundVehicle', function()
    -- This will be used to send the vehicle to the Impound Garage.
end)

RegisterNetEvent('NGWD:releaseVehicle', function()
    -- This will be used to release the vehicle from the impound lot and spawn at a pre determined garage based off the config.
end)

