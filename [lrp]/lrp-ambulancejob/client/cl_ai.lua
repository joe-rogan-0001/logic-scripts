local Active = false
local test = nil
local test1 = nil
local spam = true
local mechVeh = nil
local mechPed = nil
local PlayerJob = {}
local onDuty = false

-- Commands

RegisterNetEvent('qb-medical:client:requestai', function()
	if (QBCore.Functions.GetPlayerData().metadata["isdead"]) or (QBCore.Functions.GetPlayerData().metadata["inlaststand"]) and spam then
		QBCore.Functions.TriggerCallback('qb-medical:docOnline', function(EMSOnline)
			if EMSOnline <= Config.MinimalEMS and spam then
				SpawnVehicle(GetEntityCoords(PlayerPedId()))
				Notify("Local Medic is being dispatch to your location")
			else
				if EMSOnline > Config.MinimalEMS then
					Notify("There is too many medics online")
				else
					Notify("Wait Paramadic is on its Way")
				end
			end
		end)
	else
		Notify("This can only be used when dead", "error")
	end
end)

-- Threads

CreateThread(function()
    while true do
      Wait(200)
        if Active then
            local loc = GetEntityCoords(GetPlayerPed(-1))
			local lc = GetEntityCoords(mechVeh)
			local ld = GetEntityCoords(mechPed)
            local dist = Vdist(loc.x, loc.y, loc.z, lc.x, lc.y, lc.z)
			local dist1 = Vdist(loc.x, loc.y, loc.z, ld.x, ld.y, ld.z)
            if dist <= 10 then
				if Active then
					TaskGoToCoordAnyMeans(mechPed, loc.x, loc.y, loc.z, 1.0, 0, 0, 786603, 0xbf800000)
				end
				if dist1 <= 5 then
					Active = false
					ClearPedTasksImmediately(mechPed)
					DoctorNPC()
				end
            end
        end
    end
end)

CreateThread(function()
	local totalTime = 0

    while true do
      Wait(1000)
		if Active then
			if (totalTime >= 300) then
				TriggerEvent("qb-ambulancejob:job:checkin")
				StopScreenEffect('DeathFailOut')
				TriggerServerEvent('qb-medical:server:GetCharge')
				Notify("Your treatment is done, you were charged: "..Config.AIPrice)

				Active = false
				totalTime = 0
			else 
				totalTime += 1;
			end
		end
    end
end)

-- Functions

function SpawnVehicle(x, y, z)
	spam = false
	local vehhash = GetHashKey("emsspeedo")
	local loc = GetEntityCoords(PlayerPedId())
	RequestModel(vehhash)
	while not HasModelLoaded(vehhash) do
		Wait(1)
	end
	RequestModel('s_m_m_doctor_01')
	while not HasModelLoaded('s_m_m_doctor_01') do
		Wait(1)
	end
	local spawnRadius = 200
    local found, spawnPos, spawnHeading = GetClosestVehicleNodeWithHeading(loc.x + math.random(-spawnRadius, spawnRadius), loc.y + math.random(-spawnRadius, spawnRadius), loc.z, 0, 3, 0)

	if not DoesEntityExist(vehhash) then
        mechVeh = CreateVehicle(vehhash, spawnPos, spawnHeading, true, false)
        ClearAreaOfVehicles(GetEntityCoords(mechVeh), 5000, false, false, false, false, false);
        SetVehicleOnGroundProperly(mechVeh)
		SetVehicleNumberPlateText(mechVeh, 'EMS'..tostring(math.random(1000, 9999)))
		SetEntityAsMissionEntity(mechVeh, true, true)
		SetVehicleEngineOn(mechVeh, true, true, false)
		SetVehicleSiren(mechVeh, true)

        mechPed = CreatePedInsideVehicle(mechVeh, 26, GetHashKey('s_m_m_doctor_01'), -1, true, false)

        mechBlip = AddBlipForEntity(mechVeh)
        SetBlipFlashes(mechBlip, true)
        SetBlipColour(mechBlip, 5)


		PlaySoundFrontend(-1, "Text_Arrive_Tone", "Phone_SoundSet_Default", 1)
		Wait(2000)
		TaskVehicleDriveToCoord(mechPed, mechVeh, loc.x, loc.y, loc.z, 20.0, 0, GetEntityModel(mechVeh), 524863, 2.0)
		test = mechVeh
		test1 = mechPed
		Active = true
    end
end

function DoctorNPC()
	RequestAnimDict("mini@cpr@char_a@cpr_str")
	while not HasAnimDictLoaded("mini@cpr@char_a@cpr_str") do
		Wait(1000)
	end

	TaskPlayAnim(test1, "mini@cpr@char_a@cpr_str","cpr_pumpchest",1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
	Wait(15000)
	TriggerEvent("qb-ambulancejob:job:checkin")
	StopScreenEffect('DeathFailOut')
	TriggerServerEvent('qb-medical:server:GetCharge')
	Notify("Your treatment is done, you were charged: "..Config.AIPrice)
	local loc = GetEntityCoords(mechVeh)
	TaskEnterVehicle(mechPed, mechVeh, 1000, -1, 1.0, 1)
	Wait(2500)
	TaskVehicleDriveToCoord(mechPed, mechVeh, loc.x+100, loc.y+100, loc.z, 20.0, 0, GetEntityModel(mechVeh), 524863, 2.0)
	Wait((1000 * 20))
	DeleteEntity(mechPed)
	DeleteEntity(mechVeh)
	spam = true
end

function Notify(msg)
   QBCore.Functions.Notify(msg)
end

RegisterNetEvent('qb-medical:client:callAI', function()
    local PlayerPeds = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        table.insert(PlayerPeds, ped)
    end
    local closestPed, closestDistance = QBCore.Functions.GetClosestPed(GetEntityCoords(PlayerPedId()), PlayerPeds)
    if closestDistance < 50.0 and closestPed ~= 0 and not (PlayerJob.name == 'police' or PlayerJob.name == 'bcso' or PlayerJob.name == "ambulance") then
        local rand = (math.random(6,9) / 100) + 0.3
        local rand2 = (math.random(6,9) / 100) + 0.3
        if math.random(10) > 5 then
            rand = 0.0 - rand
        end
        if math.random(10) > 5 then
            rand2 = 0.0 - rand2
        end
        local MoveTo = GetOffsetFromEntityInWorldCoords(PlayerPedId(), rand, rand2, 0.0)
        TaskGoStraightToCoord(closestPed, MoveTo, 2.5, -1, 0.0, 0.0)
        SetPedKeepTask(closestPed, true)
		local dist = #(MoveTo - GetEntityCoords(closestPed))
        while dist > 3.5 and Config.IsDeath do
            TaskGoStraightToCoord(closestPed, MoveTo, 2.5, -1, 0.0, 0.0)
			dist = #(MoveTo - GetEntityCoords(closestPed))
            Wait(100)
        end
        ClearPedTasksImmediately(closestPed)
        TaskLookAtEntity(closestPed, PlayerPedId(), 5500.0, 2048, 3)
        TaskTurnPedToFaceEntity(closestPed, PlayerPedId(), 5500)
        Wait(3000)
		RequestAnimDict("cellphone@")
		while not HasAnimDictLoaded("cellphone@") do
			Wait(1000)
		end
        TaskPlayAnim(closestPed, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
        SetPedKeepTask(closestPed, true)
        Wait(5000)
		exports['pb_dispatch']:InjuriedPerson()
        SetEntityAsNoLongerNeeded(closestPed)
        ClearPedTasks(closestPed)
    end
end)
