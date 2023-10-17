Config = {}

-- Config Depen
Config.Webhook = {
	link = "",
	tag = true,
	img = '',
	color = 14423100 -- https://www.spycolor.com/
}

Config.Framework = 'qb-core'
Config.UseOxLib = true -- If false will use qb-menu and qb-input
Config.OxInventory = false -- Use Oxinventory
Config.Target = 'qb-target' -- qtarget, qb-target (ox-target will automatic conv)

Config.TimeLoop = 600 -- Time Loop to update plant

Config.Boss = { -- you can add more boss location here, he automatically switch locations every restart
    [1] = {
        ped = 'a_m_y_soucent_02',
        pos = vector4(88.58, -1434.18, 29.31, 142.83)
    },
}

Config.MinDisPlant = 1.0 -- Min Distand to plant (plant and plant)
Config.disPlant = 4.0 -- Max Distand to plant (player and plant)

Config.MinCops = {
    Corner = 2, -- allowed to do weed runs/cornering
    Taco = 3,
}

Config.PoliceAlert = {
    Corner = 5, -- 5%
    Taco = 15,
}

Config.Prop = {
    `bkr_prop_weed_01_small_01b`,
    `bkr_prop_weed_med_01a`,
    `bkr_prop_weed_med_01b`,
    `bkr_prop_weed_lrg_01a`,
    `bkr_prop_weed_lrg_01b`,
}

Config.Can = {
    Destroy = 95, -- If more than it can destroy and can't add maleor fertilizers
    Fertilizer = 95, -- If more than it can destroy and can't fertilizers
    Male = 75 -- If more than it can destroy and can't maleseed
}

Config.Items = {
    ['femaleseed'] = 'femaleseed',
    ['maleseed'] = 'maleseed',
    ['wateringcan'] = 'wateringcan',
    ['fertilizer'] = 'fertilizer',
    ['wetbud'] = 'wetbud',
    ['driedbud'] = 'driedbud',
    ['weedbaggie'] = 'weedbaggie',
    ['weedpackage'] = 'weedpackage',
    ['qualityscales'] = 'qualityscales',
    ['smallscales'] = 'smallscales',
    ['emptybaggies'] ='emptybaggies',
    ['joint'] = 'joint',
    ['rollingpaper'] = 'rollingpaper',
}

Config.Plant = {
    Button = {
        Plant = 38,
        Cancel = 44,
    },
    GrowthObjects = {
        {hash = `bkr_prop_weed_01_small_01b`, zOffset = -0.5},
        {hash = `bkr_prop_weed_med_01a`, zOffset = -0.5},
        {hash = `bkr_prop_weed_med_01b`, zOffset = -0.5},
        {hash = `bkr_prop_weed_lrg_01a`, zOffset = -0.5},
        {hash = `bkr_prop_weed_lrg_01b`, zOffset = -0.5},
    },
    Factor = 1.3, -- How much longer should a male plant take to grow
    GrowthTime = 240, -- Plant Growing time in minutes 240
    LifeTime = 1440, -- Plant lifetime in minutes before wiped-- Water drained from plants per minutes
    MinusWater = 0.25, -- 0.05% per minute on plants
    Water = { -- Watering Can
        Minus = 10, -- Minus 10% water in can per watering
        Add = 50, -- Add 50% to plant per water
    },
    HarvestPercent = 95, -- If more than it can destroy and can't add male or fertilizers
    MaleZone = false, -- If true, male plants will pollinate females around it, and turn them into males, in a perimeter of 20
    Dry = 0.25, -- 6 hours to dry weed
    CanDry = {
        ['stash'] = true,
        ['player'] = true,
        ['trunk'] = true,
    },
    Job = { -- Jobs that can destroy weed at any stage
        'police', -- Add more job if u want
    },
    -- Water rewards
    Collect = {
        [1] = {min = 1, max = 1},
        [2] = {min = 1, max = 1},
        [3] = {min = 1, max = 2},
        [4] = {min = 2, max = 2},
        [5] = {min = 2, max = 2},
        [6] = {min = 2, max = 2},
        [7] = {min = 2, max = 3},
        [8] = {min = 2, max = 3},
        [9] = {min = 2, max = 4}, -- at 80-90% ...
        [10] = {min = 3, max = 4}, -- at 90-100% water, you can harvest 3-4 buds/seeds
    },
    DestroyReward = { -- destroying plants give you fertilizers
        min = 1,
        max = 3
    },
    Debug = false, -- debug soils
    MaterialHashes = { -- soils
        [951832588] = true,  ---If u want plant more soil to plant, turn on debug and it in there
        [-461750719] = true,
        [930824497] = true,
        [581794674] = true,
        [-2041329971] = true,
        [-309121453] = true,
        [-913351839] = true,
        [-1885547121] = true,
        [-1915425863] = true,
        [-1833527165] = true,
        [2128369009] = true,
        [-124769592] = true,
        [-840216541] = true,
        [-2073312001] = true,
        [627123000] = true,
        [1333033863] = true,
        [-1286696947] = true,
        [-1942898710] = true,
        [-1595148316] = true,
        [435688960] = true,
        [223086562] = true,
        [1109728704] = true
    },
    MaxHarvest = 2,
}

