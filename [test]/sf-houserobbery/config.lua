Language = "en"

Config = {}

Config.Controls = {
	["use"] = {
		key = 38, -- its E on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
		disabled = false
	},
    ["lock"] = {
        key = 45, -- its R on keyboard, to change to diffrent key see https://docs.fivem.net/docs/game-references/controls/
		disabled = false
    }
}

Config.Peds = {
    { model = `s_m_y_dockwork_01`, scenario = "WORLD_HUMAN_AA_SMOKE", coords = vector4(-904.03, 147.31, 62.18, 57.27), event = "sf-houserobbery:getMission", locale = "get_mission" },
    { model = `s_m_m_trucker_01`, scenario = "WORLD_HUMAN_CLIPBOARD", coords = vector4(-1594.352051, 5193.021484, -10.310093, 204.140137), event = "sf-houserobbery:sellItems", locale = "sell_items" },
}

Config.StandaloneRange = 1.5
Config.InteractionRange = 2.0

Config.Interiors = {
    ["low"] = {
        entrance = {
            pedCoords = vector4(266.070251, -1007.575439, -102.008598, 3.167091),
            coords = vector4(266.07, -1007.78, -100.59, 0),
            length = 0.6,
            width = 1.4,
            minZ = -101.99,
            maxZ = -99.598
        },
        stashes = {
            {
                coords = vector4(266.42, -999.42, -99.01, 0),
                length = 1.6,
                width = 1.0,
                minZ = -100.01,
                maxZ = -98.81
            },
            {
                coords = vector4(266.16, -997.65, -99.01, 0),
                length = 0.8,
                width = 0.6,
                minZ = -100.01,
                maxZ = -98.01
            },
            {
                coords = vector4(262.51, -995.28, -99.01, 0),
                length = 1.2,
                width = 0.4,
                minZ = -100.01,
                maxZ = -98.01
            },
            {
                coords = vector4(259.77, -1004.72, -99.01, 0),
                length = 1.0,
                width = 1.6,
                minZ = -101.01,
                maxZ = -97.61
            },
            {
                coords = vector4(263.42, -1002.98, -99.01, 0),
                length = 0.8,
                width = 0.6,
                minZ = -100.01,
                maxZ = -99.21
            },
        },
        props = {
            {
                model = `prop_toaster_02`,
                coords = vec4(266.669983, -995.324402, -99.039040, 260.000061),
                itemName = "hr_toaster"
            },
            {
                model = `prop_micro_02`,
                coords = vec4(266.471985, -994.724182, -98.895477, 320.000031),
                itemName = "hr_microwave"
            },
            {
                model = `xm3_prop_xm3_boombox_01a`,
                coords = vec4(263.357117, -994.685059, -98.803261, 19.999975),
                itemName = "hr_boombox"
            },
            {
                model = `prop_tv_03`,
                coords = vec4(256.732300, -995.448059, -98.860565, 44.999935),
                itemName = "hr_tv3"
            },
            {
                model = `prop_tv_flat_03`,
                coords = vec4(262.689453, -1001.847717, -99.289253, 0.000000),
                itemName = "hr_flattv3"
            },
            {
                model = `prop_console_01`,
                coords = vec4(263.293823, -1001.851929, -99.303993, 355.000031),
                itemName = "hr_console"
            },
            {
                model = `p_v_43_safe_s`,
                coords = vec4(256.212585, -998.202881, -99.258621, 89.519806),
                itemName = "safe",
                spawn = true
            },
            {
                model = `sf_tre_alarmbox`,
                coords = vec4(265.045654, -1003.848633, -100.140739 + 1.3, 181.116486),
                itemName = "alarm",
                spawn = true
            },
        }
    },
    ["medium"] = {
        entrance = {
            pedCoords = vector4(346.635559, -1012.807312, -100.196182, 2.633196),
            coords = vector4(346.53, -1013.31, -99.2, 0),
            length = 0.4,
            width = 1.6,
            minZ = -100.4,
            maxZ = -97.8
        },
        stashes = {
            {
                coords = vector4(345.63, -1001.71, -99.2, 0),
                length = 1.6,
                width = 0.6,
                minZ = -101.2,
                maxZ = -99.0
            },
            {
                coords = vector4(351.26, -999.89, -99.2, 0),
                length = 0.8,
                width = 1.8,
                minZ = -101.2,
                maxZ = -99.0
            },
            {
                coords = vector4(350.68, -992.87, -99.15, 0),
                length = 0.8,
                width = 2.6,
                minZ = -101.15,
                maxZ = -97.75
            },
            {
                coords = vector4(348.76, -994.86, -99.2, 0),
                length = 0.8,
                width = 0.8,
                minZ = -101.2,
                maxZ = -99.2
            },
            {
                coords = vector4(344.49, -1001.22, -99.2, 0),
                length = 1.0,
                width = 0.6,
                minZ = -101.2,
                maxZ = -98.2
            },
            {
                coords = vector4(341.41, -996.19, -99.2, 0),
                length = 1.8,
                width = 1.0,
                minZ = -101.2,
                maxZ = -99.4
            },
            {
                coords = vector4(339.33, -1003.89, -99.2, 0),
                length = 0.8,
                width = 0.8,
                minZ = -101.2,
                maxZ = -99.2
            },
        },
        props = {
            {
                model = `prop_tv_flat_01`,
                coords = vec4(337.284546, -996.665833, -99.027641, 90.000000),
                itemName = "hr_bigtv"
            },
            {
                model = `prop_micro_01`,
                coords = vec4(344.850159, -1002.044678, -99.156044, 274.999939),
                itemName = "hr_microwave2"
            },
            {
                model = `prop_coffee_mac_02`,
                coords = vec4(342.768555, -1004.025574, -98.978867, 179.999985),
                itemName = "hr_coffeemaker"
            },
            {
                model = `prop_toaster_01`,
                coords = vec4(341.757813, -1004.018982, -99.093071, 67.499962),
                itemName = "hr_toaster2"
            },
            {
                model = `p_v_43_safe_s`,
                coords = vec4(350.591827, -1007.566406, -99.446220, 271.024780),
                itemName = "safe",
                spawn = true
            },
            {
                model = `sf_tre_alarmbox`,
                coords = vec4(348.432861, -1010.346375, -100.328339 + 1.3, 268.798523),
                itemName = "alarm",
                spawn = true
            },
        }
    },
    ["high"] = {
        entrance = {
            pedCoords = vector4(-1450.033447, -525.795654, 68.556641, 36.002113),
            coords = vector4(-1449.36, -526.79, 69.56, 215),
            length = 0.4,
            width = 2.6,
            minZ = 68.56,
            maxZ = 71.36
        },
        stashes = {
            {
                coords = vector4(-1451.24, -529.9, 69.56, 305),
                length = 2.2,
                width = 2.6,
                minZ = 68.56,
                maxZ = 69.96
            },
            {
                coords = vector4(-1457.32, -536.19, 68.15, 305),
                length = 1.2,
                width = 1.4,
                minZ = 66.95,
                maxZ = 70.75
            },
            {
                coords = vector4(-1469.2, -546.08, 68.15, 305),
                length = 3.0,
                width = 0.6,
                minZ = 67.15,
                maxZ = 68.15
            },
            {
                coords = vector4(-1468.17, -526.14, 68.15, 305),
                length = 1.0,
                width = 3.8,
                minZ = 67.55,
                maxZ = 70.15
            },
            {
                coords = vector4(-1462.09, -530.8, 63.35, 305),
                length = 2.4,
                width = 0.8,
                minZ = 62.35,
                maxZ = 63.35
            },
            {
                coords = vector4(-1466.47, -539.12, 63.36, 35),
                length = 0.8,
                width = 4.6,
                minZ = 62.36,
                maxZ = 64.76
            },
            {
                coords = vector4(-1472.28, -534.02, 63.35, 305),
                length = 1.0,
                width = 1.4,
                minZ = 62.35,
                maxZ = 63.35                
            },
            {
                coords = vector4(-1469.25, -534.44, 63.35, 305),
                length = 5.4,
                width = 0.6,
                minZ = 62.35,
                maxZ = 66.15                
            },
        },
        props = {
            {
                model = `prop_printer_01`,
                coords = vec4(-1456.313477, -534.511536, 69.281410, 125.000008),
                itemName = "hr_printer"
            },
            {
                model = `prop_t_telescope_01b`,
                coords = vec4(-1475.599487, -539.977661, 67.755814, 27.530407),
                itemName = "hr_telescope"
            },
            {
                model = `prop_tv_flat_01`,
                coords = vec4(-1479.178467, -531.975830, 68.371384, 35.000015),
                itemName = "hr_bigtv"
            },
            {
                model = `prop_laptop_01a`,
                coords = vec4(-1452.337402, -527.926208, 69.277954, 305.000031),
                itemName = "hr_laptop"
            },
            {
                model = `p_v_43_safe_s`,
                coords = vec4(-1474.805054, -530.357300, 63.099281, 124.866257),
                itemName = "safe",
                spawn = true
            },
            {
                model = `sf_tre_alarmbox`,
                coords = vec4(-1458.225464, -518.755432, 68.424522 + 1.3, 304.245575),
                itemName = "alarm",
                spawn = true
            },
        }
    },
}

