local QBCore = exports['lrp-core']:GetCoreObject()

local ObjectList = {}
local spawnedcoke = 0
local cokePlants = {}
local cokeprops = {}
local started = false
local progress = 0
local pause = false
local quality = 0
local getname = nil
local part1 = true
local part2 = false
local part3 = false
local part4 = false
local tentpos = nil

local isPickingUp, isProcessing, isProcessing2 = false, false, false


local PlayerGang = {}









RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	CheckCoords()
	Wait(1000)
	local coords = GetEntityCoords(PlayerPedId())
	PlayerGang = QBCore.Functions.GetPlayerData().gang
	if GetDistanceBetweenCoords(coords, Config.CircleZones.cokeField.coords, true) < 1000 then
		SpawncokePlants()
	end
end)


RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
    PlayerGang = GangInfo
end)


AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        while true do
        isLoggedIn = true
        Citizen.Wait(1000)
        PlayerGang = QBCore.Functions.GetPlayerData().gang
        PlayerJob = QBCore.Functions.GetPlayerData().job
        end
	end
end)

function CheckCoords()
	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(coords, Config.CircleZones.cokeField.coords, true) < 1000 then
				SpawncokePlants()
			end
			Wait(1 * 60000)
		end
	end)
end

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		CheckCoords()
		while true do
			isLoggedIn = true
			Citizen.Wait(1000)
			PlayerGang = QBCore.Functions.GetPlayerData().gang
		end
	end
end)



RegisterNetEvent("lrp-drugs:client:pickingcoke")
AddEventHandler("lrp-drugs:client:pickingcoke", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyPlant, nearbyPlantID
	
		
		
		for i=1, #cokePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(cokePlants[i]), false) < 3.5 then
				nearbyPlant, nearbyPlantID = cokePlants[i], i		
			end
		end

	isPickingUp = true
	TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
	QBCore.Functions.Progressbar("search_register", "Picking up Coca leafs..", 3000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableInventory = true,
	}, {}, {}, {}, function() -- Done
		ClearPedTasks(PlayerPedId())
		DeleteObject(nearbyPlant)

		table.remove(cokePlants, nearbyPlantID)
		spawnedcoke = spawnedcoke - 1

		TriggerServerEvent('qb-cokepicking:pickedUpcoke')
	end, function()
		ClearPedTasks(PlayerPedId())
	end)

	isPickingUp = false
end)




RegisterNetEvent("lrp-drugs:client:extractingcoke")
AddEventHandler("lrp-drugs:client:extractingcoke", function()
	local playerPed = PlayerPedId()
	
	if HasPedGotWeapon(playerPed, 883325847) then
		if GetAmmoInPedWeapon(playerPed, 883325847) > 1000 then
			RequestAnimDict("weapon@w_sp_jerrycan")
			TaskPlayAnim(playerPed, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )

			QBCore.Functions.Progressbar("extractingcoke", "Adding fuel to Coca leafs", 10000, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
				}, {}, {}, {}, function() -- Done
					SetPedAmmo(playerPed, 883325847, 0)
			StopAnimTask(playerPed, "weapon@w_sp_jerrycan", "fire", 3.0, 3.0, -1, 2, 0, 0, 0, 0)
			end)
		else
			QBCore.Functions.Notify('Jerry can needs more fuel!', 'error')
		end
	else 
		QBCore.Functions.Notify('Maybe try taking out the jerrycan, You brought one right?!', 'error')
	end
end)




RegisterNetEvent("lrp-drugs:client:cokeProcessing")
AddEventHandler("lrp-drugs:client:cokeProcessing", function()
	isProcessing = true
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords((PlayerPedId()))

	TriggerServerEvent('qb-cokepicking:processcoke', pos.x,pos.y,pos.z)
	
	isProcessing = false
end)

RegisterNetEvent("lrp-drugs:client:cokeBag")
AddEventHandler("lrp-drugs:client:cokeBag", function()
	isProcessing = true
	local playerPed = PlayerPedId()

	TriggerServerEvent('qb-cokepicking:bagcoke')
	
	isProcessing = false
end)



RegisterNetEvent("lrp-drugs:client:cokeProcessingBrick")
AddEventHandler("lrp-drugs:client:cokeProcessingBrick", function()
	isProcessing = true
	local playerPed = PlayerPedId()
	TriggerServerEvent('qb-cokepicking:processcokebrick')
	
	isProcessing = false
end)



