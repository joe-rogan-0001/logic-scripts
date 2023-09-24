local QBCore = exports['lrp-core']:GetCoreObject()


local PlayerData = {}
local JobStarted = false
local Helicopter = false
local Plate
local Vehicle
local wheel_l = false
local wheel_r = false
local wheel_ll = false
local wheel_rrr = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
	if (Config.jobrequirement and (PlayerData.job ~= nil and PlayerData.job.name == Config.jobname)) then
		CreateBossBlip(true)
	elseif not Config.jobrequirement then
		CreateBossBlip(true)
	end
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function()
	PlayerData.job = QBCore.Functions.GetPlayerData().job
	if (Config.jobrequirement and (PlayerData.job ~= nil and PlayerData.job.name == Config.jobname)) then
		CreateBossBlip(true)
	elseif not Config.jobrequirement then
		CreateBossBlip(true)
	else 
		CreateBossBlip(false)
	end
end)

--------------------------------------------------------------------------------

function CreateBossBlip(type)
	if type then
		RemoveBlip(StartJobBlip)
		StartJobBlip = AddBlipForCoord(Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z)
		
		SetBlipSprite (StartJobBlip, 408)
		SetBlipDisplay(StartJobBlip, 4)
		SetBlipScale  (StartJobBlip, 0.8)
		SetBlipColour (StartJobBlip, 0)
		SetBlipAsShortRange(StartJobBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Air Transport')
		EndTextCommandSetBlipName(StartJobBlip)
	else
		RemoveBlip(StartJobBlip)
	end
end

Citizen.CreateThread(function()
	if not Config.jobrequirement then
		CreateBossBlip(true)
	end
	local ped_hash = GetHashKey(Config.airtransportation['BossSpawn'].Type)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossNPC = CreatePed(1, ped_hash, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, Config.airtransportation['BossSpawn'].Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(BossNPC, true)
	SetPedDiesWhenInjured(BossNPC, false)
	SetPedCanPlayAmbientAnims(BossNPC, true)
	SetPedCanRagdollFromPlayerImpact(BossNPC, false)
	SetEntityInvincible(BossNPC, true)
	FreezeEntityPosition(BossNPC, true)
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
			if not Config.jobrequirement then
				if(GetDistanceBetweenCoords(coords,Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z, true) < 9.0) then	
					sleep = 5
					if(GetDistanceBetweenCoords(coords,Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z, true) < 1.5) then	
						if not JobStarted then
							DrawText3Ds(Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z+1.0, 'To start work, press [~g~E~w~]')
							DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
						else
							DrawText3Ds(Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z+1.0, 'To finish work, press [~r~E~w~]')
							DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 133, 0, 0, 100, false, true, 2, false, false, false, false)
						end
						if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not JobStarted then
							--[[
							exports.rprogress:Custom({
								Duration = 2500,
								Label = "Changing wear...",
								Animation = {
									scenario = "WORLD_HUMAN_COP_IDLES", -- https://pastebin.com/6mrYTdQv
									animationDictionary = "idle_a", -- https://alexguirre.github.io/animations-list/
								},
								DisableControls = {
									Mouse = false,
									Player = true,
									Vehicle = true
								}
							})
							]]--
							Citizen.Wait(2500)
							local PlayerData = QBCore.Functions.GetPlayerData()
							--[[
							if PlayerData.charinfo.gender == 0 then 
								SetPedComponentVariation(ped, 3, Config.Clothes.male['arms'], 0, 0) --arms
								SetPedComponentVariation(ped, 8, Config.Clothes.male['tshirt_1'], Config.Clothes.male['tshirt_2'], 0) --t-shirt
								SetPedComponentVariation(ped, 11, Config.Clothes.male['torso_1'], Config.Clothes.male['torso_2'], 0) --torso2
								SetPedComponentVariation(ped, 9, Config.Clothes.male['bproof_1'], Config.Clothes.male['bproof_2'], 0) --vest
								SetPedComponentVariation(ped, 10, Config.Clothes.male['decals_1'], Config.Clothes.male['decals_2'], 0) --decals
								SetPedComponentVariation(ped, 7, Config.Clothes.male['chain_1'], Config.Clothes.male['chain_2'], 0) --accessory
								SetPedComponentVariation(ped, 4, Config.Clothes.male['pants_1'], Config.Clothes.male['pants_2'], 0) -- pants
								SetPedComponentVariation(ped, 6, Config.Clothes.male['shoes_1'], Config.Clothes.male['shoes_2'], 0) --shoes
								SetPedPropIndex(ped, 0, Config.Clothes.male['helmet_1'], Config.Clothes.male['helmet_2'], true) --hat
								SetPedPropIndex(ped, 2, Config.Clothes.male['ears_1'], Config.Clothes.male['ears_2'], true) --ear
							else
								SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
								SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) --t-shirt
								SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0) --torso2
								SetPedComponentVariation(ped, 9, Config.Clothes.female['bproof_1'], Config.Clothes.female['bproof_2'], 0) --vest
								SetPedComponentVariation(ped, 10, Config.Clothes.female['decals_1'], Config.Clothes.female['decals_2'], 0) --decals
								SetPedComponentVariation(ped, 7, Config.Clothes.female['chain_1'], Config.Clothes.female['chain_2'], 0) --accessory
								SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0) -- pants
								SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0) --shoes
								SetPedPropIndex(ped, 0, Config.Clothes.female['helmet_1'], Config.Clothes.female['helmet_2'], true) --hat
								SetPedPropIndex(ped, 2, Config.Clothes.female['ears_1'], Config.Clothes.female['ears_2'], true) --ear
							end			

							exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>Go to pick up the helicopter", timeout = 4500})	
							]]--
							exports['lrp-notify']:Alert("Boss", "Go to pick up the helicopter", 2000)
							JobStarted = true	
							HelipadsBlip()
						elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and JobStarted then
							--[[
							exports.rprogress:Custom({
								Duration = 2500,
								Label = "Changing wear...",
								Animation = {
									scenario = "WORLD_HUMAN_COP_IDLES", -- https://pastebin.com/6mrYTdQv
									animationDictionary = "idle_a", -- https://alexguirre.github.io/animations-list/
								},
								DisableControls = {
									Mouse = false,
									Player = true,
									Vehicle = true
								}
							})
							]]--
							Citizen.Wait(2500)
							TriggerServerEvent("qb-clothes:loadPlayerSkin")
							--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>Thanks for the help", timeout = 4500})
							exports['lrp-notify']:Alert("Boss", "Thanks for the help", 2000)
							JobStarted = false
							Helicopter = false
							for i, v in pairs(Config.airtransportation['Helipad']) do
								RemoveBlip(v.blip)
							end
							QBCore.Functions.DeleteVehicle(Vehicle)	
							Vehicle = nil		
							Plate = nil
							active = false
							Place = nil
							QBCore.Functions.DeleteVehicle(VehicleToTake)	
							PlateVehicle = nil
							VehicleToTake = nil
							VehicleTakeBlipF(false)
							RemoveBlip(VehicleTakeBlip2)
							RemoveBlip(DestinationBlip)	
							FlatBedSpawned = false
						end
					else
						DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					end
				end
			elseif (Config.jobrequirement and (PlayerData.job ~= nil and PlayerData.job.name == Config.jobname)) then
				if(GetDistanceBetweenCoords(coords,Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z, true) < 9.0) then	
					sleep = 5
					if(GetDistanceBetweenCoords(coords,Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z, true) < 1.5) then	
						if not JobStarted then
							DrawText3Ds(Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z+1.0, 'To start work, press [~g~E~w~]')
							DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
						else
							DrawText3Ds(Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z+1.0, 'To finish work, press [~r~E~w~]')
							DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 133, 0, 0, 100, false, true, 2, false, false, false, false)
						end
						if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and not JobStarted then
							--[[
							exports.rprogress:Custom({
								Duration = 2500,
								Label = "Changing wear...",
								Animation = {
									scenario = "WORLD_HUMAN_COP_IDLES", -- https://pastebin.com/6mrYTdQv
									animationDictionary = "idle_a", -- https://alexguirre.github.io/animations-list/
								},
								DisableControls = {
									Mouse = false,
									Player = true,
									Vehicle = true
								}
							})
							]]--
							Citizen.Wait(2500)
							local PlayerData = QBCore.Functions.GetPlayerData()
							if PlayerData.charinfo.gender == 0 then 
								SetPedComponentVariation(ped, 3, Config.Clothes.male['arms'], 0, 0) --arms
								SetPedComponentVariation(ped, 8, Config.Clothes.male['tshirt_1'], Config.Clothes.male['tshirt_2'], 0) --t-shirt
								SetPedComponentVariation(ped, 11, Config.Clothes.male['torso_1'], Config.Clothes.male['torso_2'], 0) --torso2
								SetPedComponentVariation(ped, 9, Config.Clothes.male['bproof_1'], Config.Clothes.male['bproof_2'], 0) --vest
								SetPedComponentVariation(ped, 10, Config.Clothes.male['decals_1'], Config.Clothes.male['decals_2'], 0) --decals
								SetPedComponentVariation(ped, 7, Config.Clothes.male['chain_1'], Config.Clothes.male['chain_2'], 0) --accessory
								SetPedComponentVariation(ped, 4, Config.Clothes.male['pants_1'], Config.Clothes.male['pants_2'], 0) -- pants
								SetPedComponentVariation(ped, 6, Config.Clothes.male['shoes_1'], Config.Clothes.male['shoes_2'], 0) --shoes
								SetPedPropIndex(ped, 0, Config.Clothes.male['helmet_1'], Config.Clothes.male['helmet_2'], true) --hat
								SetPedPropIndex(ped, 2, Config.Clothes.male['ears_1'], Config.Clothes.male['ears_2'], true) --ear
							else
								SetPedComponentVariation(ped, 3, Config.Clothes.female['arms'], 0, 0) --arms
								SetPedComponentVariation(ped, 8, Config.Clothes.female['tshirt_1'], Config.Clothes.female['tshirt_2'], 0) --t-shirt
								SetPedComponentVariation(ped, 11, Config.Clothes.female['torso_1'], Config.Clothes.female['torso_2'], 0) --torso2
								SetPedComponentVariation(ped, 9, Config.Clothes.female['bproof_1'], Config.Clothes.female['bproof_2'], 0) --vest
								SetPedComponentVariation(ped, 10, Config.Clothes.female['decals_1'], Config.Clothes.female['decals_2'], 0) --decals
								SetPedComponentVariation(ped, 7, Config.Clothes.female['chain_1'], Config.Clothes.female['chain_2'], 0) --accessory
								SetPedComponentVariation(ped, 4, Config.Clothes.female['pants_1'], Config.Clothes.female['pants_2'], 0) -- pants
								SetPedComponentVariation(ped, 6, Config.Clothes.female['shoes_1'], Config.Clothes.female['shoes_2'], 0) --shoes
								SetPedPropIndex(ped, 0, Config.Clothes.female['helmet_1'], Config.Clothes.female['helmet_2'], true) --hat
								SetPedPropIndex(ped, 2, Config.Clothes.female['ears_1'], Config.Clothes.female['ears_2'], true) --ear
							end	

							--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>Go to pick up the helicopter", timeout = 4500})	
							exports['lrp-notify']:Alert("Boss", "Go to pick up the helicopter", 2000)
							JobStarted = true	
							HelipadsBlip()
						elseif IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) and JobStarted then
							--[[
							exports.rprogress:Custom({
								Duration = 2500,
								Label = "Changing wear...",
								Animation = {
									scenario = "WORLD_HUMAN_COP_IDLES", -- https://pastebin.com/6mrYTdQv
									animationDictionary = "idle_a", -- https://alexguirre.github.io/animations-list/
								},
								DisableControls = {
									Mouse = false,
									Player = true,
									Vehicle = true
								}
							})
							]]--
							Citizen.Wait(2500)
							TriggerServerEvent("qb-clothes:loadPlayerSkin")
							--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>Thanks for the help", timeout = 4500})
							exports['lrp-notify']:Alert("Boss", "Thanks for the help", 2000)
							JobStarted = false
							Helicopter = false
							for i, v in pairs(Config.airtransportation['Helipad']) do
								RemoveBlip(v.blip)
							end
							QBCore.Functions.DeleteVehicle(Vehicle)	
							Vehicle = nil		
							Plate = nil
							active = false
							Place = nil
							QBCore.Functions.DeleteVehicle(VehicleToTake)	
							PlateVehicle = nil
							VehicleToTake = nil	
							VehicleTakeBlipF(false)
							RemoveBlip(VehicleTakeBlip2)	
							RemoveBlip(DestinationBlip)		
							PlateFlat = nil 
							FlatBedSpawned = false				
						end
					else
						DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					end
				end
			else
				if(GetDistanceBetweenCoords(coords,Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z, true) < 9.0) then	
					sleep = 5
					if(GetDistanceBetweenCoords(coords,Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z, true) < 1.5) then	
						DrawText3Ds(Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z+1.0, 'You are not employed as ~r~'..Config.jobname)
						DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
					else
						DrawMarker(25, Config.airtransportation['BossSpawn'].Pos.x, Config.airtransportation['BossSpawn'].Pos.y, Config.airtransportation['BossSpawn'].Pos.z-1, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					end
				end
			end
		Citizen.Wait(sleep)
	end
end)

