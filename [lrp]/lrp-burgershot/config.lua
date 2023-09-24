Config = {}

--[[Config.GaragePedLocations = {
    {coords = vector4(-1178.588, -891.9196, 13.799622, 302.58825)},
}]]

Config.SQL = 'oxmysql' --- oxmysql or ghmattisql

Config.Eye = "true" -- If you are using the QB Target then change this to true. IF FALSE it will show 3D text

 Config.Locations = { -- You will need to add your own locations I added duty and pattys for testing
     ["duty"] = {
         [1] = vector4(-1191.2, -900.4, 13.98, 121.0),
     },    
     ["tray1"] = {
         [1] = vector4(-1196.56, -891.74, 13.98, 302.48),
     },
     ["tray2"] = {
         [1] = vector4(-1195.49, -893.26, 13.98, 296.29),
     },
     ["tray3"] = {
        [1] = vector4(-1194.48, -894.73, 13.98, 295.43),
     },  
     ["pattycooker"] = {
         [1] = vector4(-1202.05, -897.28, 13.98, 115.52),
         [2] = vector4(-1202.63, -896.4, 13.98, 139.26),
     }, 
    ["fryer"] = {
         [1] = vector4(-1201.14, -898.65, 13.98, 115.42),
     }, 
    ["drinks"] = {
        [1] = vector4(-1199.05, -895.52, 13.98, 117.61),
        [2] = vector4(-1199.72, -894.55, 13.98, 108.03),
     },   
    ["fridge"] = {
       [1] = vector4(-1196.62, -901.36, 13.98, 211.57),
    },      
    ["storage"] = {
         [1] = vector4(-1204.62, -893.87, 13.98, 120.26),
   },
     ["craftburger"] = {
        [1] = vector4(-1201.01, -896.72, 13.98, 304.56),
     },    
    ["cashregister"] = {
         [1] = vector4(-1194.93, -893.3, 15.1, 217.23),
        [2] = vector4(0 , 0 , 0, 0),
         [3] = vector4(0 , 0 , 0, 0),
        [4] = vector4(0 , 0 , 0, 0),
     },   
     ["garage"] = {
         [1] = vector4(0 , 0 , 0, 0),
     }, 
}


Config.Items = {
label = "Shop",
    slots = 7,
    items = {
        [1] = {
            name = "burger-bun",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "burger-raw",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "burger-tomato",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 3,
        },
        [4] = {
            name = "burger-lettuce",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 4,
        },
        [5] = {
            name = "burger-potato",
            price = 0,
            amount = 2,
            info = {},
            type = "item",
            slot = 5,
        },
        [6] = {
            name = "burger-mshakeformula",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
        },
        [7] = {
            name = "burger-sodasyrup",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 7,
        },
    }
}
