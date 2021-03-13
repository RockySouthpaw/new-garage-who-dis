-- Variables
local activeNotification = false
local Delay = 500
-- Function (Notification)
function notifyPrompt(garage, id)
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
                    message = "Press **["..Config.interactionKey.."]** To Park Vehicle",
                    position = Config.tLocation
                    
                }
            })
        end
        if Config.mythicNotify then
            text = "Press ["..Config.interactionKey.."] To Park Vehicle"
            exports['mythic_notify']:PersistentAlert('start',id,'inform', text, { ['background-color'] = Config.backgroundColor })
        end
        if Config.pNotify then
            exports.pNotify:SetQueueMax(id, 1)
            exports.pNotify:SendNotification({
                text = "Press ["..Config.interactionKey.."] To Park Vehicle",
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

function notifySuccess(length)
    notifyEnd("garageNotify")
    Wait(150) -- Ensurs all notifications are removed in time before creating new ones.
    if Config.tNotify then 
        exports['t-notify']:Alert({
            style  =  'success',
            message  =  '✔️ Vehicle Stored Successfully.',
            length = length
        })
    end
    if Config.mythicNotify then
        exports['mythic_notify']:SendAlert('success', "✔️ Vehicle Stored Successfully.", length)
    end
    if Config.pNotify then
        exports.pNotify:SetQueueMax(id, 1)
        exports.pNotify:SendNotification({
            text = "✔️ Vehicle Stored Successfully.",
            type = "success",
            timeout = 1000 * Config.Duration,
            layout = Config.Layout,
            theme = Config.Theme,
            queue = "id"
        })
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

function storeVehicle(vehicle)
    if not inProgress then -- Checks if its already storing a vehicle to prevent key spam.
        inProgress = true
        local vehicleProperties = getVehicleProperties(vehicle)
        local vehicleCondition = getVehicleCondition(vehicle)
        local vehicleMods = getVehicleModkits(vehicle)
        TriggerServerEvent('NGWD:storeVehicle', vehicle, vehicleProperties, vehicleCondition, vehicleMods)
        deleteVehicle(vehicle) -- May trigger server side
        notifySuccess(1000 * Config.successLength) -- May trigger server side
        Wait(1000) -- May trigger server side
        inProgress = false
    end
end

function getVehicleProperties(vehicle)
    local vehicleProperties = 
    {
        {plate = GetVehicleNumberPlateText(vehicle)},
        {class = GetVehicleClass(vehicle)},
        {lightsState = GetVehicleLightsState(vehicle)},
        {colorPrimary, ColorSecondary = GetVehicleColours(vehicle)}, -- Use with SetVehicleColours
        {tyreSmoke = GetVehicleTyreSmokeColor(vehicle)},
        {headlightColor = GetVehicleHeadlightsColour(vehicle)},
        {interiorColor = GetVehicleInteriorColour(vehicle)},
        {dashboardColor = GetVehicleDashboardColour(vehicle)},
        {pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)},
        {livery = GetVehicleLivery(vehicle)},
        {liveryRoof = GetVehicleRoofLivery(vehicle)},
        {vehicleMods = GetNumVehicleMods(vehicle, 48)},
        {wheelSize = GetVehicleWheelSize(vehicle)},
        {wheelWidth = GetVehicleWheelWidth(vehicle)},
        {wheelType = GetVehicleWheelType(vehicle)},
        {windowTint = GetVehicleWindowTint(vehicle)}
    }
    return vehicleProperties
end

function getVehicleModkits(vehicle) -- Needs testing
    local vehicleMods = {}
    for i = 0,49 + 1 do
        vehicleMods[i] = GetVehicleMod(vehicle, i)
    end
    return vehicleMods
end

function getVehicleCondition(vehicle)
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
end

function deleteVehicle(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
    Wait(1500)
    DeleteVehicle(vehicle)
end