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
                timeout = 1000 * Config.duration,
                layout = Config.layout,
                theme = Config.theme,
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
                timeout = 1000 * Config.duration,
                layout = Config.layout,
                theme = Config.theme,
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
        local plate = GetVehicleNumberPlateText(vehicle)
        local modelHash = GetEntityModel(vehicle)
        local modelName = GetDisplayNameFromVehicleModel(modelHash)
        local localizedName = GetLabelText(modelName)

        if garageName ~= nil then
            TriggerServerEvent('NGWD:storeVehicle', vehicle, garageName, plate, modelHash, localizedName, vehicleProperties, vehicleCondition)
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

-- Exports

function getVehicleCondition(vehicle) -- make async export 
    if DoesEntityExist(vehicle) then
        local Condition = {}
        
        Condition.engineHealth = GetVehicleEngineHealth(vehicle)
        Condition.bodyHealth = GetVehicleBodyHealth(vehicle)
        Condition.tankHealth = GetVehiclePetrolTankHealth(vehicle)
        Condition.fuelLevel = GetVehicleFuelLevel(vehicle)
        Condition.oilLevel = GetVehicleOilLevel(vehicle)
        Condition.dirt = GetVehicleDirtLevel(vehicle)
        Condition.tires = {}
        for i = 0,3 do
            Condition.tires[i] = GetVehicleWheelHealth(vehicle, i)
        end
        return Condition
    else
        return
    end
end
exports('getVehicleCondition', getVehicleCondition)

function getVehicleProperties(vehicle) -- make async export 
    if DoesEntityExist(vehicle) then
        local Property = {}

        Property.vehicleMods = {}
        for i = 0,49 do
            Property.vehicleMods[i] = GetVehicleMod(vehicle, i)
        end
        Property.Extras = {}
        for i = 1,14 do
            Property.Extras[i] = DoesExtraExist(vehicle, i)
        end
        Property.Neons = {}
        for i = 0,3 do
            Property.Neons[i] = IsVehicleNeonLightEnabled(vehicle, i)
        end
        Property.neonColor = {}
        Property.neonColor.r, Property.neonColor.g, Property.neonColor.b = GetVehicleNeonLightsColour(vehicle)
        Property.smokeColor = {}
        Property.smokeColor.r, Property.smokeColor.g, Property.smokeColor.b = GetVehicleTyreSmokeColor(vehicle)

        Property.turboPurchased = IsToggleModOn(vehicle, 18)
        Property.smokePurchased = IsToggleModOn(vehicle, 20)
        Property.xenonEnabled = IsToggleModOn(vehicle, 22)
        Property.lightsState = GetVehicleLightsState(vehicle)
        Property.colorPrimary, ColorSecondary = GetVehicleColours(vehicle) -- Use with SetVehicleColours
        Property.pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
        Property.plateIndex = GetVehicleNumberPlateTextIndex(vehicle)
        Property.headlightColor = GetVehicleHeadlightsColour(vehicle) -- Formally known as GetVehicleHeadlightsColour
        Property.interiorColor = GetVehicleInteriorColour(vehicle)
        Property.dashboardColor = GetVehicleDashboardColour(vehicle)
        Property.Livery  = (GetVehicleLiveryCount(vehicle) == -1 and GetVehicleMod(vehicle, 48)) or GetVehicleLivery(vehicle) -- AvarianKnight
        Property.liveryRoof = GetVehicleRoofLivery(vehicle)
        Property.wheelSize = GetVehicleWheelSize(vehicle)
        Property.wheelWidth = GetVehicleWheelWidth(vehicle)
        Property.wheelType = GetVehicleWheelType(vehicle)
        Property.windowTint = GetVehicleWindowTint(vehicle)
        return Property
    else
        return
    end
end
exports('getVehicleProperties', getVehicleProperties)