Config.TacoShop = {
    Points = { -- delivery ped location
        vector4(-148.64, -1687.41, 36.17, 151.55),
        vector4(-157.73, -1679.89, 36.97, 151.15),
        vector4(-158.86, -1680.02, 36.97, 38.57),
        vector4(-162.4, -1637.61, 34.03, 322.81),
        vector4(26.43, -1815.44, 25.21, 331.3),
        vector4(207.34, -1759.71, 29.27, 302.74),
        vector4(420.54, -1564.77, 29.29, 51.76),
        vector4(165.02, -1322.19, 29.29, 160.84),
        vector4(141.48, -1059.3, 29.19, 167.76),
        vector4(299.42, -761.64, 29.33, 295.08),
        vector4(-3.57, -582.11, 38.83, 345.77),
        vector4(-269.38, -587.98, 33.56, 272.09),
        vector4(-574.35, -678.01, 32.36, 269.44),
        vector4(-731.48, -729.87, 28.46, 76.75),
        vector4(-753.3, -977.06, 16.13, 17.82),
        vector4(-951.79, -901.44, 2.16, 302.86),
        vector4(-1111.55, -902.22, 3.79, 124.29),
        vector4(-1305.86, -929.61, 12.36, 12.7),
        vector4(-1359.23, -710.65, 24.79, 127.05),
        vector4(-1453.27, -653.2, 29.58, 83.48),
        vector4(-1547.25, -524.91, 35.85, 35.97),
        vector4(-1715.72, -446.77, 42.65, 47.7),
        vector4(-1790.35, -368.79, 45.11, 337.98),
        vector4(-1533.63, -326.94, 47.91, 51.61),
        vector4(-1369.52, -169.13, 47.49, 79.62),
        vector4(-1159.79, -219.77, 41.5, 252.27),
        vector4(-813.33, -195.63, 37.48, 25.26),
        vector4(-635.99, 44.07, 42.7, 84.02),
        vector4(-520.8, 162.07, 71.08, 274.57),
        vector4(-620.23, 208.61, 74.21, 200.95),
        vector4(-942.9, 312.36, 71.35, 181.5),
        vector4(-1114.9, 492.23, 82.19, 171.26),
        vector4(-1370.26, 356.42, 64.25, 166.22),
        vector4(-1648.91, 247.28, 62.39, 213.02),
        vector4(-1898.71, 132.68, 81.98, 303.35),
        vector4(-1896.2, 641.93, 130.21, 138.15),
        vector4(1171.41, -291.82, 69.02, 318.51),
        vector4(1221.25, -669.01, 63.49, 74.95),
        vector4(802.08, -725.23, 27.81, 52.3),
        vector4(857.44, -942.94, 26.28, 115.7),
        vector4(978.15, -1500.15, 31.51, 85.26),
        vector4(1193.49, -1622.34, 45.22, 123.56),
        vector4(1005.17, -2128.42, 31.69, 264.73),
    },
    Ped = { -- Weed run peds
    'ig_money',
	'a_m_y_beachvesp_02',
	'a_m_y_breakdance_01',
	'ig_car3guy1',
	'a_m_y_business_03',
	's_m_m_cntrybar_01',
	'ig_devin',
	'ig_dreyfuss',
	'a_m_m_fatlatin_01',
	'u_m_y_baygor',
    'a_f_m_downtown_01',
    'a_m_m_tourist_01',
    'a_m_o_soucent_03',
    'a_m_y_juggalo_01',
    'a_m_y_soucent_02',
    'a_m_y_vinewood_01',
    'g_m_y_famfor_01',
    'g_m_y_mexgang_01',
    'g_m_m_chigoon_01',
    'g_f_importexport_01',
    },
    Delivery = 3, -- 3 box per deliver
}
-- Weed runs payout
Config.Price = {
    ['weedpackage'] = 500,
    ['weedpackage_bonus'] = 10,
    ['weedpackage_divisor'] = 200,
    ['weedpackage_max'] = 3500, -- Total payout can't exceed $3500.
    ['perRep'] = {
        divisor = 800,
        money = 5,
     }
}

