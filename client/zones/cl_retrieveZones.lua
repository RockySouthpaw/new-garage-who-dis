-- Varibles
local retrieveNotification = false -- Becomes true when the player is in a zone.
local notificationID = "garageNotify" -- The unique ID for garage notifications.
local garageName

-- Keymappings
RegisterKeyMapping("Retrieve", "Retrieve Player Vehicle", 'keyboard', Config.retrieveKey)

-- Commands
RegisterCommand("Retrieve", function()
    if retrieveNotification then 
		local playerCoords = GetEntityCoords(PlayerPedId())

        for i = 1, #Config.blipLocations do
            local zone = Config.blipLocations[i]
            local blipDistance = #(playerCoords - zone.pos)

            if blipDistance <= Config.blipRange then
                if not retrieving then
                    retrieving = true
                    garageName = zone.name
                    TriggerEvent('NGWD:openMenu', garageName)
                    Wait(1000) -- Waits before allowing this to be triggered again.
                    retrieving = false
                end
            end
        end
    end
end)

-- Retrieve Zones
local retrievePinkCage = PolyZone:Create({
    vector2(275.82836914063, -346.96624755859),
    vector2(276.8737487793, -344.0768737793),
    vector2(275.0364074707, -343.41534423828),
    vector2(274.0022277832, -346.30093383789)
  }, {
    name= "retrievePinkCage",
    minZ = 44.203404693604,
    maxZ = 47.0,
    lazyGrid= true,
    debugPoly= false
})

retrievePinkCage:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Pink Cage"
                notifyRetrievePrompt(garageName, notificationID)
                retrieveNotification = true
            end
        end
    else
        if retrieveNotification then 
            notifyEnd(notificationID)
            retrieveNotification = false
        end
    end
end)


local retrieveLegion = PolyZone:Create({
    vector2(215.29823303223, -807.74694824219),
    vector2(213.48683166504, -807.02398681641),
    vector2(212.36161804199, -809.87066650391),
    vector2(214.19085693359, -810.56799316406)
}, {
    name="retrieveLegion",
    minZ = 30.044890670776, 
    maxZ = 32.8,
    lazyGrid= true,
    debugPoly= false
})

retrieveLegion:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Legion"
                notifyRetrievePrompt(garageName, notificationID)
                retrieveNotification = true
            end
        end
    else
        if retrieveNotification then 
            notifyEnd(notificationID)
            retrieveNotification = false
        end
    end
end)