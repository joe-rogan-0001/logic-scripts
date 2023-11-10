AOD = {}
Config = {}

AOD.HuntAnimals = {'a_c_deer', 'a_c_coyote', 'a_c_boar'}
AOD.SpawnDistanceRadius = math.random(40,50) --disance animal spawns from bait
AOD.HuntingZones = {'CMSW','CANNY','CCREAK'} --add valid zones here
AOD.SpawnChance = 1.0 -- 10 percent chance use values .01 - 1.0
AOD.DistanceFromBait = 25.0 -- distance from player to spawn bait
AOD.DistanceTooCloseToAnimal = 15.0
AOD.HuntingWeapon = `weapon_sniperrifle2` --set to nil for no requirement
AOD.HuntAnyWhere = false
AOD.UseBlip = true -- set to true for the animal to have a blip on the map
AOD.BlipText = 'Prey'

--Rewards for butchering animals
AOD.BoarMeat = math.random(1,3) -- amount of meat to receive from Boars
AOD.Boarskin = math.random(1,3)
AOD.DeerSkin = math.random(1,3)
AOD.DeerMeat = math.random(1,3)
AOD.CoyoteFur = math.random(1,3)
AOD.CoyoteMeat = math.random(1,3)

AOD.Strings = {
QBClient = 'QBCore:GetObject',
QBServer = 'QBCore:GetObject',
NotValidZone = 'Your bait would not take here',
ExploitDetected = 'You are trying to exploit, please do not do this',
DontSpam = 'You were charged one bait for spamming',
WaitToBait = 'You need to wait longer to place bait',
PlacingBait = 'Placing Bait',
BaitPlaced = 'Bait placed.. now time to wait',
Roadkill = 'Looks more like roadkill now',
NoAnimal = 'No Animal nearby',
NotDead = 'Animal not dead',
NotYours = 'Not your animal',
WTF = 'What are you doing?',
Harvest = 'Butchering animal',
Butchered = 'Animal butchered'
}

Config.payout = {
    boarskin = math.random(1750, 2500),
    deerskin = math.random(2000, 2750),
    coyotefur = math.random(2250, 3000),
}


Config.Zone = {
    coords = vector3(-1105.09, 4383.83, 12.8)
}