Config = Config or {}
Config.MinimumDrugSalePolice = 0


Config.Dealers = {}

Config.CornerSellingDrugsList = {
    "cokebaggy",
    "weed_bag",
    "meth"
}

Config.DrugsPrice = {
    ["cokebaggy"] = {
        min = 110,
        max = 130,
    },
    ["meth"] = {
        min = 130,
        max = 140,
    },
    ["weed_bag"] = {
        min = 40,
        max = 70,
    },
}



Config.CornerSellingZones = {
    [1] = {
	["coords"] = vector3(-1415.53, -1041.51, 4.62),
        ["time"] = {
            ["min"] = 12,
            ["max"] = 18,
        },
    },
}
