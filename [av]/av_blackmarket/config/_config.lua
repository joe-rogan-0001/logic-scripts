Config = {}
Config.TargetSystem = "qb-target" -- qb-target or qtarget, if using ox_target it will automatically convert it
Config.BlipCoords = {2168.10, 3330.53, 46.81}
Config.BlipIcon = 306
Config.BlipScale = 0.8
Config.BlipColor = 3

Config.Categories = {
    ['hacker'] = { 
        label = "Hacker", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            return true
        end,
        items = {
            {name = "dongle", label = "Dongle", stock = 10, price = 220, account = "cosmo", accountLabel = "Cosmo"},
            {name = "hacking_device", label = "Hacking Device", stock = 10, price = 400, account = "cosmo", accountLabel = "Cosmo"},
            {name = "transponder", label = "Transponder", stock = 10, price = 200, account = "cosmo", accountLabel = "Cosmo"},
            {name = "gopro", label = "GoPro Camera", stock = 10, price = 750, account = "cosmo", accountLabel = "Cosmo"},
            {name = "cam_jammer", label = "Camera Jammer", stock = 10, price = 750, account = "cosmo", accountLabel = "Cosmo"},
            {name = "hacking_usb", label = "Hacking Usb", stock = 10, price = 150, account = "cosmo", accountLabel = "Cosmo"},
            {name = "lockpick_set", label = "Lockpick Set", stock = 10, price = 170, account = "cosmo", accountLabel = "Cosmo"},
        }
    }, 
    ["drugs"] = { 
        label = "Drugs", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            if GetResourceState('av_gangs') ~= "started" then
                return false
            end
            local gang = exports['av_gangs']:getGang()
            if gang and gang['name'] then -- If is member of any gang can access
                return true
            end
            return false
        end,
        items = {
            {name = "ammonia", label = "Ammonia", category = "drugs", stock = 50, price = 20, account = "cosmo", accountLabel = "Cosmo"},
        }
    },
    ["weapons"] = { 
        label = "Weapons", -- category label, how the player will see it in laptop
        canAccess = function() -- do a client side check here, true/false if the player can access the category
            if exports['av_laptop']:getJob().name == "police" then
                return false
            end
            if GetResourceState('av_gangs') ~= "started" then
                return false
            end
            local gang = exports['av_gangs']:getGang()
            if gang and gang['name'] == "yakuza" then -- If is member of Ballas gang can access
                return true
            end
            return false
        end,
        items = {
            {name = "weapon_pistol", label = "Pistol", category = "weapons", stock = 5, price = 5000, account = "cosmo", accountLabel = "Cosmo"},
        }
    },
}