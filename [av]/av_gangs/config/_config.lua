Config = {}
Config.MaxMembers = 10 -- Max members per gang
Config.Framework = "QBCore" -- QBCore or ESX
Config.TargetSystem = "qb-target" -- qtarget or qb-target, if you are using ox_target leave it as qtarget
Config.CheckGang = "gang:check" -- Verify your current gang command
Config.RegisterGangCommand = "gang:register" -- Command to create gangs in game
Config.SetGangBossCommand = "gang:boss" -- Command for add a boss to a gang
Config.RemoveGangMember = "gang:remove" -- Command for removing a gang member/boss
Config.DeleteGang = "gang:wipe" -- Removes the full gang and members
Config.AdminLevel = "admin" -- Admin level required to access commands ^^^
Config.SprayItem = 'spray' -- Used to place graffiti
Config.SprayRemover = 'spray_remover' -- Used to remove graffitis
Config.PlaceSprayTime = 30 -- in seconds
Config.RemoveSprayTime = 30 -- in seconds
Config.SprayTime = 6 -- (hours) Time before the spray item becomes totally unuseable, if the gang doesn't use it that time then GG
Config.ItemLimit = { -- How many of this item can a gang buy per server restart
    [Config.SprayItem] = 2,
    [Config.SprayRemover] = 1,
}
Config.NPC = {
    -- model = NPC model for spray and remover shop https://docs.fivem.net/docs/game-references/ped-models/
    -- coords = x, y, z, heading
    {model = `a_m_m_eastsa_01`, coords = {-297.21, -1332.04, 30.3, 317.49}},
}
Config.SprayPrice = 15000 -- Spray base price
Config.SprayMultiplier = 1.25 -- Multiplier for spray price (SprayPrice * SprayMultiplier * Graffitis Count)
Config.SprayRemoverPrice = 50000
Config.ShopAccount = "bank" -- Account used to buy spray/spray_remover
Config.SprayDistance = 7 -- How far from wall you can spray / remove a graffiti using remover item
Config.MinMembersForSpray = 1 -- Min members online to place a graffiti
Config.MinMembersForRemover = 0 -- Min members online to remove their graffiti
Config.ShowBlips = "gang:blips" -- Command to show/remove spray blips on map
Config.ZoneRadius = 109.0 -- Gang zone radius created around the spray, applies for both zone and blip.
Config.SprayGivesEXP = 5 -- Gang receives EXP when creating a graffiti or false, each 100 points is 1 level for Gangs, Max 5 levels (500 points)
Config.RemoveSprayGivesEXP = 15 -- Remove other Gang Spray will give you EXP or false
Config.RobAccount = "cash" -- Your money account, used when you rob a gang member
Config.RobMoney = {min = 25, max = 100} -- Amount of money you can rob from a rival gang NPC
Config.Sprays = { -- Only registered gangs will be able to use spray and spray remover + rob NPC members
    ["yakuza"] = { -- Gang name
        Grafiti = "spray_ballas", -- Graffiti model name (without .ydr)
        blipColor = 27, -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
        ped = {"g_f_y_ballas_01", "g_m_y_ballaeast_01"} -- https://docs.fivem.net/docs/game-references/ped-models/
    },
}