function HelipadsBlip()
	for i, v in pairs(Config.airtransportation['Helipad']) do
		v.blip = AddBlipForCoord(v.x, v.y, v.z)
  
		SetBlipSprite (v.blip, 43)
		SetBlipDisplay(v.blip, 4)
		SetBlipScale  (v.blip, 0.8)
		SetBlipColour (v.blip, 0)
		SetBlipAsShortRange(v.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Helipad')
		EndTextCommandSetBlipName(v.blip)
	end
end

Citizen.CreateThread(function ()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
			if JobStarted then
				for i, v in pairs(Config.airtransportation['Helipad']) do
					if(GetDistanceBetweenCoords(coords,v.x, v.y, v.z, true) < 9.0) then
						sleep = 5
						if(GetDistanceBetweenCoords(coords,v.x, v.y, v.z, true) < 1.5) then	
							if not Helicopter then
								DrawText3Ds(v.x, v.y, v.z, 'To get the helicopter out, press [~g~E~w~]')
							else
								DrawText3Ds(v.x, v.y, v.z, 'To hide the helicopter, press [~r~G~w~]')
							end
							DrawMarker(25, v.x, v.y, v.z-1.42, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
							DrawMarker(34, v.x, v.y, v.z-0.7, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
							if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
								if IsSpawnPointClear(vector3(v.x, v.y, v.z), 2) then	
									QBCore.Functions.SpawnVehicle(v.model, function(vehicle)
										active = false
										--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>Go to your destination", timeout = 4500})
										exports['lrp-notify']:Alert("Boss", "Go to your destination", 2000)
										SetVehicleNumberPlateText(vehicle, "BOB"..tostring(math.random(1000, 9999)))
										SetEntityHeading(vehicle, v.h)								
										TaskWarpPedIntoVehicle(ped, vehicle, -1)
										SetVehicleEngineOn(vehicle, true, true)
										Plate = GetVehicleNumberPlateText(vehicle)									
										Vehicle = vehicle
										Helicopter = true
										for i, v in pairs(Config.airtransportation['Helipad']) do
											RemoveBlip(v.blip)
										end

										Place = Randomize(Config.HelicopterRandomize)
										VehicleTakeBlipF(true)										
									end, vector3(v.x, v.y, v.z))
								else
									--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>Landing site is occupied", timeout = 4500})
									exports['lrp-notify']:Alert("Boss", "Landing site is occupied", 2000)
								end
							elseif IsControlJustReleased(0, Keys['G']) and IsPedInAnyVehicle(ped, false) then
								local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
								if GetVehicleNumberPlateText(vehicle) == Plate then	
									--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>You returned the helicopter", timeout = 4500})
									exports['lrp-notify']:Alert("Boss", "You returned the helicopter", 2000)
									QBCore.Functions.DeleteVehicle(Vehicle)				
									Helicopter = false
									Vehicle = nil		
									Plate = nil
									HelipadsBlip()
									Place = nil

									active = false
									RemoveBlip(VehicleTakeBlip2)
									PlateVehicle = nil
									VehicleToTake = nil
									RemoveBlip(FlatBedBlip)
									FlatBed = nil
									QBCore.Functions.DeleteVehicle(Vehicle)    
									QBCore.Functions.DeleteVehicle(FlatBed)    
									QBCore.Functions.DeleteVehicle(VehicleToTake)    
									wheel_l = false
									wheel_r = false
									wheel_ll = false
									wheel_rrr = false
									Helicopter = false									

									QBCore.Functions.DeleteVehicle(VehicleToTake)	
									PlateVehicle = nil
									VehicleToTake = nil
									VehicleTakeBlipF(false)
									RemoveBlip(VehicleTakeBlip2)
									RemoveBlip(DestinationBlip)	
									PlateFlat = nil 
									FlatBedSpawned = false

								else
									--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>This is not our helicopter", timeout = 4500})	
									exports['lrp-notify']:Alert("Boss", "This is not our helicopter", 2000)
								end
							end
						else
							DrawMarker(25, v.x, v.y, v.z-1.42, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.0, 2.0, 2.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
							DrawMarker(34, v.x, v.y, v.z-0.7, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
						end
					end
				end
			end
		Citizen.Wait(sleep)
	end
end)

--##############################

function IsSpawnPointClear(coords, radius)
	local vehicles = GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

function GetVehicles()
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

function GetClosestVehicle(coords)
	local vehicles        = GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end

	return closestVehicle, closestDistance
end

function GetVehiclesInArea(coords, area)
	local vehicles       = GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = GetDistanceBetweenCoords(vehicleCoords, coords.x, coords.y, coords.z, true)

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end
	end

	return vehiclesInArea
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end

		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next, id = moveFunc(iter)
		until not next

		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

--##############################

function VehicleTakeBlipF(type)
	if type then
		RemoveBlip(VehicleTakeBlip)
		VehicleTakeBlip = AddBlipForCoord(Config.HelicopterPlaces[Place.name].Pos.x, Config.HelicopterPlaces[Place.name].Pos.y, Config.HelicopterPlaces[Place.name].Pos.z)
	
		SetBlipSprite (VehicleTakeBlip, 225)
		SetBlipDisplay(VehicleTakeBlip, 4)
		SetBlipScale  (VehicleTakeBlip, 0.8)
		SetBlipColour (VehicleTakeBlip, 0)
		SetBlipAsShortRange(VehicleTakeBlip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Vehicle to be picked up')
		EndTextCommandSetBlipName(VehicleTakeBlip)	
	else
		RemoveBlip(VehicleTakeBlip)
	end
end

Citizen.CreateThread(function ()
	while true do
		local sleep = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if not active then
			if Helicopter and Place then
				sleep = 5
				if(GetDistanceBetweenCoords(coords,Config.HelicopterPlaces[Place.name].Pos.x, Config.HelicopterPlaces[Place.name].Pos.y, Config.HelicopterPlaces[Place.name].Pos.z, false) < 150.0) then	
					active = true
					QBCore.Functions.SpawnVehicle(Config.HelicopterPlaces[Place.name].Type, function(vehicle)
						VehicleTakeBlipF(false)


						doCarDamage(vehicle)
						VehicleTakeBlip2 = AddBlipForEntity(vehicle)
						SetVehicleDoorsLocked(vehicle, 2)
						SetBlipSprite (VehicleTakeBlip2, 1)
						SetBlipDisplay(VehicleTakeBlip2, 4)
						SetBlipScale  (VehicleTakeBlip2, 0.8)
						SetBlipColour (VehicleTakeBlip2, 0)
						SetBlipAsShortRange(VehicleTakeBlip2, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString('Vehicle')
						EndTextCommandSetBlipName(VehicleTakeBlip2)

						SetEntityHeading(vehicle, Config.HelicopterPlaces[Place.name].Pos.h)
						SetEntityAsMissionEntity(vehicle, true, true)
						TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))

						--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>To extend the hook from the helicopter, press [E]", timeout = 4500})	
						exports['lrp-notify']:Alert("Boss", "To extend the hook from the helicopter, press [E]", 2000)
						SetVehicleNumberPlateText(vehicle, "TAK"..tostring(math.random(1000, 9999)))
						PlateVehicle = GetVehicleNumberPlateText(vehicle)									
						VehicleToTake = vehicle	


						FlatBedBlip = AddBlipForCoord(Config.HelicopterPlaces[Place.name].PosDrop.x, Config.HelicopterPlaces[Place.name].PosDrop.y, Config.HelicopterPlaces[Place.name].PosDrop.z)
						SetBlipSprite (FlatBedBlip, 68)
						SetBlipDisplay(FlatBedBlip, 4)
						SetBlipScale  (FlatBedBlip, 0.8)
						SetBlipColour (FlatBedBlip, 0)
						SetBlipAsShortRange(FlatBedBlip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString('FlatBed')
						EndTextCommandSetBlipName(FlatBedBlip)

						while true do
							local sleep = 500
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							if(GetDistanceBetweenCoords(coords,Config.HelicopterPlaces[Place.name].PosDrop.x, Config.HelicopterPlaces[Place.name].PosDrop.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 100.0) then

								
								if not FlatBedSpawned then 
									QBCore.Functions.SpawnVehicle('flatbed', function(vehicle)
										RemoveBlip(FlatBedBlip)
										FreezeEntityPosition(vehicle, true)
										SetVehicleDoorsLocked(vehicle, 2)
										SetEntityHeading(vehicle, Config.HelicopterPlaces[Place.name].PosDrop.h)
										SetEntityAsMissionEntity(vehicle, true, true)
										TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))
										FlatBed = vehicle
										SetVehicleNumberPlateText(vehicle, "FLA"..tostring(math.random(1000, 9999)))
										PlateFlat = GetVehicleNumberPlateText(vehicle)		
									end, vector3(Config.HelicopterPlaces[Place.name].PosDrop.x, Config.HelicopterPlaces[Place.name].PosDrop.y, Config.HelicopterPlaces[Place.name].PosDrop.z))
									FlatBedSpawned = true
								end

								sleep = 5
								DrawMarker(25, Config.HelicopterPlaces[Place.name].PosDrop.x, Config.HelicopterPlaces[Place.name].PosDrop.y, Config.HelicopterPlaces[Place.name].PosDrop.z-0.9, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 12.0, 12.0, 12.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								DrawMarker(36, Config.HelicopterPlaces[Place.name].PosDrop.x, Config.HelicopterPlaces[Place.name].PosDrop.y, Config.HelicopterPlaces[Place.name].PosDrop.z+1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 3.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
								local coords2 = GetEntityCoords(VehicleToTake)
								if(GetDistanceBetweenCoords(coords2,Config.HelicopterPlaces[Place.name].PosDrop.x, Config.HelicopterPlaces[Place.name].PosDrop.y, Config.HelicopterPlaces[Place.name].PosDrop.z, true) < 9.0 and (coords2.z < Config.HelicopterPlaces[Place.name].PosDrop.z+3)) then
									--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>You delivered the vehicle"})
									exports['lrp-notify']:Alert("Boss", "You delivered the vehicle", 2000)
									AttachEntityToEntity(VehicleToTake, FlatBed, GetEntityBoneIndexByName(FlatBed, 'boot'), 0.0, -2.5, 0.80, 0.0, 0.0, 0.0, true, true, true, true, 1, true)
									-- AttachEntityToEntity(VehicleToTake, FlatBed, GetEntityBoneIndexByName(FlatBed, 'bodyshell'), 0.0, -1.5 + -0.85, 0.0 + 1.15, 0, 0, 0, 1, 1, 0, 1, 0, 1)

									--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>We now need to attach the vehicle to the tow truck", timeout = 4500})
									exports['lrp-notify']:Alert("Boss", "We now need to attach the vehicle to the tow truck", 2000)
									Citizen.Wait(2000)									

									SetEntityCoords(ped, Config.HelicopterPlaces[Place.name].PosToTeleportPlayer.x, Config.HelicopterPlaces[Place.name].PosToTeleportPlayer.y, Config.HelicopterPlaces[Place.name].PosToTeleportPlayer.z-1)
									SetEntityHeading(ped, Config.HelicopterPlaces[Place.name].PosToTeleportPlayer.h)
									QBCore.Functions.DeleteVehicle(Vehicle)							

									
					
									wheel_lf = GetWorldPositionOfEntityBone(VehicleToTake, GetEntityBoneIndexByName(VehicleToTake, 'wheel_lf'))
									wheel_rf = GetWorldPositionOfEntityBone(VehicleToTake, GetEntityBoneIndexByName(VehicleToTake, 'wheel_rf'))
									wheel_lr = GetWorldPositionOfEntityBone(VehicleToTake, GetEntityBoneIndexByName(VehicleToTake, 'wheel_lr'))
									wheel_rr = GetWorldPositionOfEntityBone(VehicleToTake, GetEntityBoneIndexByName(VehicleToTake, 'wheel_rr'))

									
					
									while true do
										local sleep = 5
										local ped = PlayerPedId()
										local coords = GetEntityCoords(ped)
										if(GetDistanceBetweenCoords(coords,wheel_lf.x, wheel_lf.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 2.0) and not wheel_l then
											DrawMarker(25, wheel_lf.x, wheel_lf.y, Config.HelicopterPlaces[Place.name].PosDrop.z-1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
											if(GetDistanceBetweenCoords(coords,wheel_lf.x, wheel_lf.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 1.5) then
												DrawText3Ds(wheel_lf.x, wheel_lf.y, Config.HelicopterPlaces[Place.name].PosDrop.z+1.0, 'To secure the wheel, press [~g~E~w~]')
												if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
													startAnim(ped, 'mini@repair', 'fixing_a_ped')
													--[[
													exports.rprogress:Custom({
														Duration = 3000,
														Label = "Securing the vehicle...",
														Animation = {
															scenario = "", -- https://pastebin.com/6mrYTdQv
															animationDictionary = "", -- https://alexguirre.github.io/animations-list/
														},
														DisableControls = {
															Mouse = false,
															Player = true,
															Vehicle = true
														}
													})
													]]--
													Citizen.Wait(3000)
													ClearPedTasks(ped)
													--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>You have secured the front of the vehicle", timeout = 1500})
													exports['lrp-notify']:Alert("Boss", "You have secured the front of the vehicle", 2000)
													wheel_l = true 
												end
											end
										elseif(GetDistanceBetweenCoords(coords,wheel_rf.x, wheel_rf.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 2.0) and not wheel_r then
											DrawMarker(25, wheel_rf.x, wheel_rf.y, Config.HelicopterPlaces[Place.name].PosDrop.z-1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
											if(GetDistanceBetweenCoords(coords,wheel_rf.x, wheel_rf.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 1.5) then
												DrawText3Ds(wheel_rf.x, wheel_rf.y, Config.HelicopterPlaces[Place.name].PosDrop.z+1.0, 'To secure the wheel, press [~g~E~w~]')
												if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
													startAnim(ped, 'mini@repair', 'fixing_a_ped')
													--[[
													exports.rprogress:Custom({
														Duration = 3000,
														Label = "Securing the vehicle...",
														Animation = {
															scenario = "", -- https://pastebin.com/6mrYTdQv
															animationDictionary = "", -- https://alexguirre.github.io/animations-list/
														},
														DisableControls = {
															Mouse = false,
															Player = true,
															Vehicle = true
														}
													})
													]]--
													Citizen.Wait(3000)
													ClearPedTasks(ped)
													--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>You have secured the front of the vehicle", timeout = 1500})
													exports['lrp-notify']:Alert("Boss", "You have secured the front of the vehicle", 2000)
													wheel_r = true
												end
											end
										elseif(GetDistanceBetweenCoords(coords,wheel_lr.x, wheel_lr.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 2.0) and not wheel_ll then
											DrawMarker(25, wheel_lr.x, wheel_lr.y, Config.HelicopterPlaces[Place.name].PosDrop.z-1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
											if(GetDistanceBetweenCoords(coords,wheel_lr.x, wheel_lr.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 1.5) then
												DrawText3Ds(wheel_lr.x, wheel_lr.y, Config.HelicopterPlaces[Place.name].PosDrop.z+1.0, 'To secure the wheel, press [~g~E~w~]')
												if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
													startAnim(ped, 'mini@repair', 'fixing_a_ped')
													--[[
													exports.rprogress:Custom({
														Duration = 3000,
														Label = "Securing the vehicle...",
														Animation = {
															scenario = "", -- https://pastebin.com/6mrYTdQv
															animationDictionary = "", -- https://alexguirre.github.io/animations-list/
														},
														DisableControls = {
															Mouse = false,
															Player = true,
															Vehicle = true
														}
													})
													]]--
													Citizen.Wait(3000)
													ClearPedTasks(ped)
													--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>You have secured the rear of the vehicle", timeout = 1500})
													exports['lrp-notify']:Alert("Boss", "You have secured the rear of the vehicle", 2000)
													wheel_ll = true
												end
											end
										elseif(GetDistanceBetweenCoords(coords,wheel_rr.x, wheel_rr.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 2.0) and not wheel_rrr then
											DrawMarker(25, wheel_rr.x, wheel_rr.y, Config.HelicopterPlaces[Place.name].PosDrop.z-1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
											if(GetDistanceBetweenCoords(coords,wheel_rr.x, wheel_rr.y, Config.HelicopterPlaces[Place.name].PosDrop.z, false) < 1.5) then
												DrawText3Ds(wheel_rr.x, wheel_rr.y, Config.HelicopterPlaces[Place.name].PosDrop.z+1.0, 'To secure the wheel, press [~g~E~w~]')
												if IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false) then
													startAnim(ped, 'mini@repair', 'fixing_a_ped')
													--[[
													exports.rprogress:Custom({
														Duration = 3000,
														Label = "Securing the vehicle...",
														Animation = {
															scenario = "", -- https://pastebin.com/6mrYTdQv
															animationDictionary = "", -- https://alexguirre.github.io/animations-list/
														},
														DisableControls = {
															Mouse = false,
															Player = true,
															Vehicle = true
														}
													})
													]]--
													Citizen.Wait(3000)
													ClearPedTasks(ped)
													--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>You have secured the rear of the vehicle", timeout = 1500})
													exports['lrp-notify']:Alert("Boss", "You have secured the rear of the vehicle", 2000)
													wheel_rrr = true
												end
											end
										elseif wheel_l and wheel_r and wheel_ll and wheel_rrr then
											Citizen.Wait(2500)
											--exports.pNotify:SendNotification({text = "<b>Airport Manager</b></br>You have secured the vehicle, go to your destination", timeout = 4500})
											exports['lrp-notify']:Alert("Boss", ">You have secured the vehicle, go to your destination", 2000)
											Destination2 = Randomize(Config.HelicopterRandomize)
											FreezeEntityPosition(FlatBed, false)
											SetVehicleDoorsLocked(FlatBed, 1)

											DestinationBlip = AddBlipForCoord(Config.Destination[Destination2.name].Pos.x, Config.Destination[Destination2.name].Pos.y, Config.Destination[Destination2.name].Pos.z)
											SetBlipSprite (DestinationBlip, 289)
											SetBlipDisplay(DestinationBlip, 4)
											SetBlipScale  (DestinationBlip, 0.8)
											SetBlipColour (DestinationBlip, 0)
											SetBlipAsShortRange(DestinationBlip, true)
											BeginTextCommandSetBlipName("STRING")
											AddTextComponentString('Vehicle unloading')
											EndTextCommandSetBlipName(DestinationBlip)	

											while true do
												local ped = PlayerPedId()
												local coords = GetEntityCoords(ped)
												if(GetDistanceBetweenCoords(coords,Config.Destination[Destination2.name].Pos.x, Config.Destination[Destination2.name].Pos.y, Config.Destination[Destination2.name].Pos.z, false) < 10.0) then
													DrawMarker(25, Config.Destination[Destination2.name].Pos.x, Config.Destination[Destination2.name].Pos.y, Config.Destination[Destination2.name].Pos.z-1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 2.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
													if(GetDistanceBetweenCoords(coords,Config.Destination[Destination2.name].Pos.x, Config.Destination[Destination2.name].Pos.y, Config.Destination[Destination2.name].Pos.z, false) < 1.5) then
														DrawText3Ds(Config.Destination[Destination2.name].Pos.x, Config.Destination[Destination2.name].Pos.y, Config.Destination[Destination2.name].Pos.z+1.0, 'To return the vehicle, press [~g~E~w~]')
														if IsControlJustReleased(0, Keys['E']) and IsPedInAnyVehicle(ped, false) then
															local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
															if GetVehicleNumberPlateText(vehicle) == PlateFlat then
																QBCore.Functions.TriggerCallback('inside-helicopter:payout', function(money)
																	--exports.pNotify:SendNotification({text = '<b>Airport Manager</b></br>You have earned '..money..'$', timeout = 4500})
																	exports['lrp-notify']:Alert("Boss", 'You have earned '..money..'$', 2000)
																end)																
																Helicopter = false
																active = false
																RemoveBlip(VehicleTakeBlip2)
																PlateVehicle = nil
																RemoveBlip(FlatBedBlip)
																QBCore.Functions.DeleteVehicle(FlatBed)    
																QBCore.Functions.DeleteVehicle(Vehicle)     
																QBCore.Functions.DeleteVehicle(VehicleToTake) 
																FlatBed = nil
																Vehicle = nil  
																VehicleToTake = nil 
																wheel_l = false
																wheel_r = false
																wheel_ll = false
																wheel_rrr = false
																Helicopter = false
																Place = nil
																PlateFlat = nil 
																FlatBedSpawned = false
																RemoveBlip(DestinationBlip)																
																HelipadsBlip()
																break
															end
														end
													end
												end
												Citizen.Wait(5)
											end
											break
										end
										Citizen.Wait(sleep)
									end
									break
								end
							end
						Citizen.Wait(sleep)
						end
					end, vector3(Config.HelicopterPlaces[Place.name].Pos.x, Config.HelicopterPlaces[Place.name].Pos.y, Config.HelicopterPlaces[Place.name].Pos.z))
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end


function doCarDamage(currentVehicle)
	smash = false
	damageOutside = false
	damageOutside2 = false 
	local engine = 199.0
	local body = 149.0
	if engine < 200.0 then
		engine = 200.0
    end
    
    if engine  > 1000.0 then
        engine = 950.0
    end

	if body < 150.0 then
		body = 150.0
	end
	if body < 950.0 then
		smash = true
	end

	if body < 920.0 then
		damageOutside = true
	end

	if body < 920.0 then
		damageOutside2 = true
	end

    Citizen.Wait(100)
    SetVehicleEngineHealth(currentVehicle, engine)
	if smash then
		SmashVehicleWindow(currentVehicle, 0)
		SmashVehicleWindow(currentVehicle, 1)
		SmashVehicleWindow(currentVehicle, 2)
		SmashVehicleWindow(currentVehicle, 3)
		SmashVehicleWindow(currentVehicle, 4)
	end
	if damageOutside then
		SetVehicleDoorBroken(currentVehicle, 1, true)
		SetVehicleDoorBroken(currentVehicle, 6, true)
		SetVehicleDoorBroken(currentVehicle, 4, true)
	end
	if damageOutside2 then
		SetVehicleTyreBurst(currentVehicle, 1, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 2, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 3, false, 990.0)
		SetVehicleTyreBurst(currentVehicle, 4, false, 990.0)
	end
	if body < 1000 then
		SetVehicleBodyHealth(currentVehicle, 985.1)
	end
end

function Randomize(tb)
	local keys = {}
	for k in pairs(tb) do table.insert(keys, k) end
	return tb[keys[math.random(#keys)]]
end

function DrawText3Ds(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