-- payout = StrainRepMoney + PersonalRepMoney + WeedPackage.
-- StrainRepMoney = (StrainRepPoints / weedpackage_divisor * weedpackage_bonus)
-- PersonalRepMoney = (PerRep Points / PerRep.divisor)* money

Config.Meta = {  -- Per Meta
    type = 'weed-rep',
    amount = 1, -- Add if people sell for 1 cornerselling
}

Config.Rate = {
    emptybaggies = 1.0, -- 50%
}

Config.WaitPackage = 20 -- Wait 20 seconds for boss to pack boxes

Config.Joint = {
    min =1,
    max = 2,
    per= 25, -- Smoking weed gives you 1-2 seeds of the same strain, at 25%
}

Config.Blip = {
    ["delivery"] = {
        sprite = 514,
        range = true,
        color = 52,
        scale = 0.7,
        label = "Drop Off Spot"
    }
}

-- Scales config
Config.JointLossRate = {
    ['qualityscales'] = 100, -- no loss
    ['smallscales'] = math.random(70, 80), -- lose 20-30% of weed
    ['none'] = math.random(40, 50)
}

Config.Amount = { 
    ['driedbud'] = 20, -- 1 packed bud to 20 joints
    ['weedpackage'] = 5, -- 1 weedpackge = 5 driedbud
    ['weedbaggie'] = 16 -- 1 weed baggie = 8 joints
}

-- *Reputation
Config.RepName = 40000 -- 40k rep points to be able to change names
Config.RepString = { -- Rep = 10 means 10 baggies need to be sold to level up
    -- Example: you can corner 300 baggies a day, your team has 5 people, it takes 605000/100 = 40 days to hit max rep on a strain.
    -- Possible to add unlimited rep stages
    -- Rep point is not capped
    [0] = {rep = 0, name = "Grass"},
    [1] = { rep = 1500, name = "Schwag" },
    [2] = { rep = 3500, name = "Burk" },
    [3] = {rep = 10000, name = "Reggie"},
    [4] = {rep = 15000, name = "Mids"},
    [5] = {rep = 20000, name = "Dank"},
    [6] = {rep = 25000, name = "Chronic"},
    [7] = {rep = 30000, name = "Admired"},
    [8] = { rep = 40000, name = "Primo" },
    [9] = {rep = 50000, name = "Respected"},
    [10] = { rep = 60000, name = "Ganja" },
}

-- *Payouts calculations

