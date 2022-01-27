RetrieveNotification = false -- Becomes true when the player is in a zone.
NotificationId = "garageNotify" -- The unique ID for garage notifications.
local garageName
local keyDelay = 500

-- Keymappings
RegisterKeyMapping("Retrieve", "Retrieve Player Vehicle", 'keyboard', Config.retrieveKey)
RegisterKeyMapping("Store", "Store Player Vehicle", 'keyboard', Config.storageKey)
RegisterKeyMapping("notiOff", "Clear Notification", 'keyboard', 'f')

-- Commands
RegisterCommand("Retrieve", function()
    if RetrieveNotification then
		local playerCoords = GetEntityCoords(PlayerPedId())
        for i = 1, #Config.blipLocations do
            local zone = Config.blipLocations[i]
            local blipDistance = #(playerCoords - zone.pos)

            if blipDistance <= Config.polyBlipRange then
                if not retrieving then
                    retrieving = true
                    garageName = zone.name
                    TriggerServerEvent('NGWD:getOwnedVehicles', garageName)
                    Wait(keyDelay)
                    retrieving = false
                end
            end
        end
    end
end)

RegisterCommand("Store", function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local driver  = GetPedInVehicleSeat(vehicle, -1)
    if activeNotification and IsPedInVehicle(PlayerPedId(),vehicle, true) and driver == PlayerPedId() then
		local playerCoords = GetEntityCoords(PlayerPedId())

        for i = 1, #Config.blipLocations do
            local zone = Config.blipLocations[i]
            local blipDistance = #(playerCoords - zone.pos)

            if blipDistance <= Config.polyBlipRange then
                if not storing then
                    storing = true
                    garageName = zone.name
                    storeVehicle(vehicle, garageName)
                    Wait(keyDelay)
                    storing = false
                end
            end
        end
    end
end)

RegisterCommand("notiOff", function()
    if activeNotification then
        notifyEnd(NotificationId)
        activeNotification = false
    end
end)