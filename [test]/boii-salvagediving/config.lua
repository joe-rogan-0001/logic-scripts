-------------------------------
---------- CASE#2506 ----------
-------------------------------
Config = {}
Config.DivingZone1 = vector3(1726.83, -3034.76, -54.38) -- Diving location 1
Config.DivingZone2 = vector3(3171.64, -354.78, -25.58) -- Diving location 2
Config.DivingZone3 = vector3(-944.87, 6555.7, -30.97) -- Diving location 3
Config.DivingZone4 = vector3(3420.32, 6335.72, -62.15) -- Diving location 3
Config.CrateSearchTime = math.random(5500,9000) -- Time in (ms) to search supply and tobacco crates
Config.CrateSearchItem = 'weapon_crowbar' -- Item needed to search supply and tobacco crates, change this to whatever you want
Config.JewellerySearchTime = math.random(5500,9000) -- Time in (ms) to search crates
Config.JewellerySearchItem = 'lockpick' -- Item needed to search jewellery crates
Config.MedicalSearchTime = math.random(5500,9000) -- Time in (ms) to search crates
Config.MedicalSearchItem = 'medickeycard' -- Item needed to search medical crates
Config.AntiqueSearchTime = math.random(5500,9000) -- Time in (ms) to search antique boxes
Config.AntiqueSearchItem = 'advancedlockpick' -- Item needed to search antique boxes
Config.JewelleryBagOpenTime = math.random(3500,6000) -- Time in (ms) to search crates
Config.DocumentTubeOpenTime = math.random(3500,6000) -- Time in (ms) to search crates
Config.Blips = {
	{title="Diving Zone", colour=37, id=587, x = 1726.83, y = -3034.76, z = -54.38},
	{title="Diving Zone", colour=37, id=587, x = 3171.64, y = -354.78, z = -25.58},
	{title="Diving Zone", colour=37, id=587, x = -944.87, y = 6555.70, z = -30.97},
	{title="Diving Zone", colour=37, id=587, x = 3420.32, y = 6335.72, z = -62.15},
}
-- Shared items that could be in either the supply & tobacco crates **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.SharedItems = {
    -- QBCore items
    'metalscrap',
    'iron',
    'copper',
    'aluminum',
    'steel',
    'plastic',
    'rubber',
}
-- High roll items for supply crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.SupplyCrateReward = {
    -- QBCore items
    'lockpick',
    'bandage',
    'medickeycard', -- **THIS IS NEEDED FOR THE SCRIPT TO WORK CORRECTLY! INFORMATION IS IN THE README.MD**
}
-- High roll items for tobacco crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.TobaccoCrateReward = {
    -- QBCore items
    'cokebaggy',
    'crack_baggy',
    'meth',
    'weed_skunk',
    'weed_og-kush',
}
-- Regular roll items for medical crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.MedicalCrateItems = {
    -- QBCore items
    'kurkakola',
    'water_bottle',
    'tosti',
    'sandwich', 
    'bandage',
    'coffee',
    'vodka', 
}
-- High roll items for medical crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.MedicalCrateReward = {
    -- QBCore items
    'oxy',
    'firstaid',
    'ifaks',
}
-- Regular roll items for jewellery crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.JewelleryCrateItems = {
    -- QBCore items
    'goldchain',
    'rolex',  
}
-- High roll items for jewellery crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.JewelleryCrateReward = {
    -- QBCore items
    '10kgoldchain',
    'diamond',
    'diamond_ring',
}
-- Regular roll items for antique box crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.AntiqueBoxItems = {
    -- QBCore items
    'electronickit',
    -- CTRP items
    'jewellerybag', -- **THIS IS NEEDED FOR THE SCRIPT TO WORK CORRECTLY! INFORMATION IS IN THE README.MD**
}
-- High roll items for antique box crate **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.AntiqueBoxReward = {
    -- QBCore items
    'pistol_luxuryfinish',
    'ironoxide',
    'aluminumoxide',
    -- CTRP items
    'documenttube', -- **THIS IS NEEDED FOR THE SCRIPT TO WORK CORRECTLY! INFORMATION IS IN THE README.MD**
}
-- Regular roll items for jewellery bag **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.JewelleryBagItems = {
    -- QBCore items
    'diamond',
    'goldchain',
}
-- High roll items for jewellery bag **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.JewelleryBagReward ={
    -- QBCore items
    'diamond_ring',
    '10kgoldchain',
}
-- Regular roll items for document tube **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.DocumentTubeItems = {
    -- QBCore items
    'cryptostick',
    'lockpick',
    'electronickit',
    'ruineddocuments', -- **JUNK ITEM THIS IS NOT NEEDED FOR THE SCRIPT, YOU CAN REMOVE OR USE! INFORMATION IS IN THE README.MD**
    'inactivekeycard', -- **JUNK ITEM THIS IS NOT NEEDED FOR THE SCRIPT, YOU CAN REMOVE OR USE! INFORMATION IS IN THE README.MD**
}
-- High roll items for document tube **PLEASE MAKE SURE TO REMOVE ANY ITEMS NOT IN YOUR CITY**
Config.DocumentTubeReward = {
    -- QBCore items
    'microsmg_luxuryfinish',
    'smg_luxuryfinish',
    'combatpistol_luxuryfinish',
    'pistol_extendedclip',
    'combatpistol_extendedclip',
    'advancedlockpick',
    'trojan_usb',
}
Config.Lang = {
    -- Multiuse
    ['noinvent'] = 'Looks like your pockets are full..', -- Notification
    ['outrange'] = 'You are too far away move closer..', -- Notification
    ['emptycrate'] = 'Looks like this crate is empty..', -- Notification
    ['foundcrate'] = 'You found something inside the crate!', -- Notification
    ['foundcratereward'] = 'You found something interesting inside the crate!', -- Notification
    ['nocrowbar'] = 'You need a crowbar to break open this crate..', -- Notification
    ['brokelockpick'] = 'Your lockpick has broken..', -- Notification

    -- Supply crates    
    ['searchsupply'] = 'Searching Supply Crate..', -- Progress bar

    -- Tobacco crates
    ['searchtobacco'] = 'Searching Tobacco Crate..', -- Progress bar

    -- Jewellery crates
    ['nolockpick'] = 'You need a lockpick to open into this crate..', -- Notification
    ['searchjewellery'] = 'Searching Jewellery Crate..', -- Progress bar

    -- Medical crates
    ['hackfailed'] = 'Access denied, your key card has been destroyed..', -- Notification
    ['hacksuccess'] = 'Successfully hacked the medical crate!', -- Notification
    ['nomedickey'] = 'You dont have the key card to open this medical crate..',
    ['failedmedical'] = 'Failed to hack into the medical crate..', -- Notification
    ['searchmedical'] = 'Searching Medical Crate..', -- Progress bar

    -- Antique Box
    ['noadvlockpick'] = 'You need a advanced lockpick to open into this box..', -- Notification
    ['failedbox'] = 'You failed to open the box..', -- Notification
    ['searchantique'] = 'Searching Antique Box..', -- Progress bar

    -- Jewellery bag
    ['emptybag'] = 'Looks like this jewellery bag is empty..', -- Notification
    ['foundjewels'] = 'You found something inside the jewellery bag!', -- Notification
    ['openjewel'] = 'Opening Jewellery Bag..', -- Progress bar

    -- Document tube
    ['emptytube'] = 'Looks like this tube is empty..', -- Notification
    ['founddocs'] = 'You found something inside the document tube!', -- Notification
    ['founddocsreward'] = 'You found something interesting inside the document tube!', -- Notification
    ['opendoctube'] = 'Opening Document Tube..', -- Progress bar
}