Config.Corner = { -- Maybe don't touch this
    On = true, -- On if want u my conrnerselling
    PopulateRate = 1000 * 60 * 2, -- default: 2 min/populate, -1 to disable
    TimeBetweenAcquisition = 60 * 1000, -- default: 1 min/ped
    Money = 50,
    -- Purchase
    areaRep = { -- Area rep is server wide, and will become 0 every tsunami/script restart.
        -- areaRep = (x/25)*1 -- x will +1 every sale made (not baggies sold)
        max = 120, -- Capped at $120 
        divisor = 25, -- 25 sales (not baggies sold).
        money = 1, -- Add 1 dollar every level reached
    },
    perRep = { -- Personal Rep will be persistent forever. +1 every cornering sales done.
        -- for every "divisor" you have + $1 in your payout 
        max = 40, -- Capped at 40 dollars
        divisor = 800, -- 800 sales (not baggies sold).
        money = 1, -- Add 1 dollar every level reached
    },
    strainRep = { -- Strain Rep will be persistent forever
        max = 60, -- Capped at $60
        divisor = 1000, -- 1000 sales (not baggies sold).
        money = 1, -- Add 1 dollar every level reached
    },
    -- Payout = Area Rep + Personal Rep + Strain Rep + Money
    -- Example 1: You hit max rep on all factors with our default setting above. Estimated to be atleast 6 months of work? (not sure, feel free to make suggestions)
    -- Payout = 120 + 40 + 60 + 50 = $270 per baggie. Now this is capped and wont go higher.
    --
    -- Example 2: Lil Seoul currently has 1200 areaRep points. You have 25000 perRep points. Strain level 6, 25000 strainRep points.
    -- Payout = (1200/25) + (25000/800) + (25000/1000) + 50 = $154/baggie
    --
   -- Example 3: Just start selling weed for the first time, in your own shitty strain, but selling at a hot zone that everyones been selling, which means that area has max areaRep.
    -- Payout = 120(areaRep.max) + 0(No personal Rep) + 0(No Strain Rep) + 50 = 170
        WhitelistedZones = { -- Whitelisted zones https://docs.fivem.net/natives/?_0xCD90657D4C30E1CA
        ['EBURO'] = true,
        ['MURRI'] = true,
        ['MIRR'] = true,
        ['EAST_V'] = true,
        ['CHAMH'] = true,
        ['DAVIS'] = true,
        ['CYPRE'] = true,
        ['HAWICK'] = true,
        ['DTVINE'] = true,
        ['BURTON'] = true,
        ['MOVIE'] = true,
        ['ROCKF'] = true,
        ['RICHM'] = true,
        ['PBLUFF'] = true,
        ['DELPE'] = true,
        ['BEACH'] = true,
        ['TERMINA'] = true,
        ['PBOX'] = true,
        ['KOREAT'] = true,
    },
    Effect = {
        Amount = 2, -- Aromor add
        Time = 60, -- time /s
    },
}
-- Extra clean money when sell cornering
-- *Money Laundering
Config.BandsItem = 'bands'
Config.MinBandsPayout = 450
Config.MaxBandsPayout = 550
Config.BandsLaunderingChance = 10
Config.MaxBandsToClean = 20
Config.MinBandsToClean = 10

Config.RollsItem = 'rolls'
Config.MaxRollsToCleanPayout = 100
Config.MinRollsToCleanPayout = 45
Config.RollsLaunderingChance = 5
Config.MaxRollsToClean = 60
Config.MinRollsToClean = 30