-- disables prop holding
Config.DisableHoldingProp = false

Config.NightOnly = false

Config.ItemOffsets = {
    ["hr_toaster"] = { model = `prop_toaster_02`, offset = { 0.12, -0.025, -0.16, -91.5, 71.5, 0 }, bone = 57005 },
    ["hr_toaster2"] = { model = `prop_toaster_01`, offset = { 0.11, 0.11, -0.165, -112, 66, -1 }, bone = 57005 },
    ["hr_microwave"] = { model = `prop_micro_02`, offset = { 0.14, 0.06, -0.27, -120, 76.5, -19.5 }, bone = 57005 },
    ["hr_microwave2"] = { model = `prop_micro_01`, offset = { 0.2, 0.035, -0.24, -120, 81.5, -16 }, bone = 57005 },
    ["hr_boombox"] = { model = `prop_boombox_01`, offset = { 0.1, 0.165, -0.345, -116.5, 68.5, -6.5 }, bone = 57005 },
    ["hr_tv3"] = { model = `prop_tv_03`, offset = { 0.06, 0.265, -0.34, -88, -99, 10.5 }, bone = 57005 },
    ["hr_flattv3"] = { model = `prop_tv_flat_03`, offset = { 0.19, 0.07, -0.225, -120, 70, -13 }, bone = 57005 },
    ["hr_console"] = { model = `prop_console_01`, offset = { 0.185, 0.075, -0.21, -127.5, 75, -9 }, bone = 57005 },
    ["hr_bigtv"] = { model = `prop_tv_flat_01`, offset = { 0.09, 0.29, -0.23, -69, -111.5, 8 }, bone = 57005 },
    ["hr_coffeemaker"] = { model = `prop_coffee_mac_02`, offset = { 0.19, 0.005, -0.21, -50.5, 113.5, -143.5 }, bone = 57005 },
    ["hr_printer"] = { model = `prop_printer_01`, offset = { 0.21, -0.045, -0.2, -118.5, 78, -15 }, bone = 57005 },
    ["hr_telescope"] = { model = `prop_t_telescope_01b`, offset = { 0.265, -0.11, -0.9, -11.5, 0, 7 }, bone = 57005 },
    ["hack_phone"] = { model = `prop_phone_ing`, offset = { 0.135, 0.04, -0.075, -8, 0, 173 }, bone = 57005, noItem = true },
}