RegisterNetEvent("lrp-drugs:client:trimmingcoke")
AddEventHandler("lrp-drugs:client:trimmingcoke", function()
	isProcessing = true
	local playerPed = PlayerPedId()
	TriggerServerEvent('qb-cokepicking:trimmingcoke')
	
	isProcessing = false
end)





RegisterNetEvent("lrp-drugs:client:processingcoke")
AddEventHandler("lrp-drugs:client:processingcoke", function(process, time)
	local process = process
	local time = time
	local playerPed = PlayerPedId()
	local heading = GetEntityHeading(playerPed)

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	SetEntityHeading(playerPed, heading)

	QBCore.Functions.Progressbar("Processing drugs", process , time, true, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableInventory = true,
	}, {}, {}, {}, function()

		
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end) -- Cancel
	
end)


AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(cokePlants) do
			DeleteObject(v)
		end
	end
end)


function SpawnObject(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end

function SpawncokePlants()
	while spawnedcoke < 20 do
		local cokeCoords = GeneratecokeCoords()
		SpawnObject('prop_plant_fern_02a', cokeCoords, function(obj)
			table.insert(cokePlants, obj)
			spawnedcoke = spawnedcoke + 1
		end)
		Wait(20000)
	end
end 






function ValidatecokeCoord(plantCoord)
	if spawnedcoke > 0 then
		local validate = true

		for k, v in pairs(cokePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.cokeField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GeneratecokeCoords()
	while true do
		Wait(1000)
		local cokeCoordX, cokeCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10)

		cokeCoordX = Config.CircleZones.cokeField.coords.x + modX
		cokeCoordY = Config.CircleZones.cokeField.coords.y + modY

		local coordZ = GetCoordZcoke(cokeCoordX, cokeCoordY)
		local coord = vector3(cokeCoordX, cokeCoordY, coordZ)

		if ValidatecokeCoord(coord) then
			return coord
		end
	end
end

function GetCoordZcoke(x, y)
	local groundCheckHeights = { 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 31.85
end



CreateThread(function()
	local models = {
	  'prop_plant_fern_02a',
	}
	exports['lrp-target']:AddTargetModel(models, { 
		options = {
			{
				type = "client",
				event = "lrp-drugs:client:pickingcoke",
				icon = "fas fa-box-circle-check",
				label = "Pick coke",
			}
		},
		distance = 1.0, 
	})
end)





Citizen.CreateThread(function()
	while true do
		Wait(1500)
		local models = {
		'prop_barrel_03a',
		}
		exports['lrp-target']:AddTargetModel(models, { 
			options = {
				{
					type = "client",
					event = "lrp-coke:begin",
					icon = "fas fa-box-circle-check",
					label = "Start Coke Production",
					gang = getname
				},
				{
					type = "client",
					event = "lrp-coke:stop",
					icon = "fas fa-box-circle-check",
					label = "Stop Coke Production",
					gang = getname
				}
			},
			distance = 1.0, 
		})
			
		local models = {
			'bkr_prop_coke_table01a',
			}
			exports['lrp-target']:AddTargetModel(models, { 
				options = {
					{
						type = "client",
						event = "lrp-drugs:client:cokeProcessing",
						icon = "fas fa-temperature-high",
						label = "Cook coke",
						gang = getname
					},
					{
						type = "client",
						event = "lrp-drugs:client:cokeBag",
						icon = "fas fa-shopping-bag",
						label = "Bag Coke",
						gang = getname
					},
					{
						type = "client",
						event = "lrp-drugs:client:cokeProcessingBrick",
						icon = "fas fa-box",
						label = "Brick Coke",
						gang = getname
					},
				},
				distance = 1.5, 
			})		
		Citizen.Wait(Config.Delays.territory)
	end
end)










local function GetClosestPoliceObject()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil

    for id, data in pairs(ObjectList) do
        local dist2 = #(pos - vector3(ObjectList[id].coords.x, ObjectList[id].coords.y, ObjectList[id].coords.z))
        if current then
            if dist2 < dist then
                current = id
                dist = dist2
            end
        else
            dist = dist2
            current = id
        end
    end
    return current, dist
end









RegisterNetEvent('lrp-coke:begin')
AddEventHandler('lrp-coke:begin', function()
	if started == false then
		FreezeEntityPosition(PlayerPedId(), true)
		TriggerServerEvent('lrp-coke:start')
	else
		QBCore.Functions.Notify("Already  in a production!", "error")
	end
end)


RegisterNetEvent('lrp-coke:stop')
AddEventHandler('lrp-coke:stop', function()
	started = false
	progress = 0
	quality = 0

	QBCore.Functions.Notify("Production stopped...", "error")
	FreezeEntityPosition(PlayerPedId(), false)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('lrp-coke:startprod')
AddEventHandler('lrp-coke:startprod', function()
	started = true
	QBCore.Functions.Notify("Production started", "success")	
end)


RegisterNetEvent('lrp-coke:smoke')
AddEventHandler('lrp-coke:smoke', function(posx, posy, posz, bool)
	if bool == 'a' then
		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_bzgas_smoke", posx, posy, posz + 0.3, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.9)
		Citizen.Wait(60000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end
end)



RegisterNetEvent('lrp-coke:boom', function()
	part2 = false
	playerPed = (PlayerPedId())
	local pos = GetEntityCoords((PlayerPedId()))
	--BCore.Functions.Notify(data.message, "success")
	TriggerEvent('lrp-coke:stop')
	pause = false
	Citizen.Wait(500)
	started = false
	Citizen.Wait(3000)
	CurrentVehicle = GetVehiclePedIsUsing(PlayerPedId(-1))
	TriggerServerEvent('lrp-coke:blow', pos.x, pos.y, pos.z)
	FreezeEntityPosition(LastCar,false)
end)


RegisterNetEvent('lrp-coke:blowup')
AddEventHandler('lrp-coke:blowup', function(posx, posy, posz)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_meth_fires", posx, posy, posz, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
	SetParticleFxLoopedAlpha(fire, 0.9)
	Citizen.Wait(3000)

	AddExplosion(posx, posy, posz + 2, 15, 20.0, true, false, 1.0, true)

	SetPtfxAssetNextCall("core")
	local fire2 = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)	
	StopParticleFxLooped(fire2, 0)	
end)























------------------------------------------- ingredient parts

------cement

RegisterNetEvent('lrp-coke:cementq2', function(data)
	part1 = false
	part2 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 4
	pause = false
	TriggerServerEvent('lrp-coke:cement', pos.x,pos.y,pos.z)
	

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)


RegisterNetEvent('lrp-coke:cementq5', function(data)
	part1 = false
	part2 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 8
	pause = false
	TriggerServerEvent('lrp-coke:cement', pos.x,pos.y,pos.z)


	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('lrp-coke:cementq-5', function(data)
	part1 = false
	part2 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "error")
	quality = quality - 10
	pause = false
	TriggerServerEvent('lrp-coke:cement3', pos.x,pos.y,pos.z)


	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)



------hydrochloricacid

RegisterNetEvent('lrp-coke:hydrochloricacidq-2', function(data)
	part2 = false
	part3 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 10
	pause = false
	TriggerServerEvent('lrp-coke:hydrochloricacid', pos.x,pos.y,pos.z)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)


RegisterNetEvent('lrp-coke:hydrochloricacidq5', function(data)
	part2 = false
	part3 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 10
	pause = false
	TriggerServerEvent('lrp-coke:hydrochloricacid', pos.x,pos.y,pos.z)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)



------hydratedlime

RegisterNetEvent('lrp-coke:hydratedlimeq-2', function(data)
	part3 = false
	part4 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 4
	pause = false
	TriggerServerEvent('lrp-coke:hydratedlime', pos.x,pos.y,pos.z)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)


RegisterNetEvent('lrp-coke:hydratedlimeq5', function(data)
	part3 = false
	part4 = true
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 8
	pause = false
	TriggerServerEvent('lrp-coke:hydratedlime', pos.x,pos.y,pos.z)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)


RegisterNetEvent('lrp-coke:hydratedlimeq-5', function(data)
	part3 = false
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 10
	pause = false
	TriggerServerEvent('lrp-coke:hydratedlime4', pos.x,pos.y,pos.z)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)



------ammonia

RegisterNetEvent('lrp-coke:ammoniaq-2', function(data)
	part4 = false
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality - 10
	pause = false
	TriggerServerEvent('lrp-coke:ammonia', pos.x,pos.y,pos.z)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)


RegisterNetEvent('lrp-coke:ammoniaq5', function(data)
	part4 = false
	local pos = GetEntityCoords((PlayerPedId()))
	QBCore.Functions.Notify(data.message, "success")
	quality = quality + 10
	pause = false
	TriggerServerEvent('lrp-coke:ammonia', pos.x,pos.y,pos.z)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER", 0, true)
	Wait(25000)
	ClearPedTasks(PlayerPedId())
end)




















--function startcook()

	Citizen.CreateThread(function(data)
		while true do
			Citizen.Wait(1000)		
			local pos = GetEntityCoords(playerPed)
			if started == true then			
				if progress < 96 then
					Citizen.Wait(500)
					playerPed = (PlayerPedId())
					if not pause then
						progress = progress +  1
						quality = quality + 1
						Citizen.Wait(3500)
					end

							
					--ingredients--
					
					
					--   PART1
					--
					if  progress > 4 and part1 then
						pause = true
						exports['lrp-menu']:openMenu({
							{
								header = "How much Cement should you add?",
								txt = "Pick your answer below. Progres: " .. progress .. "%",
								isMenuHeader = true
							},
							{
								header = "12kg",
								params = {
									event = "lrp-coke:cementq5",
									args = {
										message = "Perfect Amount!"
									}
								}
							},
							{
								header = "25kg",
								params = {
									event = "lrp-coke:cementq-5",
									args = {
										message = "Are you bulding a house!"
									}
								}
							},
							{
								header = "5kg",
								params = {
									event = "lrp-coke:cementq2",
									args = {
										message = "Not enough"
									}
								}
							},
						})
					end
					--
					--   PART2
					--
					if  progress > 26 and progress < 30 and part2 then
						pause = true
						exports['lrp-menu']:openMenu({
							{
								header = "How much Hydrochloric Acid should you add?",
								txt = "Pick your answer below. Progres: " .. progress .. "%",
								isMenuHeader = true
							},
							{
								header = "10ml",
								params = {
									event = "lrp-coke:hydrochloricacidq5",
									args = {
										message = "Perfect Amount!"
									}
								}
							},
							{
								header = "30ml",
								params = {
									event = "lrp-coke:hydrochloricacidq-2",
									args = {
										message = "A bit to much!"
									}
								}
							},
							{
								header = "360ml",
								params = {
									event = "lrp-coke:boom",
									args = {
										message = "Thick cunt!"
									}
								}
							},
						})
					end

					if progress > 34 and progress < 36  then
						TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_SMOKING", 0, true)
					end

					--   PART3
					--
					if progress > 47 and progress < 54 and part3 then
						pause = true
						exports['lrp-menu']:openMenu({
							{
								header = "How much Hydrated Lime should you add?",
								txt = "Pick your answer below. Progres: " .. progress .. "%",
								isMenuHeader = true
							},
							{
								header = "25kg",
								params = {
									event = "lrp-coke:boom",
									args = {
										message = "Yeah a bit to much there!"
									}
								}
							},
							{
								header = "750g",
								params = {
									event = "lrp-coke:hydratedlimeq-2",
									args = {
										message = "Not quite enough!"
									}
								}
							},
							{
								header = "2kg",
								params = {
									event = "lrp-coke:hydratedlimeq5",
									args = {
										message = "Perfect Amount!"
									}
								}
							},
						})
					end

					
					--   PART4
					--
					if  progress > 76 and progress < 81 and part4 then
						pause = true
						exports['lrp-menu']:openMenu({
							{
								header = "How much ammonia should you add?",
								txt = "Pick your answer below. Progres: " .. progress .. "%",
								isMenuHeader = true
							},
							{
								header = "48ml",
								params = {
									event = "lrp-coke:ammoniaq5",
									args = {
										message = "Perfect Amount!"
									}
								}
							},
							{
								header = "78ml",
								params = {
									event = "lrp-coke:ammoniaq-2",
									args = {
										message = "A bit to much!"
									}
								}
							},
							{
								header = "500ml",
								params = {
									event = "lrp-coke:stop",
									args = {
										message = "Way to much, batch was ruined!"
									}
								}
							},
						})
					end
					
					if progress > 87 and progress < 90  then
						TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
					end

					

				else
					
					progress = 100
					QBCore.Functions.Notify('Coke production: ' .. progress .. '%')
					QBCore.Functions.Notify("Done!!", "success")
					TriggerServerEvent('lrp-coke:finish', quality)
					TriggerEvent('lrp-coke:stop')
					SetPedPropIndex(playerPed, 1, 0, 0, true)
				end	
				

				local pos2 = GetEntityCoords(playerPed)
				local distance = #(pos - vector3(pos2.x, pos2.y, pos2.z))


				if distance >=5 then 
					TriggerEvent('lrp-coke:stop')
				end
			end		
		end
	end)
--end

























































------props




RegisterCommand("cokefinish", function()
	TriggerEvent('lrp-drug:client:deleteObject')
end)




--spawn tent





RegisterNetEvent('lrp-drug:client:spawnTent', function()
	local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)
	tentpos = pos

	if getname == PlayerGang.name then
		if pos.y > 1800 then
			QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@narcotics@trash",
				anim = "drop_front",
				flags = 16,
			}, {}, {}, function() -- Done
				StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
				TriggerServerEvent("lrp-drug:server:spawnObject", "tent")
			end, function() -- Cancel
				StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
				QBCore.Functions.Notify("Canceled..", "error")
			end)
		else	
			QBCore.Functions.Notify("You are to close to the city!", "error")
		end
	else
		QBCore.Functions.Notify("You are not allowed to use this item!", "error")
	end
end)


