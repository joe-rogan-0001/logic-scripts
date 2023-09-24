Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DEL'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

Config = {}

Config.jobrequirement = false --whether work requires a job
Config.jobname = 'builder' --name of the job that is required

Config.builder = {
	['BossSpawn'] = { 
		Pos = {x = 23.84, y = -619.75, z = 35.34, h = 252.04}, --Place of commencement of work
		Type  = 'cs_floyd', --model ped
	}
}

Config.Places1lvl = {
    [1] = {
        Pos = {x = -91.56, y = -1030.82, z = 27.87, h = 6.10}, --Place of accepting the order
		Type  = 's_m_y_construct_02',  --model ped
        Payout = 450,
        Places = {
            {
                Pos = {x = -110.26, y = -1026.15, z = 27.27, h = 345.23}, --Workplace
                Done = false, --do not touch
                WorkingTime = 2500, --Time to work
                Tool = 'weld', --Type of tool: weld, pneumatic hammer, hammer, drill
                blip, --do not touch
            },
            {
                Pos = {x = -87.09, y = -994.86, z = 27.31, h = 191.46},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = -145.76, y = -1035.13, z = 27.27, h = 343.37},
                Done = false,
                WorkingTime = 2500,
                Tool = 'hammer',
                blip,
            },
            {
                Pos = {x = -155.79, y = -1029.31, z = 27.27, h = 67.43},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = -81.82, y = -984.99, z = 27.29, h = 249.17},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = -157.30, y = -1068.85, z = 18.69, h = 280.19},
                Done = false,
                WorkingTime = 2500,
                Tool = 'weld',
                blip,
            },
            {
                Pos = {x = -160.84, y = -1078.49, z = 18.69, h = 258.40},
                Done = false,
                WorkingTime = 2500,
                Tool = 'weld',
                blip,
            },
        },
    },
    [2] = {
        Pos = {x = 0.82, y = -436.76, z = 39.74, h = 38.69}, 
		Type  = 's_m_y_construct_02', 
        Payout = 490,
        Places = {
            {
                Pos = {x = 79.65, y = -422.04, z = 37.55, h = 250.21},
                Done = false,
                WorkingTime = 2500,
                Tool = 'weld',
                blip,
            },
            {
                Pos = {x = 71.47, y = -446.20, z = 37.55, h = 338.91},
                Done = false,
                WorkingTime = 2500,
                Tool = 'weld',
                blip,
            },
            {
                Pos = {x = 87.75, y = -441.57, z = 37.55, h = 159.08},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 80.61, y = -458.37, z = 37.55, h = 248.56},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 101.97, y = -368.31, z = 42.48, h = 164.07},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = 24.63, y = -359.22, z = 39.31, h = 241.64},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
        },
    },
    [3] = {
        Pos = {x = -510.11, y = -1001.67, z = 23.55, h = 70.75}, 
		Type  = 's_m_y_construct_02', 
        Payout = 500,
        Places = {
            {
                Pos = {x = -460.53, y = -1009.33, z = 23.79, h = 268.28},
                Done = false,
                WorkingTime = 2500,
                Tool = 'weld',
                blip,
            },
            {
                Pos = {x = -449.46, y = -1013.87, z = 23.97, h = 86.05},
                Done = false,
                WorkingTime = 2500,
                Tool = 'weld',
                blip,
            },
            {
                Pos = {x = -449.08, y = -999.16, z = 23.96, h = 272.77},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = -462.95, y = -998.12, z = 23.74, h = 89.12},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = -459.58, y = -1004.84, z = 23.79, h = 299.12},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = -455.75, y = -1004.74, z = 23.86, h = 71.68},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = -469.64, y = -1037.24, z = 23.55, h = 306.53},
                Done = false,
                WorkingTime = 2500,
                Tool = 'hammer',
                blip,
            },
        },
    },
    [4] = {
        Pos = {x = -1959.85, y = 212.93, z = 86.51, h = 272.07}, --The place where the order is accepted
		Type  = 'a_f_m_bevhills_01', --model ped
        Payout = 400,
        Places = {
            {
                Pos = {x = -1971.59, y = 185.98, z = 86.58, h = 26.70}, --Workplace
                Done = false,--do not touch
                WorkingTime = 2500, --Time to work
                Tool = 'hammer',--Type of tool: weld, pneumatic hammer, hammer, drill
                blip,--do not touch
            },
            {
                Pos = {x = -1982.32, y = 207.35, z = 86.60, h = 292.35},
                Done = false,
                WorkingTime = 2500,
                Tool = 'hammer',
                blip,
            },
            {
                Pos = {x = -1984.55, y = 212.40, z = 86.60, h = 297.24},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = -1986.41, y = 215.95, z = 86.60, h = 300.28},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
        },
    },
    [5] = {
        Pos = {x = 1351.70, y = -756.62, z = 66.90, h = 7.66}, 
		Type  = 'a_f_m_bevhills_01',
        Payout = 450, 
        Places = {
            {
                Pos = {x = 1342.84, y = -773.63, z = 66.77, h = 340.54},
                Done = false,
                WorkingTime = 2500,
                Tool = 'hammer',
                blip,
            },
            {
                Pos = {x = 1352.79, y = -761.93, z = 67.67, h = 322.65},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 1346.73, y = -773.81, z = 67.67, h = 151.98},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 1342.67, y = -772.08, z = 67.67, h = 158.13},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 1349.40, y = -758.48, z = 66.83, h = 350.45},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
        },
    },
    [6] = {
        Pos = {x = 1334.03, y = -710.22, z = 66.02, h = 176.87}, 
		Type  = 'a_f_m_bevhills_01', 
        Payout = 490,
        Places = {
            {
                Pos = {x = 1326.09, y = -706.52, z = 66.12, h = 345.38},
                Done = false,
                WorkingTime = 2500,
                Tool = 'hammer',
                blip,
            },
            {
                Pos = {x = 1328.99, y = -690.88, z = 66.10, h = 161.32},
                Done = false,
                WorkingTime = 2500,
                Tool = 'hammer',
                blip,
            },
            {
                Pos = {x = 1337.56, y = -700.89, z = 66.87, h = 163.38},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 1333.42, y = -697.20, z = 66.87, h = 72.04},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 1334.46, y = -693.64, z = 66.87, h = 355.97},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
            {
                Pos = {x = 1335.36, y = -707.49, z = 66.87, h = 180.55},
                Done = false,
                WorkingTime = 2500,
                Tool = 'drill',
                blip,
            },
        },
    },
    [7] = {
        Pos = {x = 1391.88, y = -761.16, z = 66.82, h = 6.89}, 
		Type  = 'a_f_m_bevhills_01', 
        Payout = 400,
        Places = {
            {
                Pos = {x = 1397.72, y = -768.16, z = 66.41, h = 205.13},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = 1397.61, y = -773.43, z = 66.53, h = 8.05},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = 1392.59, y = -774.99, z = 66.43, h = 111.82},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
            {
                Pos = {x = 1385.38, y = -766.01, z = 66.50, h = 9.13},
                Done = false,
                WorkingTime = 2500,
                Tool = 'pneumatic hammer',
                blip,
            },
        },
    },
}