Config.DisableControls = {
    21,
    22,
    24,
    25,
    44,
    68,
    140,
    141,
    142,
    257,
    263,
    264,
}

-- disables jumping/running when holding prop
Config.DisableFastMovement = true

-- break prop when jumping (requires DisableFastMovement)
Config.BreakOnJump = true

-- none/error/warning/all
Config.Verbose = "warning"

-- enables dev comands
Config.DevMode = false

Config.Houses = {
    [1] = { coords = vector4(1336.8, -1578.84, 54.44, 36.88), type = 'medium', },
    [2] = { coords = vector4(1193.64, -1656.48, 43.04, 209.72), type = 'low' },
    [3] = { coords = vector4(1193.52, -1622.56, 45.24, 335.72), type = 'low' },
    [4] = { coords = vector4(1214.44, -1644.16, 48.64, 206.2), type = 'low' },
    [5] = { coords = vector4(1205.68, -1607.24, 50.72, 58.12), type = 'low' },
    [6] = { coords = vector4(1245.4, -1626.88, 53.28, 206.36), type = 'low' },
    [7] = { coords = vector4(1230.56, -1590.88, 53.76, 23.36), type = 'low' },
    [8] = { coords = vector4(1261.6, -1616.84, 54.76, 207.84), type = 'low' },
    [9] = { coords = vector4(1286.76, -1604.56, 54.84, 193.84), type = 'low' },

    [10] = { coords = vector4(384.92, -1881.72, 26.04, 47.36), type = 'low' },
    [11] = { coords = vector4(399.28, -1864.96, 26.72, 138.2), type = 'low' },
    [12] = { coords = vector4(412.36, -1856.28, 27.32, 117.64), type = 'low' },
    [13] = { coords = vector4(427.32, -1842.08, 28.48, 130.6), type = 'low' },
    [14] = { coords = vector4(440.4, -1829.56, 28.36, 315.16), type = 'low' },
    [15] = { coords = vector4(495.4, -1823.32, 28.88, 140.4), type = 'low' },
    [16] = { coords = vector4(512.52, -1790.8, 28.92, 273.08), type = 'low' },
    [17] = { coords = vector4(514.08, -1780.84, 28.92, 269.76), type = 'low' },
    [18] = { coords = vector4(479.72, -1735.76, 29.16, 339.28), type = 'low' },

    [19] = { coords = vector4(192.04, -1883.48, 25.04, 336.0), type = 'medium' },
    [20] = { coords = vector4(171.6, -1871.36, 24.4, 256.2), type = 'medium' },
    [21] = { coords = vector4(148.64, -1904.44, 23.52, 165.92), type = 'medium' },
    [22] = { coords = vector4(150.04, -1864.72, 24.6, 319.48), type = 'medium' },
    [23] = { coords = vector4(128.2, -1896.92, 23.68, 246.0), type = 'medium' },
    [24] = { coords = vector4(130.6, -1853.2, 25.24, 337.28), type = 'medium' },
    [25] = { coords = vector4(115.2, -1887.76, 23.92, 240.52), type = 'medium' },
    [26] = { coords = vector4(104.08, -1885.48, 24.32, 130.4), type = 'medium' },

    [27] = { coords = vector4(-223.0, -1585.88, 34.88, 88.28), type = 'low' },
    [28] = { coords = vector4(-223.16, -1601.28, 34.88, 81.96), type = 'low' },
    [29] = { coords = vector4(-208.72, -1600.6, 34.88, 261.44), type = 'low' },
    [30] = { coords = vector4(-209.96, -1607.04, 34.88, 259.76), type = 'low' },
    [31] = { coords = vector4(-212.84, -1618.08, 34.88, 178.16), type = 'low' },
    [32] = { coords = vector4(-223.08, -1617.48, 34.88, 89.36), type = 'low' },
    [33] = { coords = vector4(-215.64, -1576.4, 34.88, 324.96), type = 'low' },

    [34] = { coords = vector4(996.8, -729.44, 57.8, 129.64), type = 'medium' },
    [35] = { coords = vector4(970.72, -701.48, 58.48, 176.0), type = 'medium' },
    [36] = { coords = vector4(959.92, -669.88, 58.44, 116.12), type = 'medium' },
    [37] = { coords = vector4(928.88, -639.76, 58.24, 160.04), type = 'medium' },
    [38] = { coords = vector4(903.04, -615.44, 58.44, 44.72), type = 'medium' },
    [39] = { coords = vector4(886.72, -608.16, 58.44, 133.36), type = 'medium' },
    [40] = { coords = vector4(861.76, -583.6, 58.16, 190.12), type = 'medium' },

    [41] = { coords = vector4(-1192.92, 564.08, 100.32, 4.44), type = 'medium' },
    [42] = { coords = vector4(-1146.68, 545.84, 101.92, 187.6), type = 'medium' },
    [43] = { coords = vector4(-1125.36, 548.36, 102.56, 197.16), type = 'medium' },
    [44] = { coords = vector4(-1090.12, 548.68, 103.64, 300.6), type = 'medium' },
    [45] = { coords = vector4(-1022.56, 586.96, 103.44, 182.96), type = 'medium' },
    [46] = { coords = vector4(-974.4, 581.84, 103.16, 169.84), type = 'medium' },
    [47] = { coords = vector4(-947.92, 567.8, 101.52, 156.0), type = 'medium' },
    [48] = { coords = vector4(-924.84, 561.24, 100.16, 150.92), type = 'medium' },
    [49] = { coords = vector4(-904.64, 588.16, 101.2, 332.8), type = 'medium' },
    [50] = { coords = vector4(-848.64, 508.56, 90.8, 194.44), type = 'medium' },

    [51] = { coords = vector4(-1043.56, -1580.28, 5.04, 208.04), type = 'low' },
    [52] = { coords = vector4(-1049.12, -1581.0, 5.0, 122.72), type = 'low' },
    [53] = { coords = vector4(-1072.2, -1565.8, 4.36, 114.44), type = 'low' },
    [54] = { coords = vector4(-1063.72, -1557.52, 5.16, 314.04), type = 'low' },
    [55] = { coords = vector4(-1037.32, -1605.52, 5.0, 215.36), type = 'low' },
    [56] = { coords = vector4(-1039.24, -1610.24, 5.12, 142.12), type = 'low' },

    [57] = { coords = vector4(-1937.48, 551.12, 115.04, 251.88), type = 'medium' },
    [58] = { coords = vector4(-1996.32, 591.16, 118.08, 69.32), type = 'medium' },
    [59] = { coords = vector4(-1929.0, 595.36, 122.28, 255.88), type = 'medium' },
    [60] = { coords = vector4(-1974.76, 630.92, 122.68, 69.92), type = 'medium' },
    [61] = { coords = vector4(-1896.28, 642.52, 130.2, 311.2), type = 'medium' },

    [62] = { coords = vector4(1936.56, 3891.64, 32.96, 32.72), type = 'low' },
    [63] = { coords = vector4(1908.04, 3870.24, 32.88, 46.8), type = 'low' },
    [64] = { coords = vector4(1895.36, 3873.72, 32.76, 23.08), type = 'low' },
    [65] = { coords = vector4(1894.36, 3896.04, 33.2, 26.64), type = 'low' },
    [66] = { coords = vector4(1880.52, 3920.52, 33.2, 278.44), type = 'low' },
    [67] = { coords = vector4(1915.76, 3909.32, 33.44, 55.68), type = 'low' },

    [68] = { coords = vector4(1.76, 6612.52, 32.08, 213.0), type = 'medium' },
    [69] = { coords = vector4(-41.72, 6637.28, 31.08, 51.68), type = 'medium' },
    [70] = { coords = vector4(-26.64, 6597.12, 31.88, 223.48), type = 'medium' },
    [71] = { coords = vector4(-44.36, 6581.96, 32.16, 233.48), type = 'medium' },
    [72] = { coords = vector4(-15.32, 6557.44, 33.24, 137.96), type = 'medium' },
    [73] = { coords = vector4(11.52, 6578.28, 33.08, 46.12), type = 'medium' },
    [74] = { coords = vector4(31.0, 6596.64, 32.84, 43.8), type = 'medium' },

    [75] = { coords = vector4(-1477.741943, -519.608887, 33.736736, 42.633579), type = 'high' },
    [76] = { coords = vector4(-1504.943726, -522.652527, 32.423851, 215.425995), type = 'high' },
}

Config.BlipSettings = {
    radius = 250.0,
    radiusColor = 39,
    radiusAlpha = 128,
    blipSprite = 40,
    blipColor = 5,
    blipAlpha = 255,
    showRoute = true,
    routeColor = 5
}

Config.PoliceBlipSettings = {
    notification = true, -- notification for players
    disable = false,
    radius = 250.0, -- set to nil to disable area and to point exactly at house
    radiusColor = 39,
    radiusAlpha = 128,
    blipSprite = 40,
    blipColor = 5,
    blipAlpha = 255,
    liveTime = 3 * 60, -- time before blip dissapears (seconds)
}

Config.PoliceJob = "police"

Config.SafeDifficulty = 3 -- amount of locks

Config.MinigameOptions = {
    loadTime = 3000,
    dotCount = 5,
    speed = 0.00100,
    translation = {
        get_ready = _L("mg_get_ready"),
        success = _L("mg_success"),
        failed = _L("mg_failed"),
        title = _L("mg_title"),
    }
}

Config.SearchTime = 5000 -- search animations time

Config.DisableBlackout = false -- disabled blackout after hacking - only the lights on the alarm turns off