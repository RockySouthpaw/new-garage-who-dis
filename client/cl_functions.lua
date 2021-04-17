-- Variables
local activeNotification = false
local Delay = 500

if Config.esxNotify then
    ESX              = nil
    local PlayerData = {}

    CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Wait(0)
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
            CreateThread(function()
                while activeNotification do
                    Wait(10)
                    local coords = GetEntityCoords(vehicle)
                    floatingNotification("Press ~y~["..Config.storageKey.."]~w~ To Park Vehicle", vector3(coords.x, coords.y, coords.z + 1))
                end
            end)
        end
        if Config.esxNotify then
            CreateThread(function()
                while activeNotification do
                    Wait(10)
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
            CreateThread(function()
                while activeNotification do
                    Wait(10)
                    local coords = GetEntityCoords(PlayerPedId())
                    floatingNotification("Press ~y~["..Config.retrieveKey.."]~w~ To Retrieve Vehicle", vector3(coords.x, coords.y, coords.z + 1))
                end
            end)
        end
        if Config.esxNotify then
            CreateThread(function()
                while activeNotification do
                    Wait(10)
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
        local vehicleMods = getVehicleMods(vehicle)
        local plate = GetVehicleNumberPlateText(vehicle)
        local modelHash = GetEntityModel(vehicle)
        local modelName = GetDisplayNameFromVehicleModel(modelHash)
        local localizedName = GetLabelText(modelName)

        if garageName ~= nil then
            TriggerServerEvent('NGWD:storeVehicle', vehicle, garageName, plate, modelHash, localizedName, vehicleProperties, vehicleCondition, vehicleMods)
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

--          Exports

-- getters
function getVehicleCondition(vehicle) -- make async export 
    if DoesEntityExist(vehicle) then
        local Condition = {}
        
        Condition.engineHealth = GetVehicleEngineHealth(vehicle)
        Condition.bodyHealth = GetVehicleBodyHealth(vehicle)
        Condition.tankHealth = GetVehiclePetrolTankHealth(vehicle)
        Condition.fuelLevel = GetVehicleFuelLevel(vehicle)
        Condition.oilLevel = GetVehicleOilLevel(vehicle)
        Condition.dirtLevel = GetVehicleDirtLevel(vehicle)
        Condition.tireHealth = {}
        for i = 0,3 do
            Condition.tireHealth[i] = GetVehicleWheelHealth(vehicle, i)
        end
        Condition.tireBurstState = {}
        for i = 0,5 do
            Condition.tireBurstState[i] = IsVehicleTyreBurst(vehicle, i, false)
        end
        Condition.tireBurstCompletely = {}
        for i = 0,5 do
            Condition.tireBurstCompletely[i] = IsVehicleTyreBurst(vehicle, i, true)
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

        Property.Extras = {}
        for i = 1,14 do
            Property.Extras[i] = IsVehicleExtraTurnedOn(vehicle, i)
        end
        Property.Neons = {}
        for i = 0,3 do
            Property.Neons[i] = IsVehicleNeonLightEnabled(vehicle, i)
        end
        Property.neonColor = {}
        Property.neonColor.r, Property.neonColor.g, Property.neonColor.b = GetVehicleNeonLightsColour(vehicle)
        Property.smokeColor = {}
        Property.smokeColor.r, Property.smokeColor.g, Property.smokeColor.b = GetVehicleTyreSmokeColor(vehicle)
        Property.vehicleColor = {}
        Property.vehicleColor.primary, Property.vehicleColor.secondary = GetVehicleColours(vehicle) -- Use with SetVehicleColours
        Property.extraColor = {}
        Property.extraColor.pearlescentColor, Property.extraColor.wheelColor = GetVehicleExtraColours(vehicle)

        Property.plateIndex = GetVehicleNumberPlateTextIndex(vehicle)
        Property.headlightColor = GetVehicleHeadlightsColour(vehicle) -- Formally known as GetVehicleHeadlightsColour
        Property.interiorColor = GetVehicleInteriorColour(vehicle)
        Property.dashboardColor = GetVehicleDashboardColour(vehicle)
        Property.wheelSize = GetVehicleWheelSize(vehicle)
        Property.wheelWidth = GetVehicleWheelWidth(vehicle)
        Property.windowTint = GetVehicleWindowTint(vehicle)
        return Property
    else
        return
    end
end
exports('getVehicleProperties', getVehicleProperties)

function getVehicleMods(vehicle) -- make async export 
    if DoesEntityExist(vehicle) then
        local Mods = {}

        Mods.Spoiler        = GetVehicleMod(vehicle, 0)
        Mods.frontBumper    = GetVehicleMod(vehicle, 1)
        Mods.rearBumper     = GetVehicleMod(vehicle, 2)
        Mods.sideSkirt      = GetVehicleMod(vehicle, 3)
        Mods.Exhaust        = GetVehicleMod(vehicle, 4)
        Mods.Frame          = GetVehicleMod(vehicle, 5)
        Mods.Grille         = GetVehicleMod(vehicle, 6)
        Mods.Hood           = GetVehicleMod(vehicle, 7)
        Mods.Fender         = GetVehicleMod(vehicle, 8)
        Mods.rightFender    = GetVehicleMod(vehicle, 9)
        Mods.Roof           = GetVehicleMod(vehicle, 10)
        Mods.Engine         = GetVehicleMod(vehicle, 11)
        Mods.Brakes         = GetVehicleMod(vehicle, 12)
        Mods.Transmission   = GetVehicleMod(vehicle, 13)
        Mods.Horns          = GetVehicleMod(vehicle, 14)
        Mods.Suspension     = GetVehicleMod(vehicle, 15)
        Mods.Armor          = GetVehicleMod(vehicle, 16)
        Mods.ModKit17       = GetVehicleMod(vehicle, 17)
        Mods.turboPurchased = IsToggleModOn(vehicle, 18)
        Mods.modKit19       = GetVehicleMod(vehicle, 19)
        Mods.smokePurchased = IsToggleModOn(vehicle, 20)
        Mods.modKit21       = GetVehicleMod(vehicle, 21)
        Mods.xenonEnabled   = IsToggleModOn(vehicle, 22)
        Mods.frontWheels    = GetVehicleMod(vehicle, 23)
        Mods.backWheels     = GetVehicleMod(vehicle, 24)
        Mods.plateHolder    = GetVehicleMod(vehicle, 25)
        Mods.VanityPlate    = GetVehicleMod(vehicle, 26)
        Mods.TrimA          = GetVehicleMod(vehicle, 27)
        Mods.Ornaments      = GetVehicleMod(vehicle, 28)
        Mods.Dashboard      = GetVehicleMod(vehicle, 29)
        Mods.Dial           = GetVehicleMod(vehicle, 30)
        Mods.doorSpeaker    = GetVehicleMod(vehicle, 31)
        Mods.Seats          = GetVehicleMod(vehicle, 32)
        Mods.steeringWheel  = GetVehicleMod(vehicle, 33)
        Mods.shifterLeavers = GetVehicleMod(vehicle, 34)
        Mods.Plaques        = GetVehicleMod(vehicle, 35)
        Mods.Speakers       = GetVehicleMod(vehicle, 36)
        Mods.Trunk          = GetVehicleMod(vehicle, 37)
        Mods.Hydrolic       = GetVehicleMod(vehicle, 38)
        Mods.engineBlock    = GetVehicleMod(vehicle, 39)
        Mods.airFilter      = GetVehicleMod(vehicle, 40)
        Mods.Struts         = GetVehicleMod(vehicle, 41)
        Mods.archCover      = GetVehicleMod(vehicle, 42)
        Mods.Aerials        = GetVehicleMod(vehicle, 43)
        Mods.TrimB          = GetVehicleMod(vehicle, 44)
        Mods.Tank           = GetVehicleMod(vehicle, 45)
        Mods.Windows        = GetVehicleMod(vehicle, 46)
        Mods.modKit47       = GetVehicleMod(vehicle, 47)
        Mods.Livery         = (GetVehicleLiveryCount(vehicle) == -1 and GetVehicleMod(vehicle, 48)) or GetVehicleLivery(vehicle) -- Provided by AvarianKnight.
        Mods.modKit49       = GetVehicleMod(vehicle, 49)
        Mods.liveryRoof     = GetVehicleRoofLivery(vehicle)
        return Mods
    else
        return
    end
end
exports('getVehicleMods', getVehicleMods)

-- Setters

function setVehicleCondition(vehicle, vehicleCondition) -- make async export 
    if DoesEntityExist(vehicle) then
        for Condition, Value in pairs(vehicleCondition) do
            --print(Condition, Value)
            if Condition == 'engineHealth' then
                SetVehicleEngineHealth(vehicle, Value)
            end
            if Condition == 'bodyHealth' then
                SetVehicleBodyHealth(vehicle, Value)
            end
            if Condition == 'tankHealth' then
                SetVehiclePetrolTankHealth(vehicle, Value)
            end
            if Condition == 'fuelLevel' then
                SetVehicleFuelLevel(vehicle, Value)
            end
            if Condition == 'oilLevel' then
                SetVehicleOilLevel(vehicle, Value)
            end
            if Condition == 'dirtLevel' then
                SetVehicleDirtLevel(vehicle, Value)
            end
            if Condition == 'tireHealth' then
                for wheelIndex, health in pairs(Value) do
                    SetVehicleWheelHealth(vehicle, wheelIndex, health)
                end
            end
            if Condition == 'tireBurstState' then
                for wheelIndex, burstState in pairs(Value) do
                    if burstState then 
                        SetVehicleTyreBurst(vehicle, tonumber(wheelIndex), false, 1000.0)
                    end
                end
            end
            if Condition == 'tireBurstCompletely' then
                for wheelIndex, burstState in pairs(Value) do
                    if burstState then 
                        SetVehicleTyreBurst(vehicle, tonumber(wheelIndex), true, 1000.0)
                    end
                end
            end 
        end
    end
end
exports('setVehicleCondition', setVehicleCondition)

function setVehicleProperties(vehicle, plate, vehicleProperties) -- make async export 
    if DoesEntityExist(vehicle) then
        SetVehicleNumberPlateText(vehicle, plate)

        for Property, Value in pairs(vehicleProperties) do
            if Property == 'Extras' then
                for extraId, disable in pairs(Value) do
                    if disable == 1 then
                        SetVehicleExtra(vehicle, extraId, 0)
                    else
                        SetVehicleExtra(vehicle, extraId, 1)
                    end
                end
            end
            if Property == 'Neons' then
                for neonIndex, toggle in pairs(Value) do
                    SetVehicleNeonLightEnabled(vehicle, tonumber(neonIndex), toggle)
                end
            end
            if Property == 'neonColor' then
                for k, Value in pairs(Value) do
                    if k == 'r' then
                        r = Value
                    end
                    if k == 'g' then
                        g = Value
                    end
                    if k == 'b' then
                        b = Value
                    end
                    SetVehicleNeonLightsColour(vehicle, r, g, b)
                end
            end
            if Property == 'smokeColor' then
                for k, Value in pairs(Value) do
                    if k == 'r' then
                        r = Value
                    end
                    if k == 'g' then
                        g = Value
                    end
                    if k == 'b' then
                        b = Value
                    end
                    SetVehicleTyreSmokeColor(vehicle, r, g, b)
                end
            end
            if Property == 'vehicleColor' then
                for k, Value in pairs(Value) do
                    if k == 'primary' then
                        colorPrimary = Value
                    end
                    if k == 'secondary' then
                        colorSecondary = Value
                    end
                    SetVehicleColours(vehicle, colorPrimary, colorSecondary)
                end
            end
            if Property == 'extraColor' then
                for extraColor, Value in pairs(Value) do
                    if k == 'pearlescentColor' then
                        pearlescentColor = Value
                    end
                    if k == 'wheelColor' then
                        wheelColor = Value
                    end
                    SetVehicleExtraColours(vehicle, pearlescentColor, wheelColor)
                end
            end
            if Property == 'plateIndex' then
                SetVehicleNumberPlateTextIndex(vehicle, Value)
            end
            if Property == 'headlightColor' then
                SetVehicleHeadlightsColour(vehicle, Value)
            end
            if Property == 'interiorColor' then
                SetVehicleInteriorColour(vehicle, Value)
            end
            if Property == 'dashboardColor' then
                SetVehicleDashboardColour(vehicle, Value)
            end
            if Property == 'wheelSize' then
                SetVehicleWheelSize(vehicle, Value)
            end
            if Property == 'wheelWidth' then
                SetVehicleWheelWidth(vehicle, Value)
            end
            if Property == 'windowTint' then
                SetVehicleWindowTint(vehicle, Value)
            end
        end
    end
end
exports('setVehicleProperties', setVehicleProperties)

function setVehicleMods(vehicle, vehicleMods)
    if DoesEntityExist(vehicle) then

        for modType, modIndex in pairs(vehicleMods) do
            SetVehicleModKit(vehicle, 0)
            if modType == 'Spoiler' then SetVehicleMod(vehicle, 0, modIndex, false) end
            if modType == 'frontBumper' then SetVehicleMod(vehicle, 1, modIndex, false) end
            if modType == 'rearBumper' then SetVehicleMod(vehicle, 2, modIndex, false) end
            if modType == 'sideSkirt' then SetVehicleMod(vehicle, 3, modIndex, false) end
            if modType == 'Exhaust' then SetVehicleMod(vehicle, 4, modIndex, false) end
            if modType == 'Frame' then SetVehicleMod(vehicle, 5, modIndex, false) end
            if modType == 'Grille' then SetVehicleMod(vehicle, 6, modIndex, false) end
            if modType == 'Hood' then SetVehicleMod(vehicle, 7, modIndex, false) end
            if modType == 'Fender' then SetVehicleMod(vehicle, 8, modIndex, false) end
            if modType == 'rightFender' then SetVehicleMod(vehicle, 9, modIndex, false) end
            if modType == 'Roof' then SetVehicleMod(vehicle, 10, modIndex, false) end
            if modType == 'Engine' then SetVehicleMod(vehicle, 11, modIndex, false) end
            if modType == 'Brakes' then SetVehicleMod(vehicle, 12, modIndex, false) end
            if modType == 'Transmission' then SetVehicleMod(vehicle, 13, modIndex, false) end
            if modType == 'Horns' then SetVehicleMod(vehicle, 14, modIndex, false) end
            if modType == 'Suspension' then SetVehicleMod(vehicle, 15, modIndex, false) end
            if modType == 'Armor' then SetVehicleMod(vehicle, 16, modIndex, false) end
            --if modType == 'ModKit17' then SetVehicleMod(vehicle, 17, modIndex, false) end
            if modType == 'turboPurchased' then ToggleVehicleMod(vehicle, 18, modIndex) end
            --if modType == 'modKit19' then SetVehicleMod(vehicle, 19, modIndex, false) end
            if modType == 'smokePurchased' then ToggleVehicleMod(vehicle, 20, modIndex) end
            --if modType == 'modKit21' then SetVehicleMod(vehicle, 21, modIndex, false) end
            if modType == 'xenonEnabled' then ToggleVehicleMod(vehicle, 22, modIndex) end
            if modType == 'frontWheels' then SetVehicleMod(vehicle, 23, modIndex, false) end
            if modType == 'backWheels' then SetVehicleMod(vehicle, 24, modIndex, false) end
            if modType == 'plateHolder' then SetVehicleMod(vehicle, 25, modIndex, false) end
            if modType == 'VanityPlate' then SetVehicleMod(vehicle, 26, modIndex, false) end
            if modType == 'TrimA' then SetVehicleMod(vehicle, 27, modIndex, false) end
            if modType == 'Ornaments' then SetVehicleMod(vehicle, 28, modIndex, false) end
            if modType == 'Dashboard' then SetVehicleMod(vehicle, 29, modIndex, false) end
            if modType == 'Dial' then SetVehicleMod(vehicle, 30, modIndex, false) end
            if modType == 'doorSpeaker' then SetVehicleMod(vehicle, 31, modIndex, false) end
            if modType == 'Seats' then SetVehicleMod(vehicle, 32, modIndex, false) end
            if modType == 'steeringWheel' then SetVehicleMod(vehicle, 33, modIndex, false) end
            if modType == 'shifterLeavers' then SetVehicleMod(vehicle, 34, modIndex, false) end
            if modType == 'Plaques' then SetVehicleMod(vehicle, 35, modIndex, false) end
            if modType == 'Speakers' then SetVehicleMod(vehicle, 36, modIndex, false) end
            if modType == 'Trunk' then SetVehicleMod(vehicle, 37, modIndex, false) end
            if modType == 'Hydrolic' then SetVehicleMod(vehicle, 38, modIndex, false) end
            if modType == 'engineBlock' then SetVehicleMod(vehicle, 39, modIndex, false) end
            if modType == 'airFilter' then SetVehicleMod(vehicle, 40, modIndex, false) end
            if modType == 'Struts' then SetVehicleMod(vehicle, 41, modIndex, false) end
            if modType == 'archCover' then SetVehicleMod(vehicle, 42, modIndex, false) end
            if modType == 'Aerials' then SetVehicleMod(vehicle, 43, modIndex, false) end
            if modType == 'TrimB' then SetVehicleMod(vehicle, 44, modIndex, false) end
            if modType == 'Tank' then SetVehicleMod(vehicle, 45, modIndex, false) end
            if modType == 'Windows' then SetVehicleMod(vehicle, 46, modIndex, false) end
            --if modType == 'modKit47' then SetVehicleMod(vehicle, 47, modIndex, false) end
            if modType == 'Livery' then SetVehicleMod(vehicle, 48, modIndex, false) SetVehicleLivery(vehicle, modIndex) end
            --if modType == 'modKit49' then SetVehicleMod(vehicle, 49, modIndex, false) end
            if modType == 'liveryRoof' then
                SetVehicleRoofLivery(vehicle, modIndex)
            end
        end
    end
end
exports('setVehicleMods', setVehicleMods)