Config.Lang = {
    ['fill_water'] = {label = "Filling Can", time = 3000},
    ['add_water'] = {label = "Watering", time = 3000},
    ['add_fertilizer'] = {label = "Adding Fertilizer", time = 3000},
    ['add_maleseed'] = {label = "Adding Male Seed", time = 3000},
    ['plantseed'] = {label = "Planting", time = 3000},
    ['harvestPlant'] = {label = "Harvesting Plant", time = 3000},
    ['weighing_package'] = {label = "Weighing Package", time = 3000},
    ['count_bills'] = {label = "Counting Bills", time = 3000},
    ['pack_bud'] = {label = "Packing", time = 3000},
    ['corner_prepare'] = {label = "Preparing", time = 3000},
    ['roll_joint'] = {label = "Rolling Joints", time = 2000},
    ['smoke_joint'] = {label = "Lighting Joints", time = 5000},
    ['prepare_baggie'] = {label = "Preparing", time =3000},
    ['join'] = {label ="Sign In", icon = "fa-solid fa-user"},
    ['out'] = {label ="Sign Out", icon = "fa-solid fa-user"},
    ['delivery'] = {label ="Deliver Package", icon ="fas fa-hand-holding-box"},
    ['checkStrain'] = {label = "Check Strains", icon = "fas fa-cannabis"},
    ['buyList'] = {label = "Purchase Large Delivery List", icon = "fas fa-list-alt"},
    ['packageGood'] = {label = "Package Goods", icon = "fas fa-box"},
    ['collectPackage'] = {label = "Collect Package", icon = "fas fa-box"},
    ['corner-sell'] = {label = "Sell", icon = "fa-solid fa-comments-dollar"},
    ['check'] = {label = "Check", icon = "fas fa-cannabis"},
    ['harvest'] = {label = "Harvest", icon = "fas fa-hand-paper"},
    ['cornerselling'] = {label = "Cornering weed", icon = "fa-solid fa-handshake"},
    ['stop'] = {label = "Stop cornering weed", icon = "fa-solid fa-handshake-slash"},
    ['error_inwater'] = {label = "You are not near any water source", type = "error", time = 5000},
    ['error_swim'] = {label = "You are swimming", type = "error", time = 5000},
    ['error_material'] = {label = "Find better ground to plant!", type = "error", time = 5000},
    ['error_harvest'] = {label = "Not ready for harvesting", type = "error", time = 5000},
    ['error_notstrain'] = {label = "Weed don't have strain", type = "error", time = 5000},
    ['error_nobox'] = {label = "Where's the delivery? Is this a scam?", type = "error", time = 5000},
    ['error_enough'] = {label = "You don't have enough green mate", type = "error", time = 5000},
    ['error_busy'] = {label = "Someone is already preparing a package", type = "error", time = 5000},
    ['error_scale'] = {label = "You need a scale to pack joints", type = "error", time = 5000},
    ['error_rollingpaper'] = {label = "Not enough papers", type = "error", time = 5000},
    ['error_emptybaggies'] = {label = "You need more empty baggies", type = "error", time = 5000},
    ['error_long'] = {label = "Too long of a name", type = "error", time = 5000},
    ['error_zone'] = {label = "Nobody is buying around here", type = "error", time = 5000},
    ['error_name'] = {label = "A strain with that name already exists", type = "error", time = 5000},
    ['error_tooclose'] = {label = "There's another tree very close", type = "error", time = 5000},
    ['error_toofar'] = {label = "You can't plant too far", type = "error", time = 5000},
    ['not_time'] = {label = "Wait!!!", type = "error", time = 5000},
    ['missing-baggies'] = {label = "You need more baggies to sell", type = "error", time = 5000},
    ['stop_sell'] = {label = "Stopped selling drugs", type = "error", time = 5000},
    ['dried-up'] = {label = "Looks like this spot has dried up", type = "error", time = 5000},
    ['sofar'] = {label = "No longer selling...", type = "error", time = 5000},
    ['start_sell'] = {label = "Started selling drugs", type = "primary", time = 5000},
    ['name'] = {label = "You have successfully named your strain!", type = "success", time = 5000},
    ['myStrain'] = {header = "My Strains"},
    ['changename'] = {header = "My Strains", txt = "Max Length : 21", submit = "Submit", label = "New names"},
    ['strainrep'] = {txt = "Strain's Rep: "},
    ['plant'] = {label = "Plant seed"},
    ['growth'] = {label = "Growth: "},
    ['destroy'] = {label = "Destroy Plant", time = 3000},
    ['fertilizer'] = {label = "Add Fertilizer"},
    ['gender'] = {label = "Gender: %s"},
    ['need'] = {label = "Requires a Watering Can"},
    ['water'] = {label = "Add Water", txt = "Water: "},
    ['maleseeds'] = {label = "Add Male Seed", txt = "Make the plant preggies"},
    ['strain'] = {header = "Fertilizing Recipe", submit = "Submit", n = "Nitrogen (1-61)", p = "Phosphorus (1-77)", k = "Potassium (1-19)"},
    ['cancel'] = {label = "Cancel"},
    ['error_police'] = {label = "There's a situation! Come back later!", type = "error", time = 5000},
    ['steal'] = {label = "Find and steal a vehicle to use as transport.", header = "CURRENT", icon = "fas fa-people-carry", color ="#59c5f7"},
    ['stage1'] = {label = "Drive to the handoff location with the transport vehicle.", header = "CURRENT", icon = "fas fa-people-carry", color ="#59c5f7", time = "NONE"},
    ['stage2'] = {label = "Deliver the package", header = "CURRENT", icon = "fas fa-people-carry", color ="#59c5f7", time = "NONE"},
    ['stage3'] = {label = "Drive to next location with the transport vehicle", header = "CURRENT", icon = "fas fa-people-carry", color ="#59c5f7", time = "NONE"},
    ['done'] = {label =  "Job Finished", header = "CURRENT", icon = "fas fa-people-carry", color ="#59c5f7", time = 5000},
}

