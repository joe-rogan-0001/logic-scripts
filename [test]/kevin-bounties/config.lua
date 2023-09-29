Config = Config or {}

Config.CoolDown = 1800 --- Cooldown until can start next job
Config.CallTimer = math.random(10, 180) * 1000 --- Timer until Fib agent contacts you with contract
Config.DeskPed = "ig_michelle"
Config.DeskPedLocation = vector4(-449.48, 1062.99, 327.68, 147) -- Location of start ped

Config.Locations = {
    [1] = { -- Davis Ave Area
        SpawnGoons = 'true', -- true if to spawn goons around the target that will protect the target
        TargetLocations = vector4(220.61, -1523.2, 29.14, 290.39), -- Location of the target ped
        GoonLocations = {
            vector4(222.48, -1528.34, 29.17, 285.32), -- Locations for the goon peds that spawn around the target bed can add more if you like...
            vector4(227.15, -1523.58, 29.14, 269.48),
            vector4(224.13, -1516.11, 29.14, 247.04),
            vector4(216.31, -1522.77, 29.29, 274.73)
        },
        BountyPay = math.random(7500, 10000) -- self explanatory
    },
    [2] = { -- Vinewood Area
        SpawnGoons = 'true',
        TargetLocations = vector4(355.48, 437.78, 146.16, 290.44),
        GoonLocations = {
            vector4(354.13, 435.76, 146.82, 311.7),
        },
        BountyPay = math.random(12500, 16000) -- self explanatory
    },
    [3] = { -- Baycity Area
        SpawnGoons = 'true',
        TargetLocations = vector4(-1688.02, -451.21, 40.7, 234.62),
        GoonLocations = {
            vector4(-1689.64, -452.74, 40.79, 252.08),
        },
        BountyPay = math.random(10000, 12500) -- self explanatory
    },
    [4] = { -- Sandy Area
        SpawnGoons = 'true',
        TargetLocations = vector4(1721.57, 3869.35, 34.79, 346.12),
        GoonLocations = {
            vector4(1720.16, 3867.89, 34.79, 108.18),
        },
        BountyPay = math.random(10000, 12500) -- self explanatory
    },
}

Config.TargetPeds = { --- Random peds that will spawn as the target
    `a_m_m_beach_01`,
    `a_m_m_og_boss_01`,
    `a_m_m_salton_04`,
    `a_m_m_soucent_01`,
    `a_m_m_soucent_04`,
    `a_m_o_soucent_02`,
    `a_m_y_beach_02`,
    `a_m_y_latino_01`,
    `a_m_y_soucent_02`,
    `a_m_y_soucent_03`,
}

Config.GoonPeds = {--- Random peds that will spawn as the Goons
    `g_m_y_ballaeast_01`,
    `g_m_y_ballaorig_01`,
    `g_m_y_ballasout_01`,
    `csb_ballasog`,
}

Config.TargetNames = { -- Random names for the contract etc
    'Ben',
    'Benjamin',
    'Bruno',
    'Charles',
    'Williams',
    'Devon',
    'George',
    'David',
    'Harry',
    'John',
    'Kevin',
    'Bercete',
    'Shorty'
}

Config.TargetLastNames = {
    'Porter',
    'Alexander',
    'Haberdasher',
    'Friar',
    'Scrivener',
    'Ostler',
    'Tutor',
    'Balliol',
    'Canmore',
    'Stuart',
    'Blois',
    'Charleston',
    'Mcnally',
    'Ferenczy',
    'Duffy',
    'Bromley',
    'Bercete',
    'Ward'
}

Config.WantedFor = {--- Random Crimes that will show on the bounty item
    'Human Trafficing',
    'Illegal Firearms Distribution',
    'Robbery of Safe Houses',
    'Assisination of VIP',
    'Eating too many doughnuts'
}