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
    TriggerServerEvent('NGWD:storeVehicle', vehicle)
    deleteVehicle(vehicle)
    notifySuccess(1000 * Config.successLength)
end

function deleteVehicle(vehicle)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
    Wait(1500)
    DeleteVehicle(vehicle)
end