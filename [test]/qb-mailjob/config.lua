Config = {}

Config.MailJob = "mailcarrier"
Config.MailVehicle = GetHashKey("boxville") -- The mail truck vehicle to use.
Config.MailDeliveredReward = 10 -- This is the amount each carrier gets paid per mailbox visited.
                                -- This number gets multiplied by their carrier level's "payMultiplier."
                                -- For level 1 carrier, they get 1x, etc.

Config.MailBoxModels = {
    "prop_letterbox_01",
    "prop_letterbox_02",
    "prop_letterbox_03",
    "prop_letterbox_04",
}

Config.MailJobLocations = {
    startBlip = vector3(78.83, 111.94, 81.17),
    menuPoint = vector3(78.78, 112.03, 81.17),
    truckSpawns = {
        vector4(90.64, 103.61, 79.02, 249.8),
        vector4(105.68, 97.91, 79.99, 250.3),
        vector4(122.38, 91.34, 81.39, 247.2),
        vector4(60.45, 123.92, 79.12, 160.6),
        vector4(67.40, 113.92, 79.00, 245.6),
    },
}

Config.MailJobProgression = {
    [1] = {
        name = "New Carrier",
        payMultiplier = 1, -- 
        deliveriesRequired = 0,
    },
    [2] = {
        name = "Novice Carrier",
        payMultiplier = 1.25,
        deliveriesRequired = 75,
    },
    [3] = {
        name = "Experienced Carrier",
        payMultiplier = 1.5,
        deliveriesRequired = 200,
    },
    [4] = {
        name = "Well-known Carrier",
        payMultiplier = 1.75,
        deliveriesRequired = 500,
    },
    [5] = {
        name = "Veteran Carrier",
        payMultiplier = 2,
        deliveriesRequired = 1000,
    },
    [6] = {
        name = "Expert Carrier",
        payMultiplier = 2.5,
        deliveriesRequired = 1500,
    },
    [7] = {
        name = "Elite Carrier",
        payMultiplier = 3,
        deliveriesRequired = 3000,
    },
}

Config.MailRoutes = {
    [1] = { -- This route goes from south end of Mirror Park to north end, turns right onto east mirror drive and comes all the way around.
        type = "delivery", -- The type of route. This is a delivery route, not a collection route.
        routeLevels = { -- Which progression levels are given this route
            1, 2, 3, 4, 5, 6, 7
        },
        mailboxes = {
            vector3(1217.13, -741.13, 58.58),
            vector3(1212.13, -698.49, 60.11),
            vector3(1208.62, -681.40, 60.79),
            vector3(1198.58, -630.06, 62.86),
            vector3(1192.87, -603.05, 63.93),
            vector3(1191.13, -586.63, 64.21),
            vector3(1189.20, -560.57, 64.48),
            vector3(1269.90, -428.03, 69.09),
            vector3(1274.23, -464.37, 69.09),
            vector3(1263.35, -497.37, 69.09),
            vector3(1256.57, -520.79, 69.09),
            vector3(1296.82, -537.89, 70.54),
            vector3(1324.52, -545.77, 72.46),
            vector3(1346.57, -555.36, 74.17),
            vector3(1371.02, -561.20, 74.43),
            vector3(1383.76, -573.15, 74.43),
            vector3(1380.51, -590.76, 74.34),
            vector3(1365.84, -597.95, 74.43),
            vector3(1329.97, -574.38, 73.65),
            vector3(1302.72, -564.58, 71.43),
            vector3(1250.67, -566.10, 69.11),
            vector3(1255.00, -598.34, 69.01),
            vector3(1260.98, -614.38, 68.95),
            vector3(1274.10, -636.05, 68.57),
            vector3(1282.32, -679.39, 65.86),
            vector3(1271.82, -704.70, 64.73),
        },
    },
    [2] = { -- This route follows West Mirror Drive from south end to north end.
        type = "delivery",
        routeLevels = {
            1, 2, 3, 4, 5, 6, 7
        },
        mailboxes = {
            vector3(1008.59, -733.44, 57.71),
            vector3(985.85, -712.22, 58.02),
            vector3(973.54, -681.70, 57.42),
            vector3(961.54, -658.00, 57.48),
            vector3(957.48, -652.73, 57.55),
            vector3(972.37, -631.69, 57.47),
            vector3(934.16, -625.59, 57.52),
            vector3(919.47, -615.03, 57.55),
            vector3(894.56, -596.66, 57.43),
            vector3(868.54, -577.99, 57.47),
            vector3(859.35, -561.58, 57.34),
            vector3(858.88, -532.27, 57.33),
            vector3(866.88, -518.32, 57.33),
            vector3(879.10, -508.07, 57.33),
            vector3(907.51, -496.61, 58.59),
            vector3(923.92, -515.53, 58.94),
            vector3(924.65, -488.93, 59.57),
            vector3(941.11, -507.90, 59.95),
            vector3(949.97, -474.73, 61.25),
            vector3(975.77, -457.99, 62.75),
            vector3(1014.86, -459.06, 64.15),
            vector3(999.40, -440.74, 64.08),
            vector3(1016.19, -427.92, 65.05),
            vector3(1031.23, -415.57, 65.91),
            vector3(1067.67, -384.92, 67.24),
        },
    },
    [3] = { -- East Hollywood Hills
        type = "delivery",
        routeLevels = {
            3, 4, 5, 6, 7
        },
        mailboxes = {
            vector3(-1493.16, 515.46, 117.61),
            vector3(-1469.03, 518.68, 117.88),
            vector3(-1441.21, 533.93, 119.92),
            vector3(-1426.47, 526.92, 118.78),
            vector3(-1355.21, 572.85, 131.00),
            vector3(-1352.39, 603.79, 133.73),
            vector3(-1297.28, 627.98, 137.97),
            vector3(-1289.67, 640.17, 138.49),
            vector3(-1239.26, 663.72, 142.49),
            vector3(-1231.66, 657.47, 142.84),
            vector3(-1197.17, 696.14, 147.58),
            vector3(-1157.33, 750.90, 155.26),
            vector3(-1122.26, 773.40, 161.69),
            vector3(-1031.03, 794.04, 168.88),
            vector3(-1048.39, 763.79, 167.35),
            vector3(-1001.55, 703.74, 159.94),
            vector3(-889.54, 703.62, 150.13),
            vector3(-757.60, 657.97, 142.96),
            vector3(-733.14, 595.14, 141.79),
            vector3(-687.03, 664.68, 151.79),
            vector3(-609.77, 680.34, 149.34),
            vector3(-565.20, 682.72, 146.20),
            vector3(-491.99, 656.65, 142.15),
            vector3(-431.16, 675.72, 154.30),
            vector3(-353.43, 664.93, 169.15),
            vector3(-357.36, 654.56, 169.53),
        },
    },
}

GetCarrierLevelFromPackageCount = function(packageCount)
    local level = 0
    local levelData = nil
    for k,v in ipairs(Config.MailJobProgression) do
        if packageCount >= v.deliveriesRequired then
            level = k
            levelData = v
        end
    end
    return level, levelData
end