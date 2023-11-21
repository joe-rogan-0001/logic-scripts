--[[
    READ THE DOCS BEFORE USING THE SCRIPT FOR THE FIRST TIME
    READ THE DOCS BEFORE USING THE SCRIPT FOR THE FIRST TIME
    READ THE DOCS BEFORE USING THE SCRIPT FOR THE FIRST TIME
    https://docs.av-scripts.com/laptop-pack/av-racing
    https://docs.av-scripts.com/laptop-pack/av-racing
    https://docs.av-scripts.com/laptop-pack/av-racing
]]

Config = {}
Config.Debug = false
Config.Framework = "QBCore" -- "QBCore" or "ESX", for ESX uncomment the import from fxmanifest.lua
Config.DistanceUnit = "miles" -- "KM" or "miles" (To modify the text in UI go to av_laptop/build/lang.json and search distance_unit)
Config.MoneyAccount = "cosmo" -- Account used to pay the race fee
Config.BlipColor = 50 -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
Config.Blips = { -- https://docs.fivem.net/docs/game-references/blips/#blip-colors
    Route = {color = 6},
    Generic = { Size = 1.0, Color = 38 },
    Next = { Size = 1.3, Color = 47 },
    Passed = { Size = 0.6, Color = 62 }
}
Config.FlareTime = 10 -- In seconds
Config.StartAndFinishModel = `prop_offroad_tyres02`
Config.CheckpointPileModel = `xm_prop_base_tripod_lampa`
Config.MinimumCheckpoints = 5 -- Minimum Checkpoints required for a race
Config.MinTireDistance = 2.0 -- Min distance between checkpoint tire piles
Config.MaxTireDistance = 30.0 -- Max distance between checkpoint tire piles
Config.JoinDistance = 200 -- Distance between player and race to join
Config.MaxTimeDNF = 1 -- Max time (in minutes) players have to complete the race after the 1st place has finish it, all the racers who haven't completed it will be marked as DNF.
Config.EventExpirationTime = 10 -- Max time (in minutes) before removing an event that has reached it starting time and has not being started
Config.RouteDistance = 100 -- It won't render the route in GPS if the distance between your last blip and the next one is less than 100 meters.
Config.AdminLevel = "admin" -- Admin level, used for permissions in APP, check the docs to customize server/framework/permissions.lua
Config.CreateCrew = "racing:crew" -- Admin command used to open the crew menu
Config.ClassCommand = "class" -- Used to view the vehicle class, or change it to false to disable it
Config.AllowPassengers = true -- Allow passengers to join races and see checkpoints/UI, they don't have to pay any money and they won't receive anything if they are in the winning vehicle
Config.WinnersPrizes = { -- Divide the prize pot with the 1st, 2nd and 3rd place from a total of 100%
    [1] = {percentage = 70, moneyAccount = "cosmo", label = "cosmo"}, --% Percentage for 1st place - account where the winner will receive his prize 
    [2] = {percentage = 20, moneyAccount = "cosmo", label = "cosmo"}, --% Percentage for 2nd place - account where the winner will receive his prize 
    [3] = {percentage = 10, moneyAccount = "cosmo", label = "cosmo"}, --% Percentage for 3rd place - account where the winner will receive his prize 
    -- The total from all places can't be more than 100%, otherwise the script will ignore your values and give the 100% to 1st place and 0 to all other places
}
Config.MinRacersRecord = 10 -- In order to update a player record, the race needs at least X racers competing, otherwise no records (races / wins) will be updated for anyone in race
Config.TheUnderground = true -- Enable/Disable The Underground button
Config.EditorKeys = {
    ['add'] = {Label = "7 - Add Checkpoint  \n", key = 161},
    ['distance'] = {Label = "] [ - Light Distance  \n", key = {decrease = 39, increase = 40}},
    ['delete'] = {Label = "8 - Delete Checkpoint  \n", key = 162},
    ['cancel'] = {Label = "9 - Cancel Editor  \n", key = 163},
    ['save'] = {Label = "E - Save Race  \n", key = 38},
}

Config.DefaultProfile = { -- Default profile for new users
    photo = "https://i.imgur.com/p0oT829.png",
    age = "18",
    nationality = "Unknown",
    lights = "purple",
    blip = "purple",
    story = "",
    animation = "smoke",
}

Config.TracksCategories = { -- Colors: https://mantine.dev/theming/colors/#default-colors
    -- Cops can only view/access the tracks and events with the "police" category
    {value = "bikes", label = "Bikes", color = "green.2", canUse = function() return not exports['av_laptop']:isCop() end},
    {value = "circuit", label = "Circuit", color = "violet.2", canUse = function() return not exports['av_laptop']:isCop() end},
    {value = "drag", label = "Drag", color = "orange.2", canUse = function() return not exports['av_laptop']:isCop() end},
    {value = "police", label = "Police", color = "blue.2", canUse = function() return exports['av_laptop']:isCop() end},
}

Config.Animations = {
    ['smoke'] = {
        label = "Smoke Weed (Male Only)",
        animation = "WORLD_HUMAN_DRUG_DEALER",
        scenario = true
    },
    ['crossarms'] = {
        label = "Cross Arms",
        dict = "random@street_race",
        animation = "_car_b_lookout",
    },
    ['blowkiss'] = {
        label = "Blow Kiss",
        dict = "anim@mp_player_intcelebrationfemale@blow_kiss",
        animation = "blow_kiss",
    },
    ['bow'] = {
        label = "Bow",
        dict = "anim@arena@celeb@podium@no_prop@",
        animation = "regal_a_1st",
    },
    ['bringit'] = {
        label = "Bring It On",
        dict = "misscommon@response",
        animation = "bring_it_on",
    },
    ['cop'] = {
        label = "Cop",
        dict = "anim@amb@nightclub@peds@",
        animation = "rcmme_amanda1_stand_loop_cop",
    },
    ['throat'] = {
        label = "Cut Throat",
        dict = "anim@mp_player_intcelebrationmale@cut_throat",
        animation = "cut_throat",
    },
    ['fingers'] = {
        label = "Double Finger",
        dict = "anim@mp_player_intupperfinger",
        animation = "idle_a_fp",
    },
    ['flex'] = {
        label = "Flex",
        animation = "WORLD_HUMAN_MUSCLE_FLEX",
        scenario = true
    },
    ['gang'] = {
        label = "Gang Sign",
        dict = "mp_player_int_uppergang_sign_a",
        animation = "mp_player_int_gang_sign_a",
    },
}