Config.StrainX1 = {
    'Afghani Wonder',
    'Afgooey',
    'Apollo',
    'Buddha',
    'Burmaberry',
    'BushDoctor',
    'Bushmans',
    'Chem',
    'Cherry',
    'Chocolope',
    'Cinnamon',
    'Cotton',
    'Cripple',
    'Crystal',
    'Donk',
    'Ducksfoot',
    'Dutch',
    'Elvis',
    'Orange',
    'Rosado',
    'Verde',
    'Violeta',
    'Haze',
    'Urkle',
    'Emerald',
    'G',
    'Dynamite',
    'Earthquake',
    'Elephant',
    'Endless Sky',
    'Erez',
    'Euphoria',
    'Frosty',
    'Pebbles',
    'Incredible',
    'Melt',
    'Funky',
    'Cheese',
    'Firewalker',
    'Flo',
    'Fraggle',
    'Frankenberry',
    'Leonard',
    'Freeze',
    'Skydog',
    'Special',
    'Spurkle',
    'Sputnik',
    'Fuzzy',
    'George',
    'Ghost',
    'Scout',
    'Glass',
    'Gnarsty',
    'God',
    'Tora',
    'Vortex',
    'Shark',
    'Star',
    'Starry',
    'Tangerine',
}

Config.StrainX2 = {
    'Platinum',
    'Pineapple',
    'Papaya',
    'Lace',
    'Coconut',
    'Linen',
    'Bone',
    'Moss',
    'Shamrock',
    'Seafoam',
    'Pine',
    'Pakalolo',
    'Ivory',
    'Cream',
    'Egg shell',
    'Remus',
    'Salt',
    'Peanut',
    'Carob',
    'Hickory',
    'Salmon',
    'Pecan',
    'Walnut',
    'Caramel',
    'Gingerbread',
    'Syrup',
    'Parakeet',
    'Mint',
    'Seaweed',
    'Somantra',
    'Pistachio',
    'Basil',
    'Crocodile',
    'Brown',
    'Coffee',
    'Special',
    'Sweet',
    'Penny',
    'Cedar',
    'Grey',
    'Shadow',
    'Graphite',
    'Iron',
    'Pewter',
    'Cloud',
    'Silver',
    'Smoke',
    'Slate',
    'Anchor',
    'Ash',
    'Porpoise',
    'Dove',
    'Fog',
    'Flint',
    'Charcoal',
    'Pebble',
    'Lead',
    'Coin',
    'Fossil',
    'Black',
    'Ebony',
    'Crow',
    'Charcoal',
    'Onyx',
    'Pitch',
    'Soot',
    'Sable',
    'Coal',
    'Metal',
    'Obsidian',
    'Spider',
    'Leather',
    'Midnight',
    'Ink',
    'Raven',
    'Oil',
    'Grease',
}

Config.StrainX3 = {
    'Chase',
    'Cocktail',
    'Cocopuff',
    'Herb',
    'Chronic',
    'Blossom',
    'Flower',
    'Weed',
    'Pot',
    'Grass',
    'Reefer',
    'Ganja',
    'Lace',
    'Butter',
    'Geek',
    'Hash',
    'Bud',
    'Plant',
    'Bush',
}