-- Config.Clothes = {
--     [1] = { --The first tier of clothes
--         male = {
--             ['tshirt_1'] = 59,  ['tshirt_2'] = 1,
--             ['torso_1'] = 56,   ['torso_2'] = 0,
--             ['decals_1'] = 0,   ['decals_2'] = 0,
--             ['arms'] = 0,
--             ['pants_1'] = 63,   ['pants_2'] = 0,
--             ['shoes_1'] = 14,   ['shoes_2'] = 0,
--             ['chain_1'] = 0,    ['chain_2'] = 0,
--             ['helmet_1'] = 0,  ['helmet_2'] = 0,
--             ['ears_1'] = -1,     ['ears_2'] = 0,
--             ['bproof_1'] = 0,  ['bproof_2'] = 0
--         },
--         female = {
--             ['tshirt_1'] = 36,  ['tshirt_2'] = 1,
--             ['torso_1'] = 73,   ['torso_2'] = 0,
--             ['decals_1'] = 0,   ['decals_2'] = 0,
--             ['arms'] = 14,
--             ['pants_1'] = 74,   ['pants_2'] = 0,
--             ['shoes_1'] = 24,   ['shoes_2'] = 0,
--             ['chain_1'] = -1,    ['chain_2'] = 0,
--             ['helmet_1'] = 0,  ['helmet_2'] = 0,
--             ['bproof_1'] = 0,  ['bproof_2'] = 0
--         }
--     },
--     [2] = { --The second tier of clothes
--         male = {
--             ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
--             ['torso_1'] = 63,   ['torso_2'] = 0,
--             ['decals_1'] = 0,   ['decals_2'] = 0,
--             ['arms'] = 0,
--             ['pants_1'] = 10,   ['pants_2'] = 0,
--             ['shoes_1'] = 25,   ['shoes_2'] = 0,
--             ['chain_1'] = 0,    ['chain_2'] = 0,
--             ['helmet_1'] = -1,  ['helmet_2'] = 0,
--             ['ears_1'] = -1,     ['ears_2'] = 0,
--             ['bproof_1'] = 0,  ['bproof_2'] = 0
--         },
--         female = {
--             ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
--             ['torso_1'] = 86,   ['torso_2'] = 0,
--             ['decals_1'] = 0,   ['decals_2'] = 0,
--             ['arms'] = 0,
--             ['pants_1'] = 25,   ['pants_2'] = 0,
--             ['shoes_1'] = 28,   ['shoes_2'] = 0,
--             ['chain_1'] = -1,    ['chain_2'] = 0,
--             ['helmet_1'] = -1,  ['helmet_2'] = 0,
--             ['bproof_1'] = 0,  ['bproof_2'] = 0
--         }
--     },
--     [3] = { --The third level of clothing
--         male = {
--             ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
--             ['torso_1'] = 123,   ['torso_2'] = 0,
--             ['decals_1'] = 0,   ['decals_2'] = 0,
--             ['arms'] = 0,
--             ['pants_1'] = 47,   ['pants_2'] = 0,
--             ['shoes_1'] = 35,   ['shoes_2'] = 0,
--             ['chain_1'] = 0,    ['chain_2'] = 0,
--             ['helmet_1'] = -1,  ['helmet_2'] = 0,
--             ['ears_1'] = -1,     ['ears_2'] = 0,
--             ['bproof_1'] = 0,  ['bproof_2'] = 0
--         },
--         female = {
--             ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
--             ['torso_1'] = 119,   ['torso_2'] = 0,
--             ['decals_1'] = 0,   ['decals_2'] = 0,
--             ['arms'] = 0,
--             ['pants_1'] = 49,   ['pants_2'] = 0,
--             ['shoes_1'] = 36,   ['shoes_2'] = 0,
--             ['chain_1'] = -1,    ['chain_2'] = 0,
--             ['helmet_1'] = -1,  ['helmet_2'] = 0,
--             ['bproof_1'] = 0,  ['bproof_2'] = 0
--         }
--     }
-- }

