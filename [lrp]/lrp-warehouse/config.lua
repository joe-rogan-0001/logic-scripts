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

Config.CarPostOP = 'boxville4'
Config.CarGoPostal = 'boxville2'
Config.CarAlphaMail = 'mule3'
Config.CarDefault = 'mule3'
Config.DrawDistance = 8
Config.DepositPrice = 1000
Config.Payout = 5

Config.Warehouse = {
	JobStart = {
		Pos   = {x = 46.71, y = -2680.79, z = 6.01},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 27,
        BlipLabel = '[Warehouse] Boss',
        BlipColor = 24,
        BlipScale = 1.0,
	},
    Garage = {
		Pos   = {x = 12.19, y = -2648.88, z = 6.01},
		Size  = {x = 1.2, y = 1.2, z = 1.0},
		Color = {r = 78, g = 2453, b = 175},
		Type  = 27,
        BlipLabel = '[Warehouse] Garage',
        BlipColor = 24,
        BlipScale = 0.6,
	},
    PostOP = {
		Pos   = {x = 1190.47, y = -3326.51, z = 5.53},
	},
    GoPostal = {
		Pos   = {x = 117.92, y = 101.48, z = 81.04},
	},
    AlphaMail = {
		Pos   = {x = -691.42, y = -2449.28, z = 15.13},
	},
    IKEA = {
		Pos   = {x = 2703.87, y = 3457.31, z = 55.55},
	},
    
    GarageSpawnPoint =vector4(21.24, -2648.71, 6.01, 359.21),
    
    PackageMarker = {
		Size  = {x = 1.2, y = 1.2, z = 1.0},
        Color = {r = 78, g = 2453, b = 175},
        Type  = 27,
	},
}

Config.WarehouseSpots = {
    {x = 61.90, y = -2674.69, z = 6.01, taked = false, blip},
	{x = 59.01, y = -2675.84, z = 6.01, taked = false, blip},
	{x = 59.01, y = -2677.40, z = 6.01, taked = false, blip},
	{x = 58.93, y = -2679.86, z = 6.01, taked = false, blip},
	{x = 60.10, y = -2682.82, z = 6.01, taked = false, blip},
    {x = 61.96, y = -2682.82, z = 6.01, taked = false, blip},
    {x = 48.74, y = -2706.87, z = 6.00, taked = false, blip},
    {x = 47.04, y = -2706.85, z = 6.00, taked = false, blip},
    {x = 45.95, y = -2709.53, z = 6.02, taked = false, blip},
    {x = 45.98, y = -2712.15, z = 6.02, taked = false, blip},
    {x = 45.97, y = -2713.64, z = 6.02, taked = false, blip},
    {x = 45.81, y = -2736.69, z = 6.00, taked = false, blip},
    {x = 45.77, y = -2738.27, z = 6.00, taked = false, blip},
    {x = 45.76, y = -2740.34, z = 6.00, taked = false, blip},
    {x = 45.78, y = -2741.81, z = 6.00, taked = false, blip},
    {x = 45.75, y = -2743.85, z = 6.00, taked = false, blip},
}

Config.Companies = {
	{CompanyName = "GoPostal", blip},
	{CompanyName = "Post OP", blip},
    {CompanyName = "Alpha Mail", blip},
    {CompanyName = "IKEA", blip},
}

Config.GoPostal = {
    {x = 117.92, y = 101.48, z = 81.04, blip},
	{x = 113.54, y = 103.05, z = 81.03, blip},
}

Config.PostOP = {
    {x = 1190.47, y = -3326.51, z = 5.53, blip},
	{x = 1205.37, y = -3326.07, z = 5.53, blip},
}

Config.AlphaMail = {
    {x = -691.42, y = -2449.28, z = 15.13, blip},
	{x = -686.37, y = -2452.31, z = 15.13, blip},
    {x = -681.21, y = -2455.27, z = 15.13, blip},
}

Config.IKEA = {
    {x = 2703.87, y = 3457.31, z = 55.55, blip},
	{x = 2695.50, y = 3460.88, z = 56.23, blip},
    {x = 2685.86, y = 3464.88, z = 56.23, blip},
}

Config.Clothes = {
    male = {
        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
        ["torso2"]      = { item = 224, texture = 2},  -- JACKET
        ["arms"]        = { item = 0, texture = 0},  -- ArmS
        ["pants"]       = { item = 9, texture = 7},  -- PANTS
        ["shoes"]       = { item = 12, texture = 6},  -- SHOES    
        ["hat"]         = { item = 76, texture = 7},  -- HAT
    },
    female = {
        ["t-shirt"]     = { item = 15, texture = 0},  -- T Shirt
        ["torso2"]      = { item = 4, texture = 14},  -- JACKET
        ["arms"]        = { item = 4, texture = 0},  -- ArmS
        ["pants"]       = { item = 25, texture = 1},  -- PANTS
        ["shoes"]       = { item = 16, texture = 4},  -- SHOES    
        ["hat"]         = { item = 76, texture = 7},  -- HAT
    }
    -- male = {
    --     ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
    --     ['torso_1'] = 224,   ['torso_2'] = 2,
    --     ['arms'] = 0,
    --     ['pants_1'] = 9,   ['pants_2'] = 7,
    --     ['shoes_1'] = 12,   ['shoes_2'] = 6,
    --     ['helmet_1'] = 76,  ['helmet_2'] = 7,
    -- },
    -- female = {
    --     ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
    --     ['torso_1'] = 4,   ['torso_2'] = 14,
    --     ['arms'] = 4,
    --     ['pants_1'] = 25,   ['pants_2'] = 1,
    --     ['shoes_1'] = 16,   ['shoes_2'] = 4,
    -- }
}