-- all chances combined must equal to 100, you can use float values like 0.05 (0.05%)

Config.StashItems = {
    ["low"] = {
        { name = "hr_pan", count = 1, chance = 10 },
        { name = "hr_vinyl", count = 1, chance = 10 },
        { name = "hr_pendrive", count = 1, chance = 12 },
        { name = "hr_pliers", count = 1, chance = 12 },
        { name = "hr_mixer", count = 1, chance = 12 },
        { name = "hr_headphones", count = 1, chance = 12 },
        { name = "hr_phone", count = 1, chance = 12 },
        { name = "money", count = {10, 400}, chance = 20 },
    },
    ["medium"] = {
        { name = "hr_pan", count = 1, chance = 10 },
        { name = "hr_vinyl", count = 1, chance = 10 },
        { name = "hr_pendrive", count = 1, chance = 12 },
        { name = "hr_pliers", count = 1, chance = 12 },
        { name = "hr_mixer", count = 1, chance = 12 },
        { name = "hr_headphones", count = 1, chance = 12 },
        { name = "hr_phone", count = 1, chance = 12 },
        { name = "money", count = {10, 400}, chance = 20 },
    },
    ["high"] = {
        { name = "hr_pan", count = 1, chance = 10 },
        { name = "hr_vinyl", count = 1, chance = 10 },
        { name = "hr_pendrive", count = 1, chance = 12 },
        { name = "hr_pliers", count = 1, chance = 12 },
        { name = "hr_mixer", count = 1, chance = 12 },
        { name = "hr_headphones", count = 1, chance = 12 },
        { name = "hr_phone", count = 1, chance = 12 },
        { name = "money", count = {10, 400}, chance = 20 },
    },
}

Config.SafeItems = {
    ["low"] = {
        { name = "hr_headphones", count = 1, chance = 10 },
        { name = "hr_pendrive", count = 1, chance = 10 },
        { name = "money", count = {2500, 10000}, chance = 80 },
    },
    ["medium"] = {
        { name = "hr_headphones", count = 1, chance = 10 },
        { name = "hr_pendrive", count = 1, chance = 10 },
        { name = "money", count = {2500, 10000}, chance = 80 },
    },
    ["high"] = {
        { name = "hr_headphones", count = 1, chance = 10 },
        { name = "hr_pendrive", count = 1, chance = 10 },
        { name = "money", count = {2500, 10000}, chance = 80 },
    },
}

-- item count for each stash in interior (min, max)
Config.StashItemCount = {
    ["low"] = { 1, 2 },
    ["medium"] = { 1, 3 },
    ["high"] = { 2, 4 },
}

-- item count for each safe in interior (min, max)
Config.SafeItemCount = {
    ["low"] = { 1, 1 },
    ["medium"] = { 1, 2 },
    ["high"] = { 1, 4 },
}

Config.ItemPrices = {
    ["hr_pan"] = 50,
    ["hr_vinyl"] = 75,
    ["hr_pendrive"] = 200,
    ["hr_pliers"] = 25,
    ["hr_mixer"] = 75,
    ["hr_headphones"] = 25,
    ["hr_phone"] = 200,
    ["hr_toaster"] = 500,
    ["hr_toaster2"] = 500,
    ["hr_microwave"] = 500,
    ["hr_microwave2"] = 500,
    ["hr_boombox"] = 300,
    ["hr_tv3"] = 500,
    ["hr_flattv3"] = 700,
    ["hr_console"] = 600,
    ["hr_bigtv"] = 700,
    ["hr_coffeemaker"] = 400,
    ["hr_printer"] = 500,
    ["hr_telescope"] = 800,
    ["hr_laptop"] = 800
}

Config.AlarmTime = 60

-- destroy mission when house is empty for x seconds
Config.LastLeaveDestroy = 3 * 60
-- destroy house after first entry (seconds)
Config.AutoDestroy = 30 * 60

Config.AfkTime = 60 * 60

Config.SafeChance = 60

Config.DisableAlarm = {
    requiredItems = {
        ["hacking_usb"] = 1,
        ["hacking_usb"] = 1
    },
    addTime = 3 * 60, -- time the power is off (alarm timer will reset and start when the power turns back on)
}

Config.DoorCooldown = 1 -- cooldown between one player entry and other players exit (+ viceversa) should prevent bamboozling police (camping at entrance)

Config.CopsRequired = 0

Config.MissionPrice = {
    item = "money",
    count = 500
}

Config.MaxMissions = 5 -- max missions at a time
Config.WaitTime = 5--5 * 60 -- time between next roll for players
Config.LocationCooldown = 60 * 60 -- cooldown per location