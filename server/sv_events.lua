if Config.useMysqlAsync then
    execute     = MySQL.Async.execute
    fetchAll    = MySQL.Async.fetchAll
    fetchScalar = MySQL.Async.fetchScalar
end

if Config.useGhmattimysql then
    execute   = exports.ghmattimysql.execute
    fetchAll  = exports.ghmattimysql.execute 
end

RegisterNetEvent('NGWD:purchaseVehicle', function(plate, modelHash, localizedName) -- Should also pass the modelName maybe?
    local source        = source
    local identifier    = Utils.getPlayerIdentifier(source)
    if identifier then
        if plate ~= nil and modelHash ~= nil then
            -- can also add a distance check for the dealership cords and trigger a kick event..
            fetchScalar('SELECT 1 FROM '..Config.databaseName..' WHERE (owner, plate) = (@owner, @plate)', {
                ['owner']          = identifier,
                ['plate']          = plate,
            }, function(results)
                if results == nil then
                    execute('INSERT INTO '..Config.databaseName..' (owner, modelHash, localizedName, plate) VALUES (@owner, @modelHash, @localizedName, @plate)',
                    {
                        ['owner']          = identifier, 
                        ['modelHash']      = modelHash,
                        ['localizedName']  = localizedName,
                        ['plate']          = plate;
                    })
                    Utils.Debug('success', " ".. identifier .. " Purchased a vehicle with the plate " .. plate .. ".")
                    if Config.purchaseNotification then
                        TriggerClientEvent('NGWD:notifySuccess', source, "" .. modelHash .. " Was purchased successfully.")
                    end
                else
                    Utils.Debug('error', "Duplicate Entry for ^1[" ..plate.. "]^0 owned by: ^3[".. identifier .. "]^0")
                    if Config.purchaseNotification then
                        TriggerClientEvent('NGWD:notifyError', source, "Vehicle can't be purchased.")
                    end
                end
            end)
        else
            Utils.Debug('error', "Purchasing Vehicle: Model and plate not found.")
        end
    else
        TriggerClientEvent('NGWD:notifyError', source, "Vehicle Wasn't Purchased")
        Utils.Debug('error', "Purchasing Vehicle, Identifier Not Found.")
    end
end)

RegisterNetEvent('NGWD:storeVehicle', function(vehicle, garageName, plate, modelHash, localizedName, vehicleProperties, vehicleCondition, vehicleMods)
    local source        = source
    local identifier    = Utils.getPlayerIdentifier(source)
    if identifier then
        if plate ~= nil and modelHash ~= nil then
            fetchAll('SELECT * FROM '..Config.databaseName..' WHERE (modelHash, plate) = (@modelHash, @plate)', {
                ['modelHash']  = modelHash,
                ['plate']      = plate,
            }, function(results)
                if results and results[1] then
                    if results[1].owner == identifier then
                        execute('UPDATE '..Config.databaseName..' SET garage = @garage, vehicleProperties = @vehicleProperties, vehicleCondition = @vehicleCondition, vehicleMods = @vehicleMods WHERE plate = @plate', { 
                            ['owner']                  = identifier, 
                            ['modelHash']              = modelHash,
                            ['localizedName']          = localizedName,
                            ['plate']                  = plate, 
                            ['garage']                 = garageName,
                            ['vehicleProperties']      = json.encode(vehicleProperties),
                            ['vehicleCondition']       = json.encode(vehicleCondition),
                            ['vehicleMods']            = json.encode(vehicleMods)
                        })             
                        TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                        Utils.Debug('inform', "Vehicle owned by: ^5".. results[1].owner .. "^2 with the plate ^5" .. plate .. "^2 has been stored at ^5" .. garageName .. " Garage")
                        Wait(1000)
                        TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. " Garage")
                    elseif results[1].owner ~= identifier then
                        if not Config.ownerRestricted then
                            execute('UPDATE '..Config.databaseName..' SET garage = @garage, vehicleProperties = @vehicleProperties, vehicleCondition = @vehicleCondition, vehicleMods = @vehicleMods WHERE plate = @plate', { 
                                ['owner']                  = identifier, 
                                ['modelHash']              = modelHash,
                                ['localizedName']          = localizedName,
                                ['plate']                  = plate, 
                                ['garage']                 = garageName,
                                ['vehicleProperties']      = json.encode(vehicleProperties),
                                ['vehicleCondition']       = json.encode(vehicleCondition),
                                ['vehicleMods']            = json.encode(vehicleMods)
                            })                      
                            TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                            Wait(1000)
                            TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. " Garage")
                            Utils.Debug('inform', "Vehicle owned by: ^2".. results[1].owner .. "^3 with the plate ^2" .. plate .. "^3 has been stored at ^2" .. garageName .. " Garage")
                        else
                            TriggerClientEvent('NGWD:notifyError', source, "Ownership Required")
                            Utils.Debug('inform', "Prevented User ^5" .. identifier .. "^1 from storing ^2" .. results[1].owner .. "'s ^1 vehicle")
                        end
                    end
                else
                    Utils.Debug('error', "Unable to find the modelHash " .. modelHash .. " owned by: ".. identifier .. " with the plate " .. plate .. ".")
                    TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be Stored")
                end
            end)
        else
            Utils.Debug('error', "Unable to store vehicle, plate or modelHash is nil")
        end
    else
        Utils.Debug('error', "Unable to store vehicle, identifier not found.")
    end
