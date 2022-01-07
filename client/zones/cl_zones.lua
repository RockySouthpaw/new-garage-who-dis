local retrievePolyZone
local retrieveComboZone
local storeComboZone
local useGrid   = true
local debugMode = false

-- Retrieve
for _,v in pairs(polyZones.RetrieveZones) do
    retrievePolyZone = PolyZone:Create(v.coords, {
        name        = v.name,
        minZ        = v.minZ,
        maxZ        = v.maxZ,
        lazyGrid    = useGrid,
        debugPoly   = debugMode
    })

    retrievePolyZone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
        if isPointInside then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
                if not RetrieveNotification then
                    local garageName = v.name
                    notifyRetrievePrompt(garageName, NotificationId)
                    RetrieveNotification = true
                end
            end
        else
            if RetrieveNotification then 
                notifyEnd(NotificationId)
                RetrieveNotification = false
            end
        end
    end)
end

for _,v in pairs(comboZones.RetrieveZones) do
    retrieveComboZone = ComboZone:Create({v.coords}, {
        name        = v.name,
        debugPoly   = debugMode
    })

    retrieveComboZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
                if not RetrieveNotification then
                    local garageName = v.name
                    notifyRetrievePrompt(garageName, NotificationId)
                    RetrieveNotification = true
                end
            end
        else
            if RetrieveNotification then 
                notifyEnd(NotificationId)
                RetrieveNotification = false
            end
        end
    end)
end

-- Store
for _,v in pairs(comboZones.StoreZones) do
    storeComboZone = ComboZone:Create({v.coords}, {
        name        = v.name,
        debugPoly   = debugMode
    })
    storeComboZone:onPlayerInOut(function(isPointInside, point, zone)
        if isPointInside then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if IsPedInVehicle(PlayerPedId(), vehicle, true) and not activeNotification then
                local garageName = v.name
                notifyStorePrompt(garageName, NotificationId)
                activeNotification = true
            end
        else
            if activeNotification then 
                notifyEnd(NotificationId)
                activeNotification = false
            end
        end
    end)
end