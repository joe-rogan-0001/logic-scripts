Config = {}
Config.UsingTarget = false -- If you are using qb-target (uses entity zones to target vehicles)
Config.Commission = 0.10 -- Percent that goes to sales person from a full car sale 10%
Config.FinanceCommission = 0.05 -- Percent that goes to sales person from a finance sale 5%
Config.FinanceZone = vector3(-586.02, -2362.65, 13.82) -- Where the finance menu is located
Config.PaymentWarning = 10 -- time in minutes that player has to make payment before repo
Config.PaymentInterval = 24 -- time in hours between payment being due
Config.MinimumDown = 10 -- minimum percentage allowed down
Config.MaximumPayments = 24 -- maximum payments allowed
Config.Shops = {
    ['police'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {     
            ['Shape'] = { --polygon that surrounds the shop
            vector3(454.24, -1027.6, 28.51),
            vector3(455.7, -1007.8, 29.4),
            vector3(466.13, -1012.96, 28.08),
            vector3(466.13, -1021.21, 28.09),
            },
            ['minZ'] = 0.0,  -- min height of the shop zone
            ['maxZ'] = 28.0  -- max height of the shop zone
        },
        ['Job'] = 'police', -- Name of job or none
        ['ShopLabel'] = 'Job dealership', -- Blip name
        ['showBlip'] = false,  --- true or false
        ['Categories'] = { -- Categories available to browse
            ['policecars'] = 'policecars'
        },          
        ['TestDriveTimeLimit'] = 0.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-602.8, -2334.27, 13.83), -- Blip Location
        ['VehicleSpawn'] = vector4(452.82, -1019.23, 29.25, 91.84), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {         
                coords = vector4(462.98, -1016.99, 20.09, 178.08), -- where the vehicle will spawn on display
                maxZ = 30.63,
                defaultVehicle = 'polvic', -- Default display vehicle
                chosenVehicle = 'polvic', -- Same as default but is dynamically changed when swapping vehicles
            },
        },
    },

    ['ems'] = {
        ['Type'] = 'free-use',  -- no player interaction is required to purchase a car
        ['Zone'] = {     
            ['Shape'] = { --polygon that surrounds the shop
            vector3(313.38, -545.53, 28.88),
            vector3(323.19, -545.56, 28.74),
            vector3(323.12, -536.29, 28.89),
            vector3(313.52, -536.37, 28.89),
            },
            ['minZ'] = 0.0,  -- min height of the shop zone
            ['maxZ'] = 28.0  -- max height of the shop zone
        },
        ['Job'] = 'ambulance', -- Name of job or none
        ['ShopLabel'] = 'Job and Gang dealership', -- Blip name
        ['showBlip'] = false,  --- true or false
        ['Categories'] = { -- Categories available to browse
            ['emscar'] = 'emscar'
        },
        ['TestDriveTimeLimit'] = 0.5, -- Time in minutes until the vehicle gets deleted
        ['Location'] = vector3(-602.8, -2334.27, 13.83), -- Blip Location
        ['VehicleSpawn'] = vector4(322.17, -546.62, 28.74, 269.14), -- Spawn location when vehicle is bought
        ['ShowroomVehicles'] = {
            [1] = {
                coords = vector4(317.36, -540.72, 22.86, 264.74), -- where the vehicle will spawn on display
                maxZ = 30.63,
                defaultVehicle = 'emsa', -- Default display vehicle
                chosenVehicle = 'emsa', -- Same as default but is dynamically changed when swapping vehicles
            },
            
        },
    },
}


