polyZones = {}
polyZones.RetrieveZones = {
    {name = 'Legion', coords = {vector2(215.29, -807.74),vector2(213.48, -807.0),vector2(212.36, -809.87),vector2(214.19, -810.56)}, minZ = 30.04, maxZ = 32.8},
    {name = 'PinkCage', coords = {vector2(275.82, -346.96),vector2(276.87, -344.07),vector2(275.03, -343.41),vector2(274.00, -346.30)}, minZ = 44.20, maxZ = 47.0},
    {name = 'Mirror Park', coords = {vector2(1036.02, -761.74),vector2(1034.50, -764.32),vector2(1036.20, -765.41),vector2(1037.76, -762.74)}, minZ = 57.02, maxZ = 59.80},
    {name = 'Mission Row', coords = {vector2(423.20, -1010.27),vector2(426.62, -1010.27),vector2(426.60, -1016.86),vector2(422.82, -1016.88)}, minZ = 28.11, maxZ = 31.0},
    {name = 'Speedophile', coords = {vector2(452.313, -1144.84),vector2(452.33, -1147.88),vector2(454.29, -1147.89),vector2(454.25, -1144.82)}, minZ = 28.54, maxZ = 31.0},
    {name = 'East Vinewood', coords = {vector2(985.39, -205.59),vector2(983.70, -204.62),vector2(982.16, -207.30),vector2(983.87, -208.26)}, minZ = 70.09, maxZ = 73.00},
    -- Below are placeholder coords
    {name = 'Banning', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'PlaceHolder1', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'Vespuci Beach', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'DelPerro', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'West Vinewood', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'Last Train Diner', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'Super Market', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'Downtown Vinewood', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
    {name = 'Union Depository', coords = {vector2(0,0),vector2(0,0),vector2(0,0)}, minZ = 0.0, maxZ = 0.0},
}

comboZones = {}
comboZones.RetrieveZones = {
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(42.81, -843.56),vector2(44.63, -844.22),vector2(45.68, -841.39),vector2(43.85, -840.77)}, {minZ = 30, maxZ = 33.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(56.86, -877.79),vector2(57.56, -875.96),vector2(54.69, -874.93),vector2(54.02, -876.76)}, {minZ = 29.50, maxZ = 32.0})},
    {name = 'AltaStreet', coords = PolyZone:Create({vector2(-279.69, -887.41),vector2(-281.55, -886.72),vector2(-282.64, -889.63),vector2(-280.79, -890.31)}, {minZ = 30.34, maxZ = 33.0})},
    {name = 'AltaStreet', coords = PolyZone:Create({vector2(-349.94, -875.95),vector2(-347.96, -875.94),vector2(-347.99, -872.88),vector2(-349.96, -872.86)}, {minZ = 30.34, maxZ = 33.0})},
}
comboZones.StoreZones = {
    {name = 'Legion', coords = PolyZone:Create({vector2(208.25, -803.65),vector2(201.46, -801.01),vector2(215.68, -762.27),vector2(222.79, -764.90)}, {minZ = 29.84, maxZ = 37.00})},
    {name = 'Legion', coords = PolyZone:Create({vector2(226.46, -766.22),vector2(237.58, -770.56),vector2(222.04, -812.39),vector2(216.34, -809.77),vector2(217.46, -806.91),vector2(211.80, -804.81)}, {minZ = 29.84, maxZ = 37.00})},
    {name = 'Legion', coords = PolyZone:Create({vector2(243.067, -769.46),vector2(254.53,-773.87),vector2(239.10, -815.51),vector2(227.62, -810.98)}, {minZ = 29.84, maxZ = 37.00})},
    {name = 'Legion', coords = PolyZone:Create({vector2(246.621, -755.49),vector2(244.75, -760.63),vector2(265.17, -767.73),vector2(267.05, -762.64)}, {minZ = 28.84, maxZ = 33.0})},
    {name = 'Legion', coords = PolyZone:Create({vector2(270.34, -754.02),vector2(272.36, -748.50),vector2(244.01, -738.75),vector2(242.04, -744.014)}, {minZ = 28.84, maxZ = 33.0})},
    {name = 'Legion', coords = PolyZone:Create({vector2(233.21, -734.90),vector2(230.71, -742.39),vector2(254.41, -750.44),vector2(257.07, -742.81)}, {minZ = 33.66, maxZ = 42.00})},
    {name = 'Legion', coords = PolyZone:Create({vector2(218.77, -753.66),vector2(221.31, -746.35),vector2(231.20, -749.78),vector2(228.67, -757.08)}, {minZ = 33.66, maxZ = 42.00})},
    {name = 'Legion', coords = PolyZone:Create({vector2(238.43, -760.42),vector2(240.53, -753.27),vector2(260.54, -759.88),vector2(261.98, -755.90),vector2(268.89, -758.30),vector2(264.801, -769.45)}, {minZ = 33.66, maxZ = 42.00})},
    {name = 'Pink Cage', coords = PolyZone:Create({vector2(304.40,-329.20),vector2(297.80,-326.75),vector2(288.80,-352.25),vector2(294.40,-354.25)}, {minZ = 43.94, maxZ = 51.0})},
    {name = 'Pink Cage', coords = PolyZone:Create({vector2(285.54, -345.45),vector2(292.96, -325.26),vector2(280.58, -320.74),vector2(273.35, -340.91)}, {minZ = 43.94, maxZ = 51.0})},
    {name = 'Pink Cage', coords = PolyZone:Create({vector2(275.20, -318.60),vector2(267.91, -315.92),vector2(260.90, -335.05),vector2(268.44, -337.54)}, {minZ = 43.94, maxZ = 51.0})},
    {name = 'Mirror Park', coords = PolyZone:Create({vector2(1026.16, -755.64),vector2(1022.37, -751.93),vector2(1011.09, -761.84),vector2(1014.77, -766.05)}, {minZ = 56.89, maxZ = 64.01})},
    {name = 'Mirror Park', coords = PolyZone:Create({vector2(1016.62, -767.57),vector2(1012.32, -770.99),vector2(1029.11, -791.78),vector2(1033.49, -788.13)}, {minZ = 56.89, maxZ = 64.01})},
    {name = 'Mirror Park', coords = PolyZone:Create({vector2(1043.89, -788.32),vector2(1043.93, -794.59),vector2(1035.64, -794.72),vector2(1035.61, -788.53)}, {minZ = 56.89, maxZ = 64.01})},
    {name = 'Mirror Park', coords = PolyZone:Create({vector2(1043.78, -787.76),vector2(1049.77, -787.66),vector2(1049.85, -772.39),vector2(1043.50, -772.48)}, {minZ = 56.89, maxZ = 64.01})},
    {name = 'Mirror Park', coords = PolyZone:Create({vector2(1031.09, -776.68),vector2(1034.60, -772.17),vector2(1028.03, -767.33),vector2(1024.55, -772.09)}, {minZ = 56.89, maxZ = 64.01})},
    {name = 'Mirror Park', coords = PolyZone:Create({vector2(1025.88, -763.84),vector2(1030.93, -767.32),vector2(1033.17, -764.11),vector2(1028.26, -760.72)}, {minZ = 56.89, maxZ = 64.01})},
    {name = 'Mirror Park', coords = PolyZone:Create({vector2(1025.88, -763.84),vector2(1030.93, -767.32),vector2(1033.17, -764.11),vector2(1028.26, -760.72)}, {minZ = 56.89, maxZ = 64.01})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(53.46, -843.26),vector2(65.85, -847.89),vector2(63.84, -853.22),vector2(51.29, -849.01)}, {minZ = 29.19, maxZ = 35.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(31.48, -841.16),vector2(33.33, -835.93),vector2(43.38, -839.57),vector2(41.61, -844.84)}, {minZ = 29.19, maxZ = 35.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(63.05, -864.78),vector2(61.30, -869.79),vector2(44.402, -863.56),vector2(46.32, -858.39)}, {minZ = 29.19, maxZ = 35.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(38.15, -855.50),vector2(36.12, -860.87),vector2(25.59, -856.97),vector2(27.62, -851.75)}, {minZ = 29.19, maxZ = 35.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(22.46, -865.71),vector2(24.27, -860.67),vector2(34.51, -864.42),vector2(32.70, -869.49)}, {minZ = 29.19, maxZ = 35.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(43.18, -867.38),vector2(53.46, -871.28),vector2(51.65, -876.252),vector2(41.30, -872.51)}, {minZ = 29.19, maxZ = 35.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(38.35, -880.29),vector2(55.38, -886.13),vector2(52.07, -895.15),vector2(35.23, -889.18)}, {minZ = 29.19, maxZ = 35.0})},
    {name = 'Pillbox Hill', coords = PolyZone:Create({vector2(26.87, -885.96),vector2(30.17, -876.88),vector2(19.78, -873.25),vector2(16.57, -882.13)}, {minZ = 29.19, maxZ = 35.0})},
}

-- Cords for gabz PD to be added back later
--[[
    {name = 'Mission Row', coords = PolyZone:Create({vector2(430.81958007813, -978.23529052734),vector2(440.17370605469, -978.34918212891),vector2(440.18566894531, -973.60400390625),vector2(430.88815307617, -973.71490478516)},
    {minZ = 25.699966430664,
    maxZ = 28.699991226196}

    {name = 'Mission Row', coords = PolyZone:Create({vector2(445.49438476563, -973.66314697266),vector2(454.85049438477, -973.65393066406),vector2(454.90621948242, -978.29162597656),vector2(445.43908691406, -978.16223144531)},
    {minZ = 25.699966430664,
    maxZ = 28.699991226196}

    {name = 'Mission Row', coords = PolyZone:Create({vector2(456.52249145508, -987.78070068359),vector2(456.48892211914, -997.32092285156),vector2(461.12734985352, -997.23706054688),vector2(461.08880615234, -987.77709960938)},
    {minZ = 25.699966430664,
    maxZ = 28.699991226196}
]]