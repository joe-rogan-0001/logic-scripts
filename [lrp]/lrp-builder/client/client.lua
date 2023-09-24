local QBCore = exports['lrp-core']:GetCoreObject()

local PlayerData = {}
local Level = 1
local Login = false
local Done = 0
local Payout = 0
local haspackage = false
local packnumber = 0
local anim = false
local jobPed = nil
local createdPed = false


exports['lrp-target']:AddTargetModel(`cs_floyd`, {
    options = {
        {
            event = "inside-builder:startJob",
            icon = "fas fa-sign-in-alt",
            label = "Sign In Builder Job",
        },
        {
            event = "inside-builder:stopJob",
            icon = "fas fa-sign-out-alt",
            label = "Sign Off Builder Job",
        },
    },
    distance = 10.0
})

function CreateJobPed(hash,x,y,z,h)
	local ped_hash = GetHashKey(hash)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end
	jobPed = CreatePed(1, ped_hash, x,y,z-1, h, false, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetPedDiesWhenInjured(jobPed, false)
	SetPedCanPlayAmbientAnims(jobPed, true)
	SetPedCanRagdollFromPlayerImpact(jobPed, false)
	SetEntityInvincible(jobPed, true)
	PlaceObjectOnGroundProperly(jobPed)
	FreezeEntityPosition(jobPed, true)
	createdPed = true
	return jobPed
end

function DeleteJobPed(ped)
	SetBlockingOfNonTemporaryEvents(ped, false)
	SetPedDiesWhenInjured(ped, true)
	SetEntityInvincible(ped, false)
	FreezeEntityPosition(ped, false)
	DeletePed(ped)
	createdPed = false
end

Citizen.CreateThread(function()
	StartJobBlip = AddBlipForCoord(Config.builder['BossSpawn'].Pos.x, Config.builder['BossSpawn'].Pos.y, Config.builder['BossSpawn'].Pos.z)
	SetBlipSprite (StartJobBlip, 408)
	SetBlipDisplay(StartJobBlip, 4)
	SetBlipScale  (StartJobBlip, 0.8)
	SetBlipColour (StartJobBlip, 0)
	SetBlipAsShortRange(StartJobBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Builder Work')
	EndTextCommandSetBlipName(StartJobBlip)
end)

RegisterNetEvent("inside-builder:startJob", function()
    if not JobStarted and not IsPedInAnyVehicle(PlayerPedId(), false) then  
		QBCore.Functions.Progressbar("signingin_job", "You're signing in the job...", 2500, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			disableInventory = true,
		})
		Citizen.Wait(2500)
		JobStarted = true
		JobStart()
		
    else
		QBCore.Functions.Notify("You are already on duty!","error", 3000)
    end
end)

RegisterNetEvent("inside-builder:stopJob", function()
    if JobStarted and not IsPedInAnyVehicle(PlayerPedId(), false) then
        QBCore.Functions.Progressbar("signingoff_job", "You're signing off the job...", 2500, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
			disableInventory = true,
		})
		Citizen.Wait(2500)
		QBCore.Functions.Notify("Thanks for the help", "info")
		JobStarted = false
		DeletePed(BossPlaceNPC)	
		for i, v in ipairs(Config.Places1lvl[Place].Places) do
			v.Done = false
			RemoveBlip(v.blip)
		end
		Done = 0
		RemoveBlip(BossPlaceBlip)
		packnumber = 0
		DeleteEntity(Pallete)
		doneWork = false
		haspackage = false
		DeleteEntity(pack)
		QBCore.Functions.DeleteVehicle(Vehicle)
		RemoveBlip(PackagesBlip)
		RemoveBlip(ConstructionBlip)
        QBCore.Functions.Notify("You signed off!","success", 3000)
    else
        QBCore.Functions.Notify("You are already off!","error", 3000)
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if(GetDistanceBetweenCoords(coords,Config.builder['BossSpawn'].Pos.x, Config.builder['BossSpawn'].Pos.y, Config.builder['BossSpawn'].Pos.z, true) < 50.0) then
			if not createdPed then
				CreateJobPed(Config.builder['BossSpawn'].Type,Config.builder['BossSpawn'].Pos.x,Config.builder['BossSpawn'].Pos.y,Config.builder['BossSpawn'].Pos.z,Config.builder['BossSpawn'].Pos.h)
			end
		else
			DeleteJobPed(jobPed)
		end
		Citizen.Wait(2500)
	end
end)

