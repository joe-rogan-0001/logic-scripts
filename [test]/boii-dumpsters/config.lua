-------------------------------
---------- CASE#2506 ----------
-------------------------------

Config = {}
-- Core info
Config.Core = 'QBCore' -- The name of your core. Default; QBCore
Config.CoreFolder = 'lrp-core' -- The name of your core folder. Default; qb-core
Config.TargetName = 'lrp-target' -- The name of your third eye targeting. Default; qb-target
-- Dumpster props
Config.DumpsterProp = { "prop_dumpster_01a" } -- Dumpster prop 1 
Config.DumpsterProp2 = { "prop_dumpster_02a" } -- Dumpster prop 2 
Config.DumpsterProp3 = { "prop_dumpster_02b" } -- Dumpster prop 3 
Config.DumpsterProp4 = { "prop_dumpster_3a" } -- Dumpster prop 4 
Config.DumpsterProp5 = { "prop_dumpster_4a" } -- Dumpster prop 5 
Config.DumpsterProp6 = { "prop_dumpster_4b" } -- Dumpster prop 6 
-- Bins props
Config.BinProp = { "prop_bin_08a" } -- Bin prop 1 
Config.BinProp2 = { "prop_bin_07c" } -- Bin prop 2
Config.BinProp3 = { "prop_bin_05a" } -- Bin prop 3
Config.BinProp4 = { "prop_bin_01a" } -- Bin prop 4
Config.BinProp5 = { "prop_bin_06a" } -- Bin prop 5
Config.BinProp6 = { "prop_bin_07b" } -- Bin prop 6
Config.BinProp7 = { "prop_bin_07a" } -- Bin prop 7
Config.BinProp8 = { "prop_bin_02a" } -- Bin prop 8
Config.BinProp9 = { "prop_bin_03a" } -- Bin prop 9
Config.BinProp10 = { "prop_bin_04a" } -- Bin prop 10
Config.BinProp11 = { "prop_bin_08open" } -- Bin prop 11
-- Timers
Config.Cooldown = 2880000 -- Time is in (ms) * 1000 client side so 2880000 (ms) = 48 mins or roughly 1 gta day
Config.DumpsterSearchTime = math.random(5500,8500) --Time in (ms) to search dumpsters
Config.BinSearchTime = math.random(3500,5500) --Time in (ms) to search bins
-- Items awarded with a low roll (more common)
Config.TrashItems = {
--<!>-- ADD LOW ROLL ITEMS HERE, SOME HAVE BEEN FILLED FOR YOU AS AN EXAMPLE --<!>--
	'water_bottle',
	'coffee',
	'sandwich',
	'phone',
}
-- Items awarded with high roll (less common)
Config.TrashRewardItem = {
--<!>-- ADD HIGH ROLL ITEMS HERE, SOME HAVE BEEN FILLED FOR YOU AS AN EXAMPLE --<!>--
	--'pistol_ammo',
	'lockpick',
	--'trojan_usb',
	--'goldbar',
	--'2step-kit',
}
-- Notifications, targeting, and progressbar text
Config.Lang = {
	-- General
	['noinvent'] = 'Looks like your pockets are full..', -- Notification text when you have no inventory space (may trigger if item does not exist also)
	['alreadysearched'] = 'You have already searched this location..', -- Notification text when you try to search a location twice
	['searchfailed'] = 'You found nothing of interest..', -- Notification text when you do not find anything 

	-- Dumpsters
	['searchdumpster'] = 'Search Through Dumpster', -- Targeting text this is what you read when you look at a dumpster with third-eye
	['searchingdumpster'] = 'Searching Through Dumpster..', -- Progressbar when searching a dumpster
	
	-- Bins
	['searchbin'] = 'Search Through Bin', -- Targeting text this is what you read when you look at a bin with third-eye
	['searchingbin'] = 'Searching Through Bin..', -- Progressbar text when searching a bin
}
