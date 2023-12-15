Config = {}
Config.MaxWidth = 5.0
Config.MaxHeight = 5.0
Config.MaxLength = 5.0
Config.DamageNeeded = 100.0
Config.EnableProne = true
Config.JointEffectTime = 60
Config.RemoveWeaponDrops = true
Config.RemoveWeaponDropsTimer = 25
Config.DefaultPrice = 20 -- carwash

Config.BlacklistedScenarios = {
    ['TYPES'] = {
        "WORLD_VEHICLE_MILITARY_PLANES_SMALL",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG",
    },
    ['GROUPS'] = {
       -- 2017590552,
       -- 2141866469,
        -- 1409640232,
        -- `ng_planes`,
    }
}

Config.BlacklistedVehs = {
    [`SHAMAL`] = true,
    --[`LUXOR`] = true,
    --[`LUXOR2`] = true,
    --[`JET`] = true,
    [`LAZER`] = true,
    [`BUZZARD`] = true,
    [`ANNIHILATOR`] = true,
    [`SAVAGE`] = true,
    --[`TITAN`] = true,
    [`RHINO`] = true,
    [`FIRETRUK`] = true,
    --[`MULE`] = true,
    --[`MAVERICK`] = true,
    --[`BLIMP`] = true,
    --[`AIRTUG`] = true,
    [`CAMPER`] = true,    
    [`ADDER`] = true,    
}

Config.BlacklistedPeds = {
    [`s_m_y_ranger_01`] = true,
    [`s_m_y_sheriff_01`] = true,
    [`s_m_y_cop_01`] = true,
    [`s_f_y_sheriff_01`] = true,
    [`s_f_y_cop_01`] = true,
    [`s_m_y_hwaycop_01`] = true,
}

Config.Teleports = {
    --Elevator @ labs
    [1] = {
        [1] = {
            coords = vector4(3540.74, 3675.59, 20.99, 167.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Up'
        },
        [2] = {
            coords = vector4(3540.74, 3675.59, 28.11, 172.5),
            ["AllowVehicle"] = false,
            drawText = '[E] Take Elevator Down'
        },

    },
}

Config.Locations = { -- carwash
    [1] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(26.5906, -1392.0261, 27.3634),
    },
    [2] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(167.1034, -1719.4704, 27.2916),
    },
    [3] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-74.5693, 6427.8715, 29.4400),
    },
    [4] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-1200.4, -1720.46, 3.40),
    },
    [5] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(1363.22, 3592.7, 34.41),
    },
    [6] = {
        ["label"] = "Hands Free Carwash",
        ["coords"] = vector3(-699.6325, -932.7043, 17.0139),
    }
}

Config.Consumables = {
    eat = { -- default food items
        ["sandwich"] = math.random(35, 54),
        ["burger"] = math.random(35, 54),
        ["tosti"] = math.random(40, 50),
        ["twerks_candy"] = math.random(20, 35),
        ["snikkel_candy"] = math.random(20, 35),
        ["burger-bleeder"] = math.random(55, 64),
        ["burger-moneyshot"] = math.random(55, 64),
        ["burger-torpedo"] = math.random(55, 64),
        ["burger-heartstopper"] = math.random(55, 64),
        ["burger-meatfree"] = math.random(55, 64),
        ["burger-fries"] = math.random(40, 55),
    },
    drink = { -- default drink items
        ["water_bottle"] = math.random(35, 54),
        ["water"] = math.random(35, 54),
        ["cola"] = math.random(35, 54),
        ["kurkakola"] = math.random(35, 54),
        ["coffee"] = math.random(40, 50),
        ["burger-softdrink"] = math.random(55, 60),
        ["burger-mshake"] = math.random(55, 60),
    },
    alcohol = { -- default alcohol items
        ['whiskey'] = math.random(20, 30),
        ['beer'] = math.random(30, 40),
        ['vodka'] = math.random(20, 40),
    },
    custom = { -- put any custom items here
    -- ['newitem'] = {
    --     progress = {
    --         label = 'Using Item...',
    --         time = 5000
    --     },
    --     animation = {
    --         animDict = 'amb@prop_human_bbq@male@base',
    --         anim = 'base',
    --         flags = 8,
    --     },
    --     prop = {
    --         model = false,
    --         bone = false,
    --         coords = false, -- vector 3 format
    --         rotation = false, -- vector 3 format
    --     },
    --     replenish = {'''
    --         type = 'Hunger', -- replenish type 'Hunger'/'Thirst' / false
    --         replenish = math.random(20, 40),
    --         isAlcohol = false, -- if you want it to add alcohol count
    --         event = false, -- 'eventname' if you want it to trigger an outside event on use useful for drugs
    --         server = false -- if the event above is a server event
    --     }
    -- }
    }
}

Config.Disable = {
    hudComponents = {1, 2, 3, 4, 7, 9, 13, 14, 19, 20, 21, 22}, -- Hud Components: https://docs.fivem.net/natives/?_0x6806C51AD12B83B8
    controls = {37}, -- Controls: https://docs.fivem.net/docs/game-references/controls/
    displayAmmo = true, -- false disables ammo display
    ambience = false, -- disables distance sirens, distance car alarms, flight music, etc
    idleCamera = true, -- disables the idle cinematic camera
    vestDrawable = true, -- disables the vest equipped when using heavy armor
    pistolWhipping = true, -- disables pistol whipping
}

Config.Fireworks = {
    delay = 5, -- time in s till it goes off
    items = { -- firework items
        'firework1',
        'firework2',
        'firework3',
        'firework4'
    }
}
