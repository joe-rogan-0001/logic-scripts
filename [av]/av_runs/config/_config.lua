-- PLEASE READ THE DOCS BEFORE USING THIS SCRIPT
-- PLEASE READ THE DOCS BEFORE USING THIS SCRIPT
-- https://docs.av-scripts.com/laptop-pack/av-drug-runs
-- https://docs.av-scripts.com/laptop-pack/av-drug-runs
-- https://docs.av-scripts.com/laptop-pack/av-drug-runs

Config = {}
Config.Debug = false -- It will do some prints client/server side to help me fix possible errors
Config.PrintCoords = true -- It will print the current NPC coords in server console
Config.Framework = "QBCore" -- Available options "QBCore" / "ESX", for custom Framework u need to modify everything from framework folders
Config.TargetSystem = "qtarget" -- "qtarget", "qb-target" ... for ox_target leave it as "qtarget"
Config.HackingDevice = "hacking_device" -- Same item frm av_boosting :)
Config.DrugPackageItem = "drug_package" -- Item received during mission
Config.PoliceJobs = { -- Used for function isCop() and ESX checks for online cops
    ['police'] = true,
    ['sheriff'] = true,
}
Config.Inventory = "ox_inventory" -- available options: "ox_inventory" "qb-inventory" "lj-inventory" and "ps-inventory"
Config.DefaultVehicles = {`burrito2`, `burrito3`, `youga`, `youga2`} -- Vehicles spawned at each zone with the drug box inside trunk
Config.ShowPackageStrain = true -- Show the strain from illegal package on hover?
Config.RemoveReputation = true -- Every time someone sells a package from X drug, all the strains reputation from that specific drug will be reduced by 1
Config.Drugs = {
    ['meth_batch'] = { -- item name
        minCops = 0, -- min cops online
        vehicle = {`schafter5`, `cognoscenti2`, `xls2`, `kuruma2`}, -- Vehicle used for runs, it will pick one random model from table
        moneyAccount = "cash", -- The account name to receive the reward
        cooldown = 90, -- In minutes, time before other players can do the mission again / this value CAN'T be lower than timeLimit
        timeLimit = 60, --Max time for mission, after this time it will be canceled and all guards/vehicles wiped
        minQty = 20, -- min bags u need to deposit to start the job
        maxQty = 30, -- The amount of slots the stash will have to prevent people from puting more bags
        stashWeight = 100000, -- Make sure it has enough space for 30 bags (100kg)
        strainField = "strain", -- How the strain field is named in your item metadata (for av_meth is strain)
        basePrice = 5000, -- Price per bag
        zones = {min = 3, max = 6}, -- How many packages will be generated (every package means 1 zone with goons)
        deliveryReputation = math.random(2,3), -- Reputation the strain will receive for every delivered package
        reputationMoney = { -- Table or false. -- if this is false it won't give any money
        -- Depending on the strain reputation the payment will be multiplied (basePrice * bags provided) * reputationMultiplier
            {min = 0, max = 9, multiplier = 1.1},
            {min = 10, max = 19, multiplier = 1.5},
            {min = 20, max = 29, multiplier = 2.0},
            {min = 30, max = 39, multiplier = 2.4},
            {min = 40, max = 49, multiplier = 2.8},
            {min = 50, max = 59, multiplier = 3.3},
            {min = 60, max = 69, multiplier = 3.8},
            {min = 70, max = 79, multiplier = 4.5},
            {min = 80, max = 89, multiplier = 5.0},
            {min = 90, max = 100, multiplier = 6.0},
        },
        canInteract = function()
            -- Here you can do some extra check to prevent cops from using this PED, or limit the interaction to only gang members (?)
            if isCop() then return false end
            return true
        end
    }
}