RegisterNetEvent('lrp-drug:client:spawnTable', function()
	local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)
	local distance = #(tentpos - vector3(pos.x, pos.y, pos.z))


	if distance <=3 then 
		QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "anim@narcotics@trash",
			anim = "drop_front",
			flags = 16,
		}, {}, {}, function() -- Done
			StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
			TriggerServerEvent("lrp-drug:server:spawnObject", "table")
		end, function() -- Cancel
			StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
			QBCore.Functions.Notify("Canceled..", "error")
		end)
	else
		QBCore.Functions.Notify("To far away from tent!!", "error")
	end
end)



RegisterNetEvent('lrp-drug:client:spawnBarrel', function()
	local ped = PlayerPedId()	
	local pos = GetEntityCoords(ped)
	local distance = #(tentpos - vector3(pos.x, pos.y, pos.z))


	if distance <=3 then 
		QBCore.Functions.Progressbar("spawn_object", "Place object..", 2500, false, true, {
			disableMovement = true,
			disableCarMovement = true,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "anim@narcotics@trash",
			anim = "drop_front",
			flags = 16,
		}, {}, {}, function() -- Done
			StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
			TriggerServerEvent("lrp-drug:server:spawnObject", "ballel")
		end, function() -- Cancel
			StopAnimTask(PlayerPedId(), "anim@narcotics@trash", "drop_front", 1.0)
			QBCore.Functions.Notify("Canceled..", "error")
		end)
	else
		QBCore.Functions.Notify("To far away from tent!!", "error")
	end

end)









