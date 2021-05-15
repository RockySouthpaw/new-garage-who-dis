-- Varibles
local activeNotification = false -- Becomes true when the player is in a zone.
local notificationID = "garageNotify" -- The unique ID for garage notifications.
local garageName

-- Keymappings
RegisterKeyMapping("Store", "Store Player Vehicle", 'keyboard', Config.storageKey)
RegisterKeyMapping("notiOff", "Clear Notification", 'keyboard', 'f')

-- Commands
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
                    Wait(1000) -- Waits before allowing this to be triggered again.
                    storing = false
                end
            end
        end
    end
end)

RegisterCommand("notiOff", function()
    if activeNotification then
        notifyEnd(notificationID)
        activeNotification = false
    end
end)

-- Store Zones
local Legion_1A = PolyZone:Create({
    vector2(208.25799560547, -803.65850830078),
    vector2(201.4606628418, -801.01647949219),
    vector2(215.68438720703, -762.27612304688),
    vector2(222.79739379883, -764.90533447266)
}, {
    name="Legion_1A",
    minZ = 29.847998886108, 
    maxZ = 37.00
})

local Legion_1B = PolyZone:Create({
    vector2(226.46412658691, -766.22308349609),
    vector2(237.58192443848, -770.56103515625),
    vector2(222.04275512695, -812.39898681641),
    vector2(216.34619140625, -809.77459716797),
    vector2(217.46658325195, -806.91217041016),
    vector2(211.80502319336, -804.81848144531)
}, {
    name="Legion_1B",
    minZ = 29.847998886108, 
    maxZ = 37.00
})

local Legion_1C = PolyZone:Create({
    vector2(243.06700134277, -769.46166992188), 
    vector2(254.53912353516,-773.87664794922),
    vector2(239.10824584961, -815.51531982422),
    vector2(227.62350463867, -810.98028564453)
}, {
    name="Legion_1C",
    minZ = 28.847998886108, 
    maxZ = 37.00
})

local Legion_1D = PolyZone:Create({
    vector2(246.6290435791, -755.49499511719),
    vector2(244.75155639648, -760.63677978516),
    vector2(265.17779541016, -767.73883056641),
    vector2(267.05310058594, -762.64489746094)
}, {
    name="Legion_1D",
    minZ = 28.847998886108, 
    maxZ = 33.0
})

local Legion_1E = PolyZone:Create({
    vector2(270.34609985352, -754.02410888672),
    vector2(272.36087036133, -748.50231933594),
    vector2(244.01419067383, -738.75921630859),
    vector2(242.0460357666, -744.01489257813)
}, {
    name="Legion_1E",
    minZ = 28.847998886108, 
    maxZ = 33.0
})

local Legion_1F = PolyZone:Create({
    vector2(233.21166992188, -734.90228271484),
    vector2(230.71333312988, -742.39422607422),
    vector2(254.41944885254, -750.44427490234),
    vector2(257.07949829102, -742.81756591797)
}, {
    name="Legion_1F",
    minZ = 33.666985778809,
    maxZ = 42.00
})

local Legion_1G = PolyZone:Create({
    vector2(218.77407836914, -753.66693115234),
    vector2(221.3143157959, -746.35003662109),
    vector2(231.20329284668, -749.78356933594),
    vector2(228.67904663086, -757.08813476563)
}, {
    name="Legion_1G",
    minZ = 33.666985778809,
    maxZ = 42.00
})

local Legion_1H = PolyZone:Create({
    vector2(238.43449401855, -760.42114257813),
    vector2(240.53157043457, -753.2783203125),
    vector2(260.54592895508, -759.88220214844),
    vector2(261.98657226563, -755.90228271484),
    vector2(268.89007568359, -758.30786132813),
    vector2(264.80746459961, -769.45831298828)
}, {
    name="Legion_1H",
    minZ = 33.666985778809,
    maxZ = 42.00
})
  
local combo = ComboZone:Create({Legion_1A, Legion_1B, Legion_1C, Legion_1D, Legion_1E, Legion_1F, Legion_1G, Legion_1H}, {name="Legion", debugPoly=false})
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInVehicle(PlayerPedId(), vehicle, true) and not activeNotification then
            local garageName = "Legion"
            notifyStorePrompt(garageName, notificationID)
            activeNotification = true
        end
    else
        if activeNotification then 
            notifyEnd(notificationID)
            activeNotification = false
        end
    end
