RegisterNetEvent('NGWD:storeVehicle')
AddEventHandler('NGWD:storeVehicle', function(vehicle, garageName, vehicleProperties, vehicleCondition, vehicleMods)
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, 'license:') then
            identifier = string.sub(v, 9)
            break
        end
    end
        -- Check if they're the vehicle owner and if the plate exist in the database

--[[
        if results ~= identifier and result ~= null then 
           -- check config for if non owners can store vehicles.
            if Config.ownerRestricted then
               -- dont delete vehicle and trigger a failure notification
            elseif not Config.ownerRestricted then
                deleteVehicle(vehicle) -- this will trigger a success on its own
            end
        elseif results ~= identifier and result == null then 
           -- trigger a webhook with model, plate, and identifier saying they tried to store a vehicle that isn't in DB. Could be a local car or someone trying to exploit.
        end

        -- do a querry for the plate to see if it already exist and if the owner = source, and if so update it.


]]
end)

RegisterNetEvent('NGWD:previewVehicle')
AddEventHandler('NGWD:previewVehicle', function(plate)
    -- TYrigger this from a menu and take the selected vehicles plate and pass to server side.
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, 'license:') then
            identifier = string.sub(v, 9)
            break
        end
    end

    -- Do a querry for where we stored vehicleProperties, vehicleCondition, vehicleMods

    -- Trigger a vehicle preview event and pass the args

    -- Create the vehicle on the client so its not seen server side and make the player invisble.

    -- When they select the vehicle, delete it on the client and trigger the below event
end)

RegisterNetEvent('NGWD:fetchVehicle')
AddEventHandler('NGWD:fetchVehicle', function(plate)
    -- This gets the selected vehicle from the SQL
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, 'license:') then
            identifier = string.sub(v, 9)
            break
        end
    end

    -- Do a querry for where we stored vehicleProperties, vehicleCondition, vehicleMods

    -- Trigger a client event that creates a vehicle as a network entity so its synced server side. (or use one sync?)
end)

RegisterNetEvent('NGWD:deleteVehicle')
AddEventHandler('NGWD:fetchVehicle', function(plate)
    -- This will be used to delete the selected vehicle from the database. Can be done if they sold it.
    local source = source
    for k, v in ipairs(GetPlayerIdentifiers(source)) do 
        if string.match(v, 'license:') then
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


RegisterNetEvent('NGWD:giveVehicle')
AddEventHandler('NGWD:giveVehicle', function()
    -- This will be used to give ownership of the vehicle to another player.
        -- Might use for keys or just peer to peer selling.
end)