--object control

RegisterNetEvent('lrp-drug:client:spawnObject', function(objectId, type, player)
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(player)))
    local heading = GetEntityHeading(GetPlayerPed(GetPlayerFromServerId(player)))
    local forward = GetEntityForwardVector(PlayerPedId())
    local x, y, z = table.unpack(coords + forward * 0.5)
    local spawnedObj = CreateObject(Config.Objects[type].model, x, y, z, true, false, false)
    PlaceObjectOnGroundProperly(spawnedObj)
    SetEntityHeading(spawnedObj, heading)
    FreezeEntityPosition(spawnedObj, Config.Objects[type].freeze)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = {
            x = x,
            y = y,
            z = z - 0.3,
        },
    }
end)





-- delete tent 

RegisterNetEvent('lrp-drug:client:deleteObject', function()
    local objectId, dist = GetClosestPoliceObject()
    if dist < 5.0 then
        QBCore.Functions.Progressbar("remove_object", "Removing object..", 2500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "weapons@first_person@aim_rng@generic@projectile@thermal_charge@",
            anim = "plant_floor",
            flags = 16,
        }, {}, {}, function() -- Done
            StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            TriggerServerEvent("lrp-drug:server:deleteObject", objectId)
        end, function() -- Cancel
            StopAnimTask(PlayerPedId(), "weapons@first_person@aim_rng@generic@projectile@thermal_charge@", "plant_floor", 1.0)
            QBCore.Functions.Notify("Canceled..", "error")
        end)
    end
end)


RegisterNetEvent('lrp-drug:client:removeObject', function(objectId)
    NetworkRequestControlOfEntity(ObjectList[objectId].object)
    DeleteObject(ObjectList[objectId].object)
    ObjectList[objectId] = nil
end)



Citizen.CreateThread(function()
	while true do
		Wait(1000)
		getname = exports['lrp-territories']:IsTerritoryDominationMoreThanZero('LittleSeoul')
		Wait(Config.Delays.territory)
	end
end)