end)

RegisterNetEvent('NGWD:spawnVehicle', function(plate, garageName)
    local source        = source
    local identifier    = Utils.getPlayerIdentifier(source)
    if plate ~= nil then
        fetchAll('SELECT * FROM '..Config.databaseName..' WHERE (owner, plate, garage) = (@owner, @plate, @garage)', {
            ['owner']              = identifier,
            ['plate']              = plate,
            ['garage']             = garageName
        }, function(results)
            if results ~= nil then
                modelHash           = results[1].modelHash
                plate               = results[1].plate
                vehicleProperties   = json.decode(results[1].vehicleProperties)
                vehicleCondition    = json.decode(results[1].vehicleCondition)
                vehicleMods         = json.decode(results[1].vehicleMods)
                local plyPed = GetPlayerPed(source)
                local vehNet, veh = createVehicle(source, plyPed, modelHash, GetEntityCoords(plyPed))
                if not vehNet then 
                    return 
                end
                TriggerClientEvent('NGWD:setVehicleProperties', source, vehNet, plate, vehicleProperties, vehicleCondition, vehicleMods)

                Wait(100)
                if not DoesEntityExist(veh) then 
                    return 
                end
            else
                Utils.Debug('error', "No vehicle found owned by: " .. identifier .. " With Plate " .. plate .. "") 
            end
        end)
    else
       Utils.Debug('error', "Unable to spawn vehice, no plate was found.")  
    end
end)

RegisterNetEvent('NGWD:sellVehicle', function(plate)
    local source        = source
    local identifier    = Utils.getPlayerIdentifier(source)
    if plate ~= nil then
        fetchAll('SELECT * FROM '..Config.databaseName..' WHERE (owner, modelHash, plate) = (@owner, @modelHash, @plate)', {
            ['owner']      = identifier,
            ['modelHash']  = modelHash,
            ['plate']      = plate,
        }, function(results)
            if results then
                execute('DELETE FROM '..Config.databaseName..' WHERE owner = @identifier AND plate = @plate',
                {
                    ['identifier'] = identifier,
                    ['plate']      = plate
                }, function(rowsChanged) 
                    if rowsChanged ~= 0 then
                        if Debug.debugLevel >= 2 then
                            Utils.Debug('success', "Deleted " .. rowsChanged.. " vehicles owned by: ".. identifier .. " with the plate " .. plate .. ".")
                        end                 
                    else
                        Utils.Debug('error', "No vehicle found with the plate: " .. plate .. "")  
                    end
                end)
            end
        end)
    else
        Utils.Debug('error', "Unable to sell vehice, no plate was found.")
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
