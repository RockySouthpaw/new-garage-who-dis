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
                print("^2  Success: Inserted vehicle owned by: ".. identifier .. " with the plate " .. plate .. ".")
                if Config.purchaseNotification then
                    TriggerClientEvent('NGWD:notifySuccess', source, "" .. modelName .. " Was purchased successfully.")
                end
            else
                print("^1 Error: Duplicate Entry for " .. modelName .. ". User: ".. identifier .. "")
                if Config.purchaseNotification then
                        TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be purchased.")
                end
            end
        end)
    else
        TriggerClientEvent('NGWD:notifyError', source, "Vehicle Wasn't Purchased")
        print("^1 Error Purchasing Vehicle, Identifier Not Found.")
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
                    print("^2 Success: Vehicle owned by: ^5".. results[1].owner .. "^2 with the plate ^5" .. plate .. "^2 has been stored at ^5" .. garageName .. "")
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
                        print("^3 Succes: Vehicle owned by: ^2".. results[1].owner .. "^3 with the plate ^2" .. plate .. "^3 has been stored at ^2" .. garageName .. "")
                    else
                        TriggerClientEvent('NGWD:notifyError', source, "Ownership Required")
                        print("^6 Info: Prevented User ^5" .. identifier .. "^1 from storing ^2" .. results[1].owner .. "'s ^1 vehicle")
                    end
                end
            else
                print("^1  Error: Couldn't find the model " .. modelName .. " owned by: ".. identifier .. " with the plate " .. plate .. ".")
                TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be Stored")
            end
        end)
    else
        print("^1 Error: Error Storing Vehicle, Identifier Not Found.")
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
                    print("^5  Success: Deleted " .. rowsChanged.. " vehicles owned by: ".. identifier .. " with the plate " .. plate .. ".")
                else
                    print("^1  Error: No vehicle was deleted.")
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

