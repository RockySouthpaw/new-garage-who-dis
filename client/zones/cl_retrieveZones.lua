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

            if blipDistance <= Config.polyBlipRange then
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

-- Garage 1 (Legion)
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

-- Garage 2 (Pink Cage)
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

-- Garage 3 (Mirror Park)
local retrieveMirrorPark = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveMirrorPark",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveMirrorPark:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Mirror Park"
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

-- Garage 4 (Pillbox Hill)
local retrievePillboxHill = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrievePillboxHill",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrievePillboxHill:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Pillbox Hill"
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

-- Garage 5 (Mission Row)
local retrieveMissionRow_1A = PolyZone:Create({
  vector2(430.81958007813, -978.23529052734),
  vector2(440.17370605469, -978.34918212891),
  vector2(440.18566894531, -973.60400390625),
  vector2(430.88815307617, -973.71490478516)
}, {
  name="retrieveMissionRow_1A",
  minZ = 25.699966430664,
  maxZ = 28.699991226196
})

local retrieveMissionRow_1B = PolyZone:Create({
  vector2(445.49438476563, -973.66314697266),
  vector2(454.85049438477, -973.65393066406),
  vector2(454.90621948242, -978.29162597656),
  vector2(445.43908691406, -978.16223144531)
}, {
  name="retrieveMissionRow_1B",
  minZ = 25.699966430664,
  maxZ = 28.699991226196
})

local retrieveMissionRow_1C = PolyZone:Create({
  vector2(456.52249145508, -987.78070068359),
  vector2(456.48892211914, -997.32092285156),
  vector2(461.12734985352, -997.23706054688),
  vector2(461.08880615234, -987.77709960938)
}, {
  name="retrieveMissionRow_1C",
  minZ = 25.699966430664,
  maxZ = 28.699991226196
})

local combo = ComboZone:Create({retrieveMissionRow_1A, retrieveMissionRow_1B, retrieveMissionRow_1C}, {name= "Mission Row", debugPoly= false})
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Mission Row"
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

-- Garage 6 (Alta Street)
local retrieveAltaStreet_1A = PolyZone:Create({
  vector2(-279.69049072266, -887.41003417969),
  vector2(-281.55639648438, -886.72576904297),
  vector2(-282.64505004883, -889.63385009766),
  vector2(-280.79846191406, -890.31341552734)
}, {
  name="AltaStreet_1A",
  minZ = 30.348017959595,
  maxZ = 33.0
})

local retrieveAltaStreet_1B = PolyZone:Create({
  vector2(-349.94998168945, -875.95104980469),
  vector2(-347.96942138672, -875.94140625),
  vector2(-347.99819946289, -872.88653564453),
  vector2(-349.96981811523, -872.86419677734)
}, {
  name="retrieveAltaStreet_1B",
  minZ = 30.348017959595,
  maxZ = 33.0
})

local combo = ComboZone:Create({retrieveAltaStreet_1A, retrieveAltaStreet_1B}, {name= "Alta Street", debugPoly= false})
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Alta Street"
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

-- Garage 7 (Speedophile)
local retrieveSpeedophile = PolyZone:Create({
  vector2(452.3151550293, -1144.8455810547),
  vector2(452.33895874023, -1147.8884277344),
  vector2(454.29159545898, -1147.8928222656),
  vector2(454.25610351562, -1144.8203125)
}, {
  name="retrieveSpeedophile",
  minZ = 28.544129638672,
  maxZ = 31.0,
  lazyGrid= true,
  debugPoly= false
})

retrieveSpeedophile:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Speedophile"
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

-- Garage 8 (East Vinewood)
local retrieveEastVinewood = PolyZone:Create({
  vector2(985.39465332031, -205.59992980957),
  vector2(983.70544433594, -204.62825012207),
  vector2(982.16076660156, -207.3053894043),
  vector2(983.87054443359, -208.2678527832)
}, {
  name="retrieveEastVinewood",
  minZ = 70.09,
  maxZ = 73.00,
  lazyGrid= true,
  debugPoly= false
})

retrieveEastVinewood:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "East Vinewood"
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

-- Garage 9
local retrieveUnderground = PolyZone:Create({
  vector2(168.24911499023, -729.39636230469),
  vector2(171.10313415527, -730.43572998047),
  vector2(171.77505493164, -728.61193847656),
  vector2(168.90367126465, -727.56109619141)
}, {
  name="retrieveUnderground",
  minZ = 32.162690429688,
  maxZ = 35.00,
  lazyGrid= true,
  debugPoly= false
})

retrieveUnderground:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Underground"
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

-- Garage 10
local retrieveDavis = PolyZone:Create({
  vector2(-67.607772827148, -1840.0817871094),
  vector2(-66.096221923828, -1841.3348388672),
  vector2(-64.104537963867, -1838.9539794922),
  vector2(-65.615837097168, -1837.7052001953)
}, {
  name="retrieveDavis",
  minZ = 26.058434753418,
  maxZ = 28.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveDavis:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Davis"
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

-- Garage 11
local retrieveBanning = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveBanning",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveBanning:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Banning"
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

-- Garage 12
local retrievePlaceHolder1 = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrievePlaceHolder1",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrievePlaceHolder1:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "PlaceHolder1"
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

-- Garage 13
local retrieveVespuciBeach = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveVespuciBeach",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveVespuciBeach:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Vespuci Beach"
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

-- Garage 14
local retrieveDelPerro = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveDelPerro",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveDelPerro:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "DelPerro"
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

-- Garage 15
local retrieveWestVinewood = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveWestVinewood",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveWestVinewood:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "West Vinewood"
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

-- Garage 16
local retrieveLastTrainDiner = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveLastTrainDiner",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveLastTrainDiner:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Last Train Diner"
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

-- Garage 17
local retrieveSuperMarket = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveSuperMarket",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveSuperMarket:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "SuperMarket"
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

-- Garage 18
local retrieveDowntownVinewood = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveDowntownVinewood",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveDowntownVinewood:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Downtown Vinewood"
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

-- Garage 19
local retrieveUnionDepository = PolyZone:Create({
  vector2(1036.0249023438, -761.74932861328),
  vector2(1034.5002441406, -764.32208251953),
  vector2(1036.2073974609, -765.41540527344),
  vector2(1037.7620849609, -762.74090576172)
}, {
  name="retrieveUnionDepository",
  minZ = 57.023011474609,
  maxZ = 59.80,
  lazyGrid= true,
  debugPoly= false
})

retrieveUnionDepository:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if not IsPedInVehicle(PlayerPedId(), vehicle, true) then
            if not retrieveNotification then
                local garageName = "Union Depository"
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