function CreateBlipsWork()
	for i, v in ipairs(Config.Places1lvl[Place].Places) do
		v.blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)		
		SetBlipSprite (v.blip, 1)
		SetBlipDisplay(v.blip, 4)
		SetBlipScale  (v.blip, 0.8)
		SetBlipColour (v.blip, 0)
		SetBlipAsShortRange(v.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Workplace')
		EndTextCommandSetBlipName(v.blip)
	end
end

function JobStart()
	Place = math.random(1, #Config.Places1lvl)
	QBCore.Functions.Notify("Go to the place where the construction boss is waiting for you", "info")
	-- exports['lrp-notify']:Alert("Construction", "Go to the place where the construction boss is waiting for you", 3500, 'info')
	local ped_hash = GetHashKey(Config.Places1lvl[Place].Type)
	RequestModel(ped_hash)
	while not HasModelLoaded(ped_hash) do
		Citizen.Wait(1)
	end	
	BossPlaceNPC = CreatePed(1, ped_hash, Config.Places1lvl[Place].Pos.x, Config.Places1lvl[Place].Pos.y, Config.Places1lvl[Place].Pos.z-1, Config.Places1lvl[Place].Pos.h, false, true)
	SetBlockingOfNonTemporaryEvents(BossPlaceNPC, true)
	SetPedDiesWhenInjured(BossPlaceNPC, false)
	SetPedCanPlayAmbientAnims(BossPlaceNPC, true)
	SetPedCanRagdollFromPlayerImpact(BossPlaceNPC, false)
	SetEntityInvincible(BossPlaceNPC, true)
	FreezeEntityPosition(BossPlaceNPC, true)


	BossPlaceBlip = AddBlipForCoord(Config.Places1lvl[Place].Pos.x, Config.Places1lvl[Place].Pos.y, Config.Places1lvl[Place].Pos.z)		
	SetBlipSprite (BossPlaceBlip, 525)
	SetBlipDisplay(BossPlaceBlip, 4)
	SetBlipScale  (BossPlaceBlip, 0.8)
	SetBlipColour (BossPlaceBlip, 0)
	SetBlipAsShortRange(BossPlaceBlip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Construction boss')
	EndTextCommandSetBlipName(BossPlaceBlip)

	

	Citizen.CreateThread(function()
		while true do
			local sleep = 100
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			if(GetDistanceBetweenCoords(coords,Config.Places1lvl[Place].Pos.x, Config.Places1lvl[Place].Pos.y, Config.Places1lvl[Place].Pos.z, true) < 9.0) then	
				sleep = 5
				DrawMarker(25, Config.Places1lvl[Place].Pos.x, Config.Places1lvl[Place].Pos.y, Config.Places1lvl[Place].Pos.z-0.99, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
				if(GetDistanceBetweenCoords(coords,Config.Places1lvl[Place].Pos.x, Config.Places1lvl[Place].Pos.y, Config.Places1lvl[Place].Pos.z, true) < 1.5) then
					DrawText3Ds(Config.Places1lvl[Place].Pos.x, Config.Places1lvl[Place].Pos.y, Config.Places1lvl[Place].Pos.z+1.15, 'Hello, you have to help me with a few things.', 45)
					DrawText3Ds(Config.Places1lvl[Place].Pos.x, Config.Places1lvl[Place].Pos.y, Config.Places1lvl[Place].Pos.z+1.0, 'To start work, press [~g~G~w~]', 26)
					if(IsControlJustReleased(0, Keys['G']) and not IsPedInAnyVehicle(ped, false)) then
						RemoveBlip(BossPlaceBlip)
						CreateBlipsWork()
						QBCore.Functions.Notify("Go to the designated places and do the work", "info")
						-- exports['lrp-notify']:Alert("Construction", "Go to the designated places and do the work", 3500, 'info')
						while true do 
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							Citizen.Wait(4)
							for i, v in ipairs(Config.Places1lvl[Place].Places) do
								if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 6.0) and not v.Done then
									DrawMarker(20, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 69, 255, 66, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 1.5) and not v.Done then
										DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z+1, 'To start work, press [~g~E~w~]', 30)
										if(IsControlJustReleased(0, Keys['E']) and not IsPedInAnyVehicle(ped, false)) then
											SetEntityCoords(ped, v.Pos.x, v.Pos.y, v.Pos.z-0.99)
											SetEntityHeading(ped, v.Pos.h)

											if v.Tool == 'hammer' then
												hammer = CreateObject(GetHashKey('prop_tool_hammer'),coords.x, coords.y,coords.z, true, true, true)
												AttachEntityToEntity(hammer, ped, GetPedBoneIndex(ped, 28422), 0.0, 0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)

												startAnim(ped, 'amb@world_human_hammering@male@base', 'base')
											elseif v.Tool == 'pneumatic hammer' then
												Phammer = CreateObject(GetHashKey('prop_tool_jackham'),coords.x, coords.y,coords.z, true, true, true)
												AttachEntityToEntity(Phammer, ped, GetPedBoneIndex(ped, 28422), 0.0, 0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
												
												startAnim(ped, 'amb@world_human_const_drill@male@drill@base', 'base')
											elseif v.Tool == 'drill' then
												Drill = CreateObject(GetHashKey('prop_tool_drill'),coords.x, coords.y,coords.z, true, true, true)
												AttachEntityToEntity(Drill, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.07, 0.0, 0.0, 0.0, 90.0, 1, 1, 0, 0, 2, 1)
													
												startAnim(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle')
												RequestAmbientAudioBank("DLC_HEIST_FLEECA_SOUNDSET", 0)
												RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL", 0)
												RequestAmbientAudioBank("DLC_MPHEIST\\HEIST_FLEECA_DRILL_2", 0)
												drillSound = GetSoundId()													
												PlaySoundFromEntity(drillSound, "Drill", Drill, "DLC_HEIST_FLEECA_SOUNDSET", 1, 0)											
											elseif v.Tool == 'weld' then
												weld = CreateObject(GetHashKey('prop_weld_torch'),coords.x, coords.y,coords.z, true, true, true)
												AttachEntityToEntity(weld, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
												
												startAnim(ped, 'amb@world_human_welding@male@base', 'base')												
											end
											QBCore.Functions.Progressbar("working", "You are working...", 2500, false, true, {
												disableMovement = true,
												disableCarMovement = true,
												disableMouse = false,
												disableCombat = true,
												disableInventory = true,
											})
											Citizen.Wait(v.WorkingTime)
											if v.Tool == 'hammer' then
												DeleteEntity(hammer)
											elseif v.Tool == 'pneumatic hammer' then
												DeleteEntity(Phammer)
											elseif v.Tool == 'drill' then
												DeleteEntity(Drill)
												StopSound(drillSound)	
											elseif v.Tool == 'weld' then			
												DeleteEntity(weld)
											end							
											ClearPedTasks(ped)
											v.Done = true
											RemoveBlip(v.blip)
											Done = Done + 1	
											QBCore.Functions.Notify("You did the job ["..Done.."/"..#Config.Places1lvl[Place].Places.."]", "info")
											-- exports['lrp-notify']:Alert("Construction", "You did the job ["..Done.."/"..#Config.Places1lvl[Place].Places.."]", 3500, 'success')
										end
									end
								end
							end
							if Done == #Config.Places1lvl[Place].Places then
								for i, v in ipairs(Config.Places1lvl[Place].Places) do
									v.Done = false
								end
								Done = 0
								Payout = Payout + Config.Places1lvl[Place].Payout
								TriggerServerEvent('inside-builder:Payout', Payout)
								QBCore.Functions.Notify('You have earned '..Payout..'$', "info")
								-- exports['lrp-notify']:Alert("Construction", 'You have earned '..Payout..'$', 3500, 'success')
								Payout = 0
								DeletePed(BossPlaceNPC)
								break
							end
						end
						Citizen.CreateThread(function()
							Citizen.Wait(4000)
							JobStart()
						end)
						break
					end
				end
			end
			Citizen.Wait(sleep)
			if not JobStarted then
				break 
			end
		end
	end)
end

function startAnim(ped, dictionary, anim)
	Citizen.CreateThread(function()
	  RequestAnimDict(dictionary)
	  while not HasAnimDictLoaded(dictionary) do
		Citizen.Wait(0)
	  end
		TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)

		RequestAnimDict(dictionary)
		while not HasAnimDictLoaded(dictionary) do
		  Citizen.Wait(0)
		end
		  TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)

		  RequestAnimDict(dictionary)
		  while not HasAnimDictLoaded(dictionary) do
			Citizen.Wait(0)
		  end
			TaskPlayAnim(ped, dictionary, anim ,8.0, -8.0, -1, 50, 0, false, false, false)
	end)
end

Citizen.CreateThread(function()
	local doo = 0
	while true do
		sleep = 500
		if anim then
			sleep = 0
			RequestAnimDict('anim@heists@box_carry@')
			while not HasAnimDictLoaded('anim@heists@box_carry@') do
			  Citizen.Wait(0)
			end
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle' ,8.0, -8.0, -1, 49, 0, false, false, false)
			doo = doo + 1 
			if doo >= 3 then
				doo = 0
				anim = false
			end
		end			
		Citizen.Wait(sleep)
	end
end)

function DrawText3Ds(x, y, z, text, shadow)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = shadow / 370
	if shadow ~= 0 then		
   		DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
	end
    ClearDrawOrigin()
end
