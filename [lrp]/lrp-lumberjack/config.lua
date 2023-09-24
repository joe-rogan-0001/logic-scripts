Config = Config or {}
Config.Job = true                                                  -- False = Job is not required / True = Job is required
Config.UseBlips = true                                              -- True / false option for toggling farm blips
Config.Timeout = 12 * (60 * 1000)                                   -- 20 minutes

-- Blips
LumberDepo = {
    targetZone = vector3(1167.73, -1347.27, 33.92),                 -- lrp-target vector
    targetHeading = 273.47,                                         -- lrp-target box zone
    coords = vector4(1167.73, -1347.27, 33.92, 273.47),             -- Move Location (Ped and blip)
    SetBlipSprite = 85,                                             -- Blip Icon (https://docs.fivem.net/docs/game-references/blips/)
    SetBlipDisplay = 6,                                             -- Blip Behavior (https://docs.fivem.net/natives/?_0x9029B2F3DA924928)
    SetBlipScale = 0.85,                                            -- Blip Size
    SetBlipColour = 5,                                              -- Blip Color
    BlipLabel = "Lumber Depo",                                      -- Blip Label
    minZ = 31.92,                                                   -- Max Z
    maxZ = 35.92,                                                   -- Max Z
    Vehicle = 'tiptruck',                                           -- Job Vehicle
    VehicleCoords = vector4(1162.27, -1318.55, 34.74, 173.91),      -- Job Vehcile Coords
}
LumberProcessor = {
    targetZone = vector3(-517.13, 5331.54, 79.26),
    targetHeading = 336.38,
    coords = vector4(-517.13, 5331.54, 79.26, 336.38),
    SetBlipSprite = 365,
    SetBlipDisplay = 6,
    SetBlipScale = 1.15,
    SetBlipColour = 64,
    BlipLabel = "Lumber Processor",
    minZ = 77.26,
    maxZ = 81.26,
}
LumberSeller = {
    targetZone = vector3(259.44, -3059.57, 4.86),
    targetHeading = 131.34,
    coords = vector4(259.44, -3059.57, 4.86, 131.34),
    SetBlipSprite = 605,
    SetBlipDisplay = 6,
    SetBlipScale = 0.85,
    SetBlipColour = 45,
    BlipLabel = "Lumber Seller",
    minZ = 2.86,
    maxZ = 6.86,
}

LumberJob = {
    ChoppingTreeTimer = 12 * 1000,                                  -- 12 second timer
    LumberAmount = math.random(2, 5),
    TreeBark = math.random(1, 3),
    ProcessingTime = 10 * 1000,                                     -- 10 second timer
    TradeAmount = math.random(3, 4),
    TradeReceived = math.random(1, 3),
    AxePrice = 500,                                                 -- Axe Price ($100)
}

Config.Sell = {
    ["tree_lumber"] = {
        ["price"] = math.random(45, 60)                             -- Seller Price
    },
    ["tree_bark"] = {
        ["price"] = math.random(50, 70)
    },
    ["wood_plank"] = {
        ["price"] = math.random(100, 150)
    },
}

Config.Axe = {
    [`weapon_battleaxe`] = {}
}






Config.TreeLocations = {
    [1] = {
        ["coords"] = vector3(-504.47, 5392.09, 75.82),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [2] = {
        ["coords"] = vector3(-510.08, 5389.15, 73.71),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [3] = {
        ["coords"] = vector3(-558.32, 5418.98, 62.78),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [4] = {
        ["coords"] = vector3(-561.47, 5420.32, 62.39),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [5] = {
        ["coords"] = vector3(-578.9, 5427.22, 58.54),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [6] = {
        ["coords"] = vector3(-600.28, 5397.03, 52.48),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [7] = {
        ["coords"] = vector3(-614.04, 5399.73, 50.86),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [8] = {
        ["coords"] = vector3(-616.38, 5403.72, 50.59),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [9] = {
        ["coords"] = vector3(-553.08, 5445.65, 64.16),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [10] = {
        ["coords"] = vector3(-500.53, 5401.34, 75.05),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [11] = {
        ["coords"] = vector3(-491.78, 5395.47, 77.57),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [12] = {
        ["coords"] = vector3(-457.24, 5398.19, 79.35),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [13] = {
        ["coords"] = vector3(-456.87, 5408.32, 79.26),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [14] = {
        ["coords"] = vector3(-627.6, 5322.19, 59.86),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [15] = {
        ["coords"] = vector3(-626.05, 5315.49, 60.87),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [16] = {
        ["coords"] = vector3(-628.47, 5286.07, 63.75),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [17] = {
        ["coords"] = vector3(-604.23, 5243.57, 71.53),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [18] = {
        ["coords"] = vector3(-599.94, 5239.87, 71.87),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [19] = {
        ["coords"] = vector3(-556.65, 5233.61, 72.53),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [20] = {
        ["coords"] = vector3(-557.92, 5224.02, 77.24),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [21] = {
        ["coords"] = vector3(-546.26, 5219.38, 77.94),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [22] = {
        ["coords"] = vector3(-537.93, 5226.47, 78.52),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [23] = {
        ["coords"] = vector3(-628.32, 5286.04, 63.76),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [24] = {
        ["coords"] = vector3(-633.1, 5275.56, 69.11),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [25] = {
        ["coords"] = vector3(-604.37, 5243.69, 71.89),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [26] = {
        ["coords"] = vector3(-646.03, 5269.73, 74.01),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [27] = {
        ["coords"] = vector3(-644.29, 5241.2, 76.3),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [28] = {
        ["coords"] = vector3(-657.02, 5296.15, 69.35),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [29] = {
        ["coords"] = vector3(-659.05, 5293.48, 70.02),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [30] = {
        ["coords"] = vector3(-664.32, 5277.7, 74.4),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [31] = {
        ["coords"] = vector3(-615.24, 5433.06, 54.3),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [32] = {
        ["coords"] = vector3(-616.14, 5424.5, 51.71),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [33] = {
        ["coords"] = vector3(-690.07, 5304.85, 70.51),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [34] = {
        ["coords"] = vector3(-474.49, 5393.85, 78.27),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [35] = {
        ["coords"] = vector3(-457.99, 5397.8, 79.41),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [36] = {
        ["coords"] = vector3(-457.6, 5408.86, 78.79),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [37] = {
        ["coords"] = vector3(-452.87, 5375.35, 81.06),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [38] = {
        ["coords"] = vector3(-480.05, 5380.55, 79.34),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [39] = {
        ["coords"] = vector3(-510.0, 5390.33, 73.11),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [40] = {
        ["coords"] = vector3(-516.82, 5375.37, 71.72),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [41] = {
        ["coords"] = vector3(-498.92, 5364.43, 75.77),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [42] = {
        ["coords"] = vector3(-569.72, 5395.12, 59.22),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [43] = {
        ["coords"] = vector3(-589.39, 5426.16, 56.37),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [44] = {
        ["coords"] = vector3(-597.65, 5443.58, 57.52),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [45] = {
        ["coords"] = vector3(-588.41, 5426.54, 56.63),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [46] = {
        ["coords"] = vector3(-586.36, 5447.83, 60.29),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [47] = {
        ["coords"] = vector3(-592.83, 5448.89, 59.27),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [48] = {
        ["coords"] = vector3(-594.07, 5451.87, 59.47),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [49] = {
        ["coords"] = vector3(-599.35, 5443.74, 57.22),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [50] = {
        ["coords"] = vector3(-614.65, 5433.4, 53.55),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [51] = {
        ["coords"] = vector3(-615.46, 5424.81, 51.09),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [52] = {
        ["coords"] = vector3(-620.06, 5428.99, 52.63),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [53] = {
        ["coords"] = vector3(-627.11, 5432.29, 51.95),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [54] = {
        ["coords"] = vector3(-637.15, 5441.51, 52.6),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [55] = {
        ["coords"] = vector3(-648.05, 5437.28, 51.29),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [56] = {
        ["coords"] = vector3(-644.09, 5409.6, 48.04),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [57] = {
        ["coords"] = vector3(-654.47, 5423.95, 45.67),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [58] = {
        ["coords"] = vector3(-661.98, 5424.96, 44.04),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [59] = {
        ["coords"] = vector3(-663.25, 5398.95, 52.18),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [60] = {
        ["coords"] = vector3(-680.79, 5433.77, 47.3),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [61] = {
        ["coords"] = vector3(-692.46, 5402.85, 51.44),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [62] = {
        ["coords"] = vector3(-685.7, 5400.17, 51.92),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [63] = {
        ["coords"] = vector3(-680.76, 5390.48, 54.07),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [64] = {
        ["coords"] = vector3(-677.24, 5388.54, 54.23),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [65] = {
        ["coords"] = vector3(-688.49, 5371.8, 61.69),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [66] = {
        ["coords"] = vector3(-664.77, 5367.21, 58.06),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [67] = {
        ["coords"] = vector3(-667.82, 5349.88, 62.66),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [68] = {
        ["coords"] = vector3(-683.38, 5350.02, 67.16),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [69] = {
        ["coords"] = vector3(-708.68, 5362.08, 63.9),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [70] = {
        ["coords"] = vector3(-720.59, 5376.34, 58.97),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [71] = {
        ["coords"] = vector3(-736.26, 5374.98, 57.18),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [72] = {
        ["coords"] = vector3(-760.6, 5356.46, 56.42),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [73] = {
        ["coords"] = vector3(-758.89, 5355.31, 57.0),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [74] = {
        ["coords"] = vector3(-762.99, 5360.08, 55.29),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [75] = {
        ["coords"] = vector3(-775.48, 5365.99, 50.41),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [76] = {
        ["coords"] = vector3(-786.74, 5365.18, 51.43),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [77] = {
        ["coords"] = vector3(-767.29, 5379.1, 48.34),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [78] = {
        ["coords"] = vector3(-753.51, 5387.04, 49.5),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [79] = {
        ["coords"] = vector3(-749.85, 5396.84, 45.75),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [80] = {
        ["coords"] = vector3(-612.14, 5236.0, 72.98),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [81] = {
        ["coords"] = vector3(-628.81, 5246.07, 74.06),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [82] = {
        ["coords"] = vector3(-639.97, 5279.95, 69.42),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [83] = {
        ["coords"] = vector3(-676.59, 5271.49, 75.69),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [84] = {
        ["coords"] = vector3(-652.19, 5297.14, 68.35),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [85] = {
        ["coords"] = vector3(-694.95, 5296.63, 70.59),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [86] = {
        ["coords"] = vector3(-678.96, 5324.19, 67.58),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [87] = {
        ["coords"] = vector3(-667.68, 5349.44, 62.67),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [88] = {
        ["coords"] = vector3(-681.82, 5349.19, 66.97),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [89] = {
        ["coords"] = vector3(-689.89, 5328.62, 69.28),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [90] = {
        ["coords"] = vector3(-717.24, 5329.57, 70.77),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [91] = {
        ["coords"] = vector3(-721.34, 5324.62, 71.86),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [92] = {
        ["coords"] = vector3(-708.6, 5360.53, 64.33),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [93] = {
        ["coords"] = vector3(-689.05, 5372.51, 61.41),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [94] = {
        ["coords"] = vector3(-720.4, 5377.81, 58.63),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [95] = {
        ["coords"] = vector3(-613.81, 5337.89, 69.39),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },
    [96] = {
        ["coords"] = vector3(-600.37, 5375.62, 68.36),
        ["isChopped"] = false,
        ["isOccupied"] = false,
    },




}

Config.Alerts = {
    ['cancel'] = 'Cancelled',
    ['error_lumber'] = 'You do not have any lumber to do this',
    ['error_axe'] = 'You dont have a axe to chop the tree',
    ['lumber_progressbar'] = 'Trading lumber for wooden planks',
    ['itemamount'] = 'You are trying to process a amount that is invalid try again!',
    ['lumber_processed'] = 'You successfully traded your lumber for ' ..LumberJob.TradeReceived.. ' wooden planks',
    ['error_sold'] = 'You dont have the items to sell here!',
    ['successfully_sold'] = 'You have sold your items',

    ["axe_check"] = 'You already have a axe',
    ["axe_bought"] = 'You have bought a axe from the boss for $' ..LumberJob.AxePrice,

    ['phone_sender'] = 'Lumber Mill Supervisor',
    ['phone_subject'] = 'Job task',
    ['phone_message'] = 'You have been tasked to gather lumber near the paleto bay lumber mill. Once you have finished gathering lumber speak to the mill boss to process the lumber.',

    ['chopping_tree'] = 'Chopping Tree',

    ['Tree_label'] = 'Start Chopping',
    ['depo_label'] = 'Talk to boss',
    ['mill_label'] = 'Talk to mill boss',

    ['depo_blocked'] = 'Vehicle blocking depo',
    ['depo_stored'] = 'Job Vehicle Stored',

    ['vehicle_header'] = 'Lumber Jack Vehicles',
    ['vehicle_get'] = 'Logger Vehicle',
    ['vehicle_text'] = 'Job Vehicle',

    ['battleaxe_label'] = 'Lumber Axe',
    ['battleaxe_text'] = 'Axe used for chopping down trees',
    
    ['vehicle_remove'] = 'Remove Vehicle',
    ['remove_text'] = 'Remove Job Vehicle',

    ['lumber_mill'] = 'Lumber Mill',
    ['lumber_header'] = 'Process Lumber',
    ['lumber_text'] = 'Trade for wooden planks',

    ['Lumber_Seller'] = 'Sell Lumber',

    ['goback'] = '< Go Back',

}