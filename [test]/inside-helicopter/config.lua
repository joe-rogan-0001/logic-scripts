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

Config.Payout = 1700

Config.jobrequirement = false --whether work requires a job
Config.jobname = '' --name of the job that is required

Config.airtransportation = { --The place and type of spawn for the boss and the helicopter
	['BossSpawn'] = { 
		Pos = {x = -1183.84, y = -2764.41, z = 13.95, h = 239.33}, 
		Type  = 's_m_m_pilot_01', 
	},
	['Helipad'] = {
		{model = 'cargobob', x = -1177.68, y = -2844.69, z = 14.40, h = 149.62, blip},
		{model = 'cargobob', x = -1145.03, y = -2863.04, z = 14.40, h = 149.91, blip},
		{model = 'cargobob', x = -1111.54, y = -2881.89, z = 14.40, h = 149.67, blip},
	},
}

Config.HelicopterRandomize = { --Places to be drawn
	{name='first'},
    {name='second'},
    {name='third'},
    {name='fourth'},
}



Config.HelicopterPlaces = { --Mission locations
    ['first'] = { 
		Pos = {x = -840.23, y = -1277.51, z = 4.82, h = 216.07}, --Place of vehicle to be picked up 
		Type  = 'elegy', --Vehicle type
        PosDrop = {x = 621.95, y = 610.46, z = 129.00, h = 339.79}, --Place of the tow truck
        PosToTeleportPlayer = {x = 620.37, y = 612.69, z = 128.91, h = 168.45},  --The place where he is to teleport the player after delivering the vehicle to the tow truck   
	},
    ['second'] = { 
		Pos = {x = -1728.43, y = -718.29, z = 9.80, h = 146.20}, 
		Type  = 'elegy',
        PosDrop = {x = -282.49, y = 318.30, z = 93.34, h = 89.86},
        PosToTeleportPlayer = {x = -284.12, y = 316.23, z = 93.25, h = 286.45},     
	},
    ['third'] = { 
		Pos = {x = -727.43, y = 972.30, z = 237.48, h = 41.19}, 
		Type  = 'elegy',
        PosDrop = {x = -1657.13, y = 67.93, z = 63.20, h = 292.09},
        PosToTeleportPlayer = {x = -1656.74, y = 70.42, z = 63.19, h = 152.19},     
	},
    ['fourth'] = { 
		Pos = {x = -1679.74, y = 488.96, z = 128.50, h = 113.96}, 
		Type  = 'elegy',
        PosDrop = {x = -1591.30, y = -885.66, z = 9.88, h = 320.48},
        PosToTeleportPlayer = {x = -1592.19, y = -883.44, z = 9.86, h = 157.15},     
	},
}

Config.Destination = { --The place where we are to deliver the vehicle with a tow truck must be the same and named as in HelicopterRandomize
    ['first'] = { 
        Pos = {x = -1478.36, y = -510.34, z = 32.81, h = 116.46}, 
    }, 
    ['second'] = { 
        Pos = {x = -785.70, y = -187.67, z = 37.28, h = 213.93}, 
    }, 
    ['third'] = { 
        Pos = {x = -362.02, y = -132.58, z = 38.68, h = 212.23}, 
    }, 
    ['fourth'] = { 
        Pos = {x = -206.52, y = -1304.91, z = 31.34, h = 298.61}, 
    }, 
    ['fifth'] = { 
        Pos = {x = -265.10, y = 197.59, z = 85.38, h = 39.14}, 
    },    
}

Config.Clothes = { --The clothes to change into when starting
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 48,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 9,   ['pants_2'] = 0,
        ['shoes_1'] = 14,   ['shoes_2'] = 4,
        ['chain_1'] = 0,    ['chain_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['ears_1'] = -1,     ['ears_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
    },
    female = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 47,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 1,
        ['pants_1'] = 29,   ['pants_2'] = 0,
        ['shoes_1'] = 25,   ['shoes_2'] = 0,
        ['chain_1'] = -1,    ['chain_2'] = 0,
        ['helmet_1'] = -1,  ['helmet_2'] = 0,
        ['bproof_1'] = 0,  ['bproof_2'] = 0
    }
}

