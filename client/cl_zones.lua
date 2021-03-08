-- Varibles
local insideZone = false

-- Garage [1] = {name = "Legion", x = 217.58685302734, y = -802.31695556641, z = 30.768518447876},


local Garage_1A = PolyZone:Create({
    vector2(208.25799560547, -803.65850830078),
    vector2(201.4606628418, -801.01647949219),
    vector2(215.68438720703, -762.27612304688),
    vector2(222.79739379883, -764.90533447266)
}, {
    name="Garage_1A",
    minZ = 29.847998886108, 
    maxZ = 37.00
})

local Garage_1B = PolyZone:Create({
    vector2(226.46412658691, -766.22308349609),
    vector2(237.58192443848, -770.56103515625),
    vector2(222.04275512695, -812.39898681641),
    vector2(216.34619140625, -809.77459716797),
    vector2(217.46658325195, -806.91217041016),
    vector2(211.80502319336, -804.81848144531)
}, {
    name="Garage_1B",
    minZ = 29.847998886108, 
    maxZ = 37.00
})

local Garage_1C = PolyZone:Create({
    vector2(243.06700134277, -769.46166992188), 
    vector2(254.53912353516,-773.87664794922),
    vector2(239.10824584961, -815.51531982422),
    vector2(227.62350463867, -810.98028564453)
}, {
    name="Garage_1C",
    minZ = 28.847998886108, 
    maxZ = 37.00
})

local Garage_1D = PolyZone:Create({
    vector2(246.6290435791, -755.49499511719),
    vector2(244.75155639648, -760.63677978516),
    vector2(265.17779541016, -767.73883056641),
    vector2(267.05310058594, -762.64489746094)
}, {
    name="Garage_1D",
    minZ = 28.847998886108, 
    maxZ = 33.0
})

local Garage_1E = PolyZone:Create({
    vector2(270.34609985352, -754.02410888672),
    vector2(272.36087036133, -748.50231933594),
    vector2(244.01419067383, -738.75921630859),
    vector2(242.0460357666, -744.01489257813)
}, {
    name="Garage_1E",
    minZ = 28.847998886108, 
    maxZ = 33.0
})

local Garage_1F = PolyZone:Create({
    vector2(233.21166992188, -734.90228271484),
    vector2(230.71333312988, -742.39422607422),
    vector2(254.41944885254, -750.44427490234),
    vector2(257.07949829102, -742.81756591797)
}, {
    name="Garage_1F",
    minZ = 33.666985778809,
    maxZ = 42.00
})

local Garage_1G = PolyZone:Create({
    vector2(218.77407836914, -753.66693115234),
    vector2(221.3143157959, -746.35003662109),
    vector2(231.20329284668, -749.78356933594),
    vector2(228.67904663086, -757.08813476563)
}, {
    name="Garage_1G",
    minZ = 33.666985778809,
    maxZ = 42.00
})

local Garage_1H = PolyZone:Create({
    vector2(238.43449401855, -760.42114257813),
    vector2(240.53157043457, -753.2783203125),
    vector2(260.54592895508, -759.88220214844),
    vector2(261.98657226563, -755.90228271484),
    vector2(268.89007568359, -758.30786132813),
    vector2(264.80746459961, -769.45831298828)
}, {
    name="Garage_1H",
    minZ = 33.666985778809,
    maxZ = 42.00
})
  
local combo = ComboZone:Create({Garage_1A, Garage_1B, Garage_1C, Garage_1D, Garage_1E, Garage_1F, Garage_1G, Garage_1H}, {name="Garage 1", debugPoly=true})
combo:onPlayerInOut(function(isPointInside, point, zone)
  if isPointInside then
    print("Inside Zone:",isPointInside,"for point", point)
  else
    print("Outside Zone:",isPointInside,"for point", point)
  end
end)

-- Garage [2] = {name = "Pink Cage", x = 273.77542114258, y = -344.17346191406, z = 44.919834136963}, )

local Garage_2A = PolyZone:Create({
    vector2(304.40,-329.20),
    vector2(297.80,-326.75),
    vector2(288.80,-352.25),
    vector2(294.40,-354.25)
}, {
    name="Garage_2A",
    minZ = 43.949876098633,
    maxZ = 51.0
})

local Garage_2B = PolyZone:Create({
    vector2(285.54678344727, -345.45797729492),
    vector2(292.96420288086, -325.26528930664),
    vector2(280.58578491211, -320.74761962891),
    vector2(273.35720825195, -340.91400146484)
}, {
    name="Garage_2B",
    minZ = 43.949876098633,
    maxZ = 51.00
})

local Garage_2C = PolyZone:Create({
    vector2(275.20812988281, -318.60675048828),
    vector2(267.9128112793, -315.92877197266),
    vector2(260.90295410156, -335.05895996094),
    vector2(268.44351196289, -337.54788208008)
}, {
    name="Garage_2C",
    minZ = 43.949876098633,
    maxZ = 51.00
})

local combo = ComboZone:Create({Garage_2A, Garage_2B, Garage_2C}, {name="Garage 2", debugPoly=true})
combo:onPlayerInOut(function(isPointInside, point, zone)
  if isPointInside then
    print("Inside Zone:",isPointInside,"for point", point)
  else
    print("Outside Zone:",isPointInside,"for point", point)
  end
end)