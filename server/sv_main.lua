RegisterNetEvent('NGWD:purchaseVehicle', function(plate, modelName, amount)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
    if identifier then
        -- Insert the vehicle owner, plate and model into the SQL. No need to store any other information since the player will store it after they buy it.
        MySQL.Async.execute('INSERT INTO `ngwd_vehicles` (`owner`, `model`, `plate`) VALUES (@owner, @model, @plate,)',
        {
            ['@owner']  = identifier, -- Change to vehicle Owner.
            ['model']   = modelName,
            ['@plate']  = plate;
        })
        TriggerClientEvent('NGWD:notifySuccess', source, "" .. modelName .. "Was purchased successfully.")
        -- Trigger removal of money here
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
        MySQL.Async.fetchScalar('SELECT 1 FROM ngwd_vehicles WHERE (owner, plate, model) = (@owner, @plate, @model)', {
            ['@owner']  = identifier,
            ['@model']  = modelName,
            ['@plate']  = plate,
        }, function(results)
            if not results then -- Needs to be "If owner == identifier then
                    MySQL.Async.execute('INSERT INTO `ngwd_vehicles` (`owner`, `plate`, `garage`, `model`) VALUES (@owner, @plate, @garage, @model)',
                    {
                        ['@owner']  = identifier, -- Change to vehicle Owner.
                        ['model']   = modelName,
                        ['@plate']  = plate;
                        ['@garage'] = garageName
                    })
                    TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                    Wait(1000)
                    TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. "")
--[[        else -- If they're not the owner and the vehicle is purchased,
                if not Config.ownerRestricted then
                    -- Update garage, vehicleProperties, vehicleCondition, and vehicleMods
                    TriggerClientEvent('NGWD:leaveVehicle', source, vehicle)
                    Wait(1000)
                    TriggerClientEvent('NGWD:notifySuccess', source, "Vehicle Stored Successfully at " .. garageName .. "")
                else
                    TriggerClientEvent('NGWD:notifyError', source, "Ownership Required")
                end
            else -- If they're not the owner and the vehicle is NOT purchased.
                -- Trigger webhook incase it was cheated in
                TriggerClientEvent('NGWD:notifyError', source, "Vehicle Can't be Stored")
]]
            end
        end)
    else
        print("^1 Error Storing Vehicle, Identifier Not Found.")
    end
end)

RegisterNetEvent('NGWD:previewVehicle', function(plate)
    -- Trigger this from a menu and take the selected vehicles plate and pass to server side.
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end

    -- Do a querry for where we stored vehicleProperties, vehicleCondition, vehicleMods

    -- Trigger a vehicle preview event and pass the args

    -- Create the vehicle on the client so its not seen server side and make the player invisble.

    -- When they select the vehicle, delete it on the client and trigger the below event
end)

RegisterNetEvent('NGWD:fetchVehicle', function(plate)
    -- This gets the selected vehicle from the SQL
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end

    -- Do a querry for where we stored vehicleProperties, vehicleCondition, vehicleMods

    -- Trigger a client event that creates a vehicle as a network entity so its synced server side. (or use one sync?)
end)

RegisterNetEvent('NGWD:deleteVehicle', function(plate)
    -- This will be used to delete the selected vehicle from the database. Can be done if they sold it.
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, Config.Identifier) then
            identifier = string.sub(v, 9)
            break
        end
    end
        -- Check if they're the vehicle owner first by comparing their identifier to the results of the owner table
--[[
        if results ~= identifier and result ~= null then 
           -- trigger an alert saying they dont own this vehicle
        elseif results == identifier and plate == plate then
            -- do a querry to Delete the vehicle information from the garage. 
            -- Trigger a money event here. (Configed)
        elseif results ~= identifier and result == null then 
           -- trigger a webhook with model, plate, and identifier saying they tried to sell a vehicle that isn't in DB. Could be a local car or someone trying to exploit.
        end
]]
end)


RegisterNetEvent('NGWD:giveVehicle', function()
    -- This will be used to give ownership of the vehicle to another player.
        -- Might use for keys or just peer to peer selling.
end)

RegisterNetEvent('NGWD:impoundVehicle', function()
    -- This will be used to send the vehicle to the Impound Garage. Will 
end)

RegisterNetEvent('NGWD:releaseVehicle', function()
    -- This will be used to release the vehicle from the impound lot and spawn at a pre determined garage based off the config.
end)