end)

local PinkCage_2A = PolyZone:Create({
    vector2(304.40,-329.20),
    vector2(297.80,-326.75),
    vector2(288.80,-352.25),
    vector2(294.40,-354.25)
}, {
    name="PinkCage_2A",
    minZ = 43.949876098633,
    maxZ = 51.0
})

local PinkCage_2B = PolyZone:Create({
    vector2(285.54678344727, -345.45797729492),
    vector2(292.96420288086, -325.26528930664),
    vector2(280.58578491211, -320.74761962891),
    vector2(273.35720825195, -340.91400146484)
}, {
    name="PinkCage_2B",
    minZ = 43.949876098633,
    maxZ = 51.00
})

local PinkCage_2C = PolyZone:Create({
    vector2(275.20812988281, -318.60675048828),
    vector2(267.9128112793, -315.92877197266),
    vector2(260.90295410156, -335.05895996094),
    vector2(268.44351196289, -337.54788208008)
}, {
    name="PinkCage_2C",
    minZ = 43.949876098633,
    maxZ = 51.00
})

local combo = ComboZone:Create({PinkCage_2A, PinkCage_2B, PinkCage_2C}, {name="Pink Cage", debugPoly=false})
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInVehicle(PlayerPedId(), vehicle, true) and not activeNotification then
            local garageName = "Pink Cage"
            notifyStorePrompt(garageName, notificationID)
            activeNotification = true
        end
    else
        if activeNotification then 
            notifyEnd(notificationID)
            activeNotification = false
        end
    end
end)

local MirrorPark_3A = PolyZone:Create({
    vector2(1026.1635742188, -755.64068603516),
    vector2(1022.3745117188, -751.93786621094),
    vector2(1011.0908813477, -761.84887695312),
    vector2(1014.7746582031, -766.05047607422)
}, {
    name="MirrorPark_3A",
    minZ = 56.89493560791,
    maxZ = 64.010898590088
})

local MirrorPark_3B = PolyZone:Create({
    vector2(1016.6245117188, -767.57232666016),
    vector2(1012.3276977539, -770.99658203125),
    vector2(1029.1196289062, -791.78857421875),
    vector2(1033.498046875, -788.13354492188)
}, {
    name="MirrorPark_3B",
    minZ = 56.89493560791,
    maxZ = 64.010898590088
})

local MirrorPark_3C = PolyZone:Create({
    vector2(1043.8983154297, -788.32757568359),
    vector2(1043.9318847656, -794.59698486328),
    vector2(1035.6424560547, -794.72576904297),
    vector2(1035.6108398438, -788.53625488281)
}, {
    name="MirrorPark_3C",
    minZ = 56.89493560791,
    maxZ = 64.010898590088
})

local MirrorPark_3D = PolyZone:Create({
    vector2(1043.7899169922, -787.76214599609),
    vector2(1049.7750244141, -787.66522216797),
    vector2(1049.8513183594, -772.39605712891),
    vector2(1043.5042724609, -772.48425292969)
}, {
    name="MirrorPark_3D",
    minZ = 56.89493560791,
    maxZ = 64.010898590088
})

local MirrorPark_3E = PolyZone:Create({
  vector2(1031.0963134766, -776.68933105469),
  vector2(1034.60546875, -772.17150878906),
  vector2(1028.0316162109, -767.33837890625),
  vector2(1024.5526123047, -772.09527587891)
}, {
    name="MirrorPark_3E",
    minZ = 56.89493560791,
    maxZ = 64.010898590088
})

local MirrorPark_3F = PolyZone:Create({
  vector2(1025.8822021484, -763.8466796875),
  vector2(1030.9379882812, -767.32965087891),
  vector2(1033.1702880859, -764.11083984375),
  vector2(1028.2648925781, -760.72698974609)
}, {
    name="MirrorPark_3F",
    minZ = 56.89493560791,
    maxZ = 64.010898590088
})

local combo = ComboZone:Create({MirrorPark_3A, MirrorPark_3B, MirrorPark_3C, MirrorPark_3D, MirrorPark_3E, MirrorPark_3F}, {name="Mirror Park", debugPoly=false})
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInVehicle(PlayerPedId(), vehicle, true) and not activeNotification then
            local garageName = "Mirror Park"
            notifyStorePrompt(garageName, notificationID)
            activeNotification = true
        end
    else
        if activeNotification then 
            notifyEnd(notificationID)
            activeNotification = false
        end
    end
end)

local combo = ComboZone:Create({PinkCage_2A, PinkCage_2B, PinkCage_2C}, {name="Pink Cage", debugPoly=false})
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInVehicle(PlayerPedId(), vehicle, true) and not activeNotification then
            local garageName = "Pink Cage"
            notifyStorePrompt(garageName, notificationID)
            activeNotification = true
        end
    else
        if activeNotification then 
            notifyEnd(notificationID)
            activeNotification = false
        end
    end
end)

local PillboxHill_4A = PolyZone:Create({
    vector2(53.467384338379, -843.26733398438),
    vector2(65.854461669922, -847.89172363281),
    vector2(63.844863891602, -853.22985839844),
    vector2(51.296298980713, -849.01501464844)
}, {
    name="PillboxHill_4A",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local PillboxHill_4B = PolyZone:Create({
    vector2(31.484914779663, -841.16790771484),
    vector2(33.333824157715, -835.93426513672),
    vector2(43.38655090332, -839.57238769531),
    vector2(41.611515045166, -844.84643554688)
}, {
    name="PillboxHill_4B",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local PillboxHill_4C = PolyZone:Create({
    vector2(63.05704498291, -864.78692626953),
    vector2(61.306499481201, -869.79345703125),
    vector2(44.406902313232, -863.56854248047),
    vector2(46.324794769287, -858.39123535156)
}, {
    name="PillboxHill_4C",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local PillboxHill_4D = PolyZone:Create({
    vector2(38.158592224121, -855.50073242188),
    vector2(36.129657745361, -860.87603759766),
    vector2(25.597166061401, -856.97967529297),
    vector2(27.62721824646, -851.75415039062)
}, {
    name="PillboxHill_4D",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local PillboxHill_4E = PolyZone:Create({
  vector2(22.461700439453, -865.71166992188),
  vector2(24.274568557739, -860.67993164062),
  vector2(34.512107849121, -864.42529296875),
  vector2(32.704425811768, -869.49084472656)
}, {
    name="PillboxHill_4E",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local PillboxHill_4F = PolyZone:Create({
  vector2(43.185997009277, -867.38488769531),
  vector2(53.46354675293, -871.28082275391),
  vector2(51.65705871582, -876.25512695312),
  vector2(41.301704406738, -872.51385498047)
}, {
    name="PillboxHill_4F",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local PillboxHill_4G = PolyZone:Create({
  vector2(38.35803604126, -880.29174804688),
  vector2(55.383159637451, -886.13659667969),
  vector2(52.07666015625, -895.15252685547),
  vector2(35.235614776611, -889.18109130859)
}, {
    name="PillboxHill_4G",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local PillboxHill_4H = PolyZone:Create({
  vector2(26.87938117981, -885.966796875),
  vector2(30.170251846313, -876.88568115234),
  vector2(19.784814834595, -873.25531005859),
  vector2(16.573041915894, -882.13824462891)
}, {
    name="PillboxHill_4H",
    minZ = 29.194978027344,
    maxZ = 35.0
})

local combo = ComboZone:Create({PillboxHill_4A, PillboxHill_4B, PillboxHill_4C, PillboxHill_4D, PillboxHill_4E, PillboxHill_4F, PillboxHill_4G, PillboxHill_4H}, {name="Pillbox Hill", debugPoly=false})
combo:onPlayerInOut(function(isPointInside, point, zone)
    if isPointInside then
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if IsPedInVehicle(PlayerPedId(), vehicle, true) and not activeNotification then
            local garageName = "Pillbox Hill"
            notifyStorePrompt(garageName, notificationID)
            activeNotification = true
        end
    else
        if activeNotification then 
            notifyEnd(notificationID)
            activeNotification = false
        end
    end
end)
