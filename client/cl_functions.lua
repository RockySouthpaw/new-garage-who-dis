-- Variables
local activeNotification = false
local Delay = 500

-- Function (Notification)
function notifyStorePrompt(garage, id)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local driver  = GetPedInVehicleSeat(vehicle, -1)
    if not activeNotification and driver == PlayerPedId() then
        if Config.tNotify then 
            exports['t-notify']:Persist({
                id = id,
                step = 'start',
                options = {
                    style = 'message',
                    title = garage.. ' Parking',
                    sound = true,
                    message = "Press **["..Config.storageKey.."]** To Park Vehicle",
                    position = Config.tLocation
                    
                }
            })
        end
        if Config.mythicNotify then
            text = "Press ["..Config.storageKey.."] To Park Vehicle"
            exports['mythic_notify']:PersistentAlert('start',id,'inform', text, { ['background-color'] = Config.backgroundColor })
        end
        if Config.pNotify then
            exports.pNotify:SetQueueMax(id, 1)
            exports.pNotify:SendNotification({
                text = "Press ["..Config.storageKey.."] To Park Vehicle",
                type = "info",
                timeout = 1000 * Config.Duration,
                layout = Config.Layout,
                theme = Config.Theme,
                queue = "id"
            })
        end
        activeNotification = true
        Wait(Delay)
    end
end

function notifyRetrievePrompt(garage, id)
    if not activeNotification then
        if Config.tNotify then 
            exports['t-notify']:Persist({
                id = id,
                step = 'start',
                options = {
                    style = 'message',
                    title = garage.. ' Parking',
                    sound = true,
                    message = "Press **["..Config.retrieveKey.."]** To Retrieve Vehicle",
                    position = Config.tLocation
                    
                }
            })
        end
        if Config.mythicNotify then
            text = "Press ["..Config.retrieveKey.."] To Retrieve Vehicle"
            exports['mythic_notify']:PersistentAlert('start',id,'inform', text, { ['background-color'] = Config.backgroundColor })
        end
        if Config.pNotify then
            exports.pNotify:SetQueueMax(id, 1)
            exports.pNotify:SendNotification({
                text = "Press ["..Config.retrieveKey.."] To Retrieve Vehicle",
                type = "info",
                timeout = 1000 * Config.Duration,
                layout = Config.Layout,
                theme = Config.Theme,
                queue = "id"
            })
        end
        activeNotification = true
        Wait(Delay)
    end
end

function notifyEnd(id)
    if activeNotification then
        if Config.tNotify then 
            exports['t-notify']:Persist({
                id = id,
                step = 'end'
            })
        end
        if Config.mythicNotify then
            exports['mythic_notify']:PersistentAlert('end', id)
        end
        activeNotification = false
        Wait(Delay)
    end
end

-- Functions (Core)
function storeVehicle(vehicle, garageName)
    if not inProgress then -- Checks if its already storing a vehicle to prevent key spam.
        inProgress = true
        local vehicleProperties = getVehicleProperties(vehicle)
        local vehicleCondition = getVehicleCondition(vehicle)
        local vehicleMods = getVehicleModkits(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        local modelHash = GetEntityModel(vehicle)
        local modelName = GetDisplayNameFromVehicleModel(modelHash)
        local localizedName = GetLabelText(modelName)

        if garageName ~= nil then
            TriggerServerEvent('NGWD:storeVehicle', vehicle, garageName, plate, modelHash, localizedName, vehicleProperties, vehicleCondition, vehicleMods)
            Wait(500)
            inProgress = false
        elseif garageName ~= nil then
            message = 'Invalid Garage!'
            TriggerEvent('NGWD:notifyError', message)
            Wait(500)
            inProgress = false
        end
    end
end

function deleteVehicle(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)
end

function vehicleUtils(vehicle)
    if DoesEntityExist(vehicle) then
        local netId = NetworkGetNetworkIdFromEntity(vehicle)
        SetNetworkIdCanMigrate(netId, true) -- idk if this even needs to be a thing.
        SetVehicleHasBeenOwnedByPlayer(vehicle, true)
        SetVehicleNeedsToBeHotwired(vehicle, false)
        SetVehicleAlarm(vehicle, false)
        SetVehRadioStation(vehicle, "OFF")
    end
end

function vehicleSetters(vehicle, fuel, plate)
    if DoesEntityExist(vehicle) then
        SetVehicleFuelLevel(vehicle, fuel)
        SetVehicleNumberPlateText(vehicle, plate)
    end
end

-- Functions (Exports)
function getVehicleProperties(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleProperties = 
        {
            {lightsState = GetVehicleLightsState(vehicle)},
            {colorPrimary, ColorSecondary = GetVehicleColours(vehicle)}, -- Use with SetVehicleColours
            {pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)},
            {plateIndex = GetVehicleNumberPlateTextIndex(vehicle)},
            {tyreSmoke = GetVehicleTyreSmokeColor(vehicle)},
            {headlightColor = GetVehicleHeadlightsColour(vehicle)},
            {interiorColor = GetVehicleInteriorColour(vehicle)},
            {dashboardColor = GetVehicleDashboardColour(vehicle)},
            {liveryRoof = GetVehicleRoofLivery(vehicle)},
            {livery = (GetVehicleLiveryCount(vehicle) == -1 and GetVehicleMod(vehicle, 48)) or GetVehicleLivery(vehicle)},
            {wheelSize = GetVehicleWheelSize(vehicle)},
            {wheelWidth = GetVehicleWheelWidth(vehicle)},
            {wheelType = GetVehicleWheelType(vehicle)},
            {windowTint = GetVehicleWindowTint(vehicle)}
        }
        return vehicleProperties
    else
        return
    end
end

function getVehicleModkits(vehicle)
    local vehicleMods = {}
    for i = 0,49 do
        vehicleMods[i] = GetVehicleMod(vehicle, i)
    end
    return vehicleMods
end

function getVehicleCondition(vehicle)
    if DoesEntityExist(vehicle) then
        local vehicleCondition = 
        {
            {engineHealth = GetVehicleEngineHealth(vehicle)},
            {bodyHealth = GetVehicleBodyHealth(vehicle)},
            {tankHealth = GetVehiclePetrolTankHealth(vehicle)},
            {fuelLevel = GetVehicleFuelLevel(vehicle)},
            {oilLevel = GetVehicleOilLevel(vehicle)},
            {dirt = GetVehicleDirtLevel(vehicle)},
            {tire1 = GetVehicleWheelHealth(vehicle, 0)},
            {tire2 = GetVehicleWheelHealth(vehicle, 1)},
            {tire3 = GetVehicleWheelHealth(vehicle, 2)},
            {tire4 = GetVehicleWheelHealth(vehicle, 3)}
        }
        return vehicleCondition
    else
        return
    end
end