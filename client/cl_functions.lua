-- Variables
local activeNotification = false
local Delay = 500

if Config.esxNotify then
    ESX              = nil
    local PlayerData = {}

    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
end

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
                    message = "Press **~c~["..Config.storageKey.."]~c~** To Park Vehicle",
                    position = Config.tLocation
                    
                }
            })
        end
        if Config.mythicNotify then
            text = "Press ["..Config.storageKey.."] To Park Vehicle"
            exports['mythic_notify']:PersistentAlert('start',id,'inform', text, { ['background-color'] = Config.backgroundColor })
        end
        if Config.pNotify then
            Citizen.CreateThread(function()
                while activeNotification do
                    Citizen.Wait(10)
                    local coords = GetEntityCoords(vehicle)
                    floatingNotification("Press ~y~["..Config.storageKey.."]~w~ To Park Vehicle", vector3(coords.x, coords.y, coords.z + 1))
                end
            end)
        end
        if Config.esxNotify then
            Citizen.CreateThread(function()
                while activeNotification do
                    Citizen.Wait(10)
                    local coords = GetEntityCoords(vehicle)
                    floatingNotification("Press ~y~["..Config.storageKey.."]~w~ To Park Vehicle", vector3(coords.x, coords.y, coords.z + 1))
                end
            end)
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
                    message = "Press **~c~["..Config.retrieveKey.."]~c~** To Retrieve Vehicle",
                    position = Config.tLocation
                }
            })
        end
        if Config.mythicNotify then
            text = "Press ["..Config.retrieveKey.."] To Retrieve Vehicle"
            exports['mythic_notify']:PersistentAlert('start',id,'inform', text, { ['background-color'] = Config.backgroundColor })
        end
        if Config.pNotify then
            Citizen.CreateThread(function()
                while activeNotification do
                    Citizen.Wait(10)
                    local coords = GetEntityCoords(PlayerPedId())
                    floatingNotification("Press ~y~["..Config.retrieveKey.."]~w~ To Retrieve Vehicle", vector3(coords.x, coords.y, coords.z + 1))
                end
            end)
        end
        if Config.esxNotify then
            Citizen.CreateThread(function()
                while activeNotification do
                    Citizen.Wait(10)
                    local coords = GetEntityCoords(PlayerPedId())
                    floatingNotification("Press ~y~["..Config.retrieveKey.."]~w~ To Retrieve Vehicle", vector3(coords.x, coords.y, coords.z + 1))
                end
            end)
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

function floatingNotification(message, coords) -- by Lucas.#4689 in ESX Discord.
    AddTextEntry('floatingNotification', message)
    SetFloatingHelpTextWorldPosition(1, coords)
    SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
    BeginTextCommandDisplayHelp('floatingNotification')
    EndTextCommandDisplayHelp(2, false, false, -1)
end

-- Functions (Core)
function storeVehicle(vehicle, garageName)
    if not inProgress then
        inProgress = true
        local vehicleProperties = getVehicleProperties(vehicle)
        local vehicleCondition = getVehicleCondition(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        local modelHash = GetEntityModel(vehicle)
        local modelName = GetDisplayNameFromVehicleModel(modelHash)
        local localizedName = GetLabelText(modelName)

        if garageName ~= nil then
            TriggerServerEvent('NGWD:storeVehicle', vehicle, garageName, plate, modelHash, localizedName, vehicleProperties, vehicleCondition)
            inProgress = false
        elseif garageName ~= nil then
            message = 'Invalid Garage!'
            TriggerEvent('NGWD:notifyError', message)
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
