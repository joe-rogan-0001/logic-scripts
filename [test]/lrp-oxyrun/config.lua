Config = {}

-- General Settings

Config.MinimumPolice = 0
Config.CallCopsChance = 50 -- %Chance to alert police
Config.RunCost = 500

Config.EnableCooldown = true
Config.Cooldown = 1800 -- Seconds * Recommended to have some form of cooldown!

Config.SendEmail = true -- The E-Mail received upon taking on a job
Config.EnableAnimation = true -- Animation that plays upon talking to the boss
Config.Animation = "argue" -- Full list of emotes from dpEmotes can be found on the forum release page.

Config.PrintChance = true  -- This will print the chance numbers, when someone delivers a package into your server console.

-- Blip Creation

Config.UseBlip = false

Config.BlipLocation = {
	{title="Mysterious Person", colour=1, id=51, x = -1564.62, y = -441.77, z = 36.8}
} 

-- Blip Settings for Supplier/Routes

Config.OxySupplierColour = 11 -- This is the color or the marking that shows from your location to the location
Config.OxySupplierRoute = false -- true/false to turn of the route markings and only show blips

Config.OxyRouteColour = 11 -- This is the color or the marking that shows from your location to the location
Config.OxyRouteGPS = false -- true/false to turn of the route markings and only show blips

-- Ped Spawns

Config.BossPed = {
    `a_m_m_mlcrisis_01`,
}

Config.SupplierPeds = {
	`a_m_m_mlcrisis_01`,
}

Config.BossLocation = {
    vector4(-1563.99, -441.44, 36.89, 101.3)
}

Config.PickUpLocations = {
    vector4(608.79, -459.17, 24.74, 181.92),
    vector4(1250.83, -2562.04, 42.71, 219.28),
    vector4(740.43, -2634.68, 6.47, 189.84),
    vector4(-1161.83, -1250.07, 6.8, 306.16),
    vector4(-2223.13, -365.75, 13.32, 260.99),
    vector4(-2982.84, 1585.71, 23.82, 359.91),
    vector4(-287.47, 2535.68, 75.47, 271.17),
    vector4(1583.08, 3620.96, 38.78, 134.18)
}

-- Items

Config.GiveItem = true 
Config.ItemReward = "oxy"
Config.MaxItemReward = 3
Config.MinItemReward = 1

Config.SpecialRewardChance = 5
Config.SpecialItem = "greendongle"
Config.MaxSpecialReward = 1
Config.MinSpecialReward = 1

-- Money

Config.CleanMoney = true

Config.BagChance = 25 -- Marked Bills

Config.BandMaxPayout = 2000
Config.BandMinPayout = 750
Config.BandChance = 15 

Config.RollMaxPayout = 750
Config.RollMinPayout = 250
Config.RollChance = 20


-- NPC Route Spawn

Config.DriveStyle = 39 -- THIS CAN BE CHANGED AT https://www.vespura.com/fivem/drivingstyle/
Config.MaxDeliveries = 6
Config.MinDeliveries = 4 
Config.Cars = {"glendale", "ingot", "buccaneer2","bison", "sultan", "ellie"} 
Config.MaxTimeBetweenCars = 30 
Config.MinTimeBetweenCars = 15 
Config.DriverPed = "s_m_m_gentransport" 

Config.Routes = { -- HERE YOU CAN ADD AS MANY LOCATIONS AS YOU WANT TO

{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 1, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 121.76 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(-691.34, -1058.22, 14.5), stop = false }, -- SPAWN POINT
		{ pos = vector3(-742.16, -1047.58, 12.3), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(-745.23, -915.48, 19.34), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 2, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 143.49 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(283.46, -1827.16, 26.28), stop = false }, -- SPAWN POINT
		{ pos = vector3(247.41, -1785.75, 27.57), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(300.86, -1727.74, 28.95), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 3, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 51.05 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(-153.31, -1711.23, 29.87), stop = false }, -- SPAWN POINT
		{ pos = vector3(-118.38, -1610.66, 31.4), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(-51.5, -1601.91, 28.71), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 4, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 160.18 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(259.13, -125.32, 67.76), stop = false }, -- SPAWN POINT
		{ pos = vector3(220.58, -166.64, 56.64), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(73.81, -25.48, 68.59), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 5, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 140.1 -- HEADING OF CAR WHEN IT SPAWNS IN321.76
	},
	locations = {
		{ pos = vector3(265.99, -1410.26, 28.8), stop = false }, -- SPAWN POINT
		{ pos = vector3(198.16, -1463.84, 28.47), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(193.43, -1495.95, 28.47), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 6, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 322.35 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(119.78, -1837.57, 25.34), stop = false }, -- SPAWN POINT
		{ pos = vector3(166.54, -1823.75, 27.64), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(210.66, -1869.13, 25.96), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 7, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 70.51 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(307.84, 167.62, 103.2), stop = false }, -- SPAWN POINT
		{ pos = vector3(259.87, 120.16, 100.43), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(242.63, 37.32, 83.22), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 8, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 70.82 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(435.95, -133.12, 63.61), stop = false }, -- SPAWN POINT
		{ pos = vector3(464.54, -78.24, 72.12), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(528.74, -96.03, 64.43), stop = false }, -- DESPAWN POINT
	}
},
{
	info = {
		occupied = false,
		hash = "", -- DON'T TOUCH
		oxyNum = 1, -- DON'T TOUCH
		routeNum = 9, -- NEENDS TO BE SET TO THE ORDER IT COMES IN THE LIST
		startHeading = 115.34 -- HEADING OF CAR WHEN IT SPAWNS IN
	},
	locations = {
		{ pos = vector3(-1101.95, -913.09, 2.29), stop = false }, -- SPAWN POINT
		{ pos = vector3(-1158.18, -939.9, 1.89), stop = true }, -- WAIT FOR DELIVER
		{ pos = vector3(-1255.95, -982.26, 1.72), stop = false }, -- DESPAWN POINT
	}
}
}