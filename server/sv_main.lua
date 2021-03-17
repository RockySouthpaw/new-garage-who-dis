RegisterNetEvent('NGWD:purchaseVehicle', function(plate, modelName)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    if identifier then
        MySQL.Async.fetchAll('SELECT * FROM ngwd_vehicles WHERE (owner, model, plate) = (@owner, @model, @plate)', {
            ['@owner']  = identifier,
            ['@model']  = modelName,
            ['@plate']  = plate,
        }, function(results)
            if results[1] == nil then
                MySQL.Async.execute('INSERT INTO `ngwd_vehicles` (`owner`, `model`, `plate`) VALUES (@owner, @model, @plate)',
                {
                    ['@owner']  = identifier, 
                    ['model']   = modelName,
                    ['@plate']  = plate;
                })
                if Config.Debug then
                    print("^2  [SUCCESS]: Inserted vehicle owned by: ".. identifier .. " with the plate " .. plate .. ".")
                end
                if Config.purchaseNotification then
                    TriggerClientEvent('NGWD:notifySuccess', source, "" .. modelName .. " Was purchased successfully.")
                end
            else
                if Config.Debug then
                    print("^1 [ERROR]: Duplicate Entry for " .. modelName .. ". User: ".. identifier .. "")
                end
                if Config.purchaseNotification then
                        TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be purchased.")
                end
            end
        end)
    else
        TriggerClientEvent('NGWD:notifyError', source, "Vehicle Wasn't Purchased")
        if Config.Debug then
            print("^1 [ERROR] Purchasing Vehicle, Identifier Not Found.")
        end
    end
end)

RegisterNetEvent('NGWD:storeVehicle', function(vehicle, garageName, plate, modelName, vehicleProperties, vehicleCondition, vehicleMods)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    if identifier then
        MySQL.Async.fetchAll('SELECT * FROM ngwd_vehicles WHERE (model, plate) = (@model, @plate)', {
            ['@model']  = modelName,
            ['@plate']  = plate,
        }, function(results)
            --print(results[1].owner)
            if results[1] ~= nil then
                if results[1].owner == identifier then
                    MySQL.Async.execute('UPDATE ngwd_vehicles SET garage = @garage WHERE plate = @plate', -- Need to set properties too
                    { ['@owner'] = identifier, ['@model'] = modelName, ['@plate'] = plate, ['@garage'] = garageName },
                    function(affectedRows)end)             
                    TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                    if Config.Debug then
                        print("^2 [SUCCESS]: Vehicle owned by: ^5".. results[1].owner .. "^2 with the plate ^5" .. plate .. "^2 has been stored at ^5" .. garageName .. "")
                    end
                    Wait(1000)
                    TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. "")
                elseif results[1].owner ~= identifier then
                    if not Config.ownerRestricted then
                        MySQL.Async.execute('UPDATE ngwd_vehicles SET garage = @garage WHERE plate = @plate', -- Need to set properties too
                        { ['@owner'] = identifier, ['@model'] = modelName, ['@plate'] = plate, ['@garage'] = garageName },
                        function(affectedRows)end)                       
                        TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                        Wait(1000)
                        TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. "")
                        if Config.Debug then
                            print("^3 [SUCCESS]: Vehicle owned by: ^2".. results[1].owner .. "^3 with the plate ^2" .. plate .. "^3 has been stored at ^2" .. garageName .. "")
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
                    print("^1  [ERROR]: Couldn't find the model " .. modelName .. " owned by: ".. identifier .. " with the plate " .. plate .. ".")
                end
                TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be Stored")
            end
        end)
    else
        if Config.Debug then
            print("^1 [ERROR]: Unable to store vehicle, identifier not found.")
        end
    end
end)

RegisterNetEvent('NGWD:deleteVehicle', function(plate)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    MySQL.Async.fetchAll('SELECT * FROM ngwd_vehicles WHERE (owner, model, plate) = (@owner, @model, @plate)', {
        ['@owner']  = identifier,
        ['@model']  = modelName,
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
                        print("^1  [ERROR]: No vehicle was deleted.")
                    end   
                end
            end)
        end
    end)
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

