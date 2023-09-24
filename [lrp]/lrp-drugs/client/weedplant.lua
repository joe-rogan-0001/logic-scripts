local QBCore = exports['lrp-core']:GetCoreObject()


local spawnedWeed = 0
local weedPlants = {}
local getname = nil

local isPickingUp, isProcessing, isProcessing2 = false, false, false


RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	CheckCoords2()
	Wait(1000)
	local coords = GetEntityCoords(PlayerPedId())
	if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 1000 then
		SpawnWeedPlants()
	end
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		CheckCoords2()
	end
end)

function CheckCoords2()
	Citizen.CreateThread(function()
		while true do
			local coords = GetEntityCoords(PlayerPedId())
			if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedField.coords, true) < 1000 then
				SpawnWeedPlants()
			end
			Wait(5000)
		end
	end)
end





RegisterNetEvent("lrp-drugs:client:pickingweed")
AddEventHandler("lrp-drugs:client:pickingweed", function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID
	
		
		
		for i=1, #weedPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(weedPlants[i]), false) < 2.5 then
				nearbyObject, nearbyID = weedPlants[i], i
			end
		end

	isPickingUp = true
	TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
	QBCore.Functions.Progressbar("search_register", "Picking up Cannabis..", 3000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableInventory = true,
	}, {}, {}, {}, function() -- Done
		ClearPedTasks(PlayerPedId())
		DeleteObject(nearbyObject)
		table.remove(weedPlants, nearbyID)
		spawnedWeed = spawnedWeed - 1
		TriggerServerEvent('qb-weedpicking:pickedUpCannabis')
	end, function()
		ClearPedTasks(PlayerPedId())
	end)

	isPickingUp = false
end)



RegisterNetEvent("lrp-drugs:client:WeedProcessing")
AddEventHandler("lrp-drugs:client:WeedProcessing", function()
	isProcessing = true
	local playerPed = PlayerPedId()
	TriggerServerEvent('qb-weedpicking:processweed')
	
	isProcessing = false
end)


RegisterNetEvent("lrp-drugs:client:WeedProcessingBrick")
AddEventHandler("lrp-drugs:client:WeedProcessingBrick", function()
	isProcessing = true
	local playerPed = PlayerPedId()
	TriggerServerEvent('qb-weedpicking:processweedbrick')
	isProcessing = false
end)



RegisterNetEvent("lrp-drugs:client:trimmingweed")
AddEventHandler("lrp-drugs:client:trimmingweed", function()
	isProcessing = true
	local playerPed = PlayerPedId()
	TriggerServerEvent('qb-weedpicking:trimmingweed')
	
	isProcessing = false
end)





RegisterNetEvent("lrp-drugs:client:processing")
AddEventHandler("lrp-drugs:client:processing", function(process, time)
	local process = process
	local time = time
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	SetEntityHeading(PlayerPedId(), 222.28)

	QBCore.Functions.Progressbar("Processing drugs", process , time, false, true, {
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
		for k, v in pairs(weedPlants) do
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




function SpawnWeedPlants()
	while spawnedWeed < 20 do
		local weedCoords = GenerateWeedCoords()
		SpawnObject('prop_weed_01', weedCoords, function(obj)
			table.insert(weedPlants, obj)
			spawnedWeed = spawnedWeed + 1
		end)
		Wait(20000)
	end
end 



function ValidateWeedCoord(plantCoord)
	if spawnedWeed > 0 then
		local validate = true

		for k, v in pairs(weedPlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(plantCoord, Config.CircleZones.WeedField.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Wait(1000)
		local weedCoordX, weedCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-10, 10)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-10, 10)

		weedCoordX = Config.CircleZones.WeedField.coords.x + modX
		weedCoordY = Config.CircleZones.WeedField.coords.y + modY

		local coordZ = GetCoordZWeed(weedCoordX, weedCoordY)
		local coord = vector3(weedCoordX, weedCoordY, coordZ)

		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZWeed(x, y)
	local groundCheckHeights = { 31.0, 32.0, 33.0, 34.0, 35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 50.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 31.85
end





Citizen.CreateThread(function()
	while true do
		Wait(1500)
		local models = {
		'bkr_prop_weed_table_01a',
		}
		exports['lrp-target']:AddTargetModel(models, { 
			options = {
				{
					type = "client",
					event = "lrp-drugs:client:WeedProcessing",
					icon = "fas fa-cannabis",
					label = "Processes Weed",
					gang = getname
				},
				{
					type = "client",
					event = "lrp-drugs:client:WeedProcessingBrick",
					icon = "fas fa-cannabis",
					label = "Processes Weed Brick",
					gang = getname
				},
			},
			distance = 2.5, 
		})
			
		local models = {
		'prop_table_08',
		}
		exports['lrp-target']:AddTargetModel(models, { 
			options = {
				{
					type = "client",
					event = "lrp-drugs:client:trimmingweed",
					icon = "fas fa-cannabis",
					label = "Trim Weed",
					gang = getname
				},
			},
			distance = 2.5, 
		})		
		Citizen.Wait(Config.Delays.territory)
	end
end)





local models = {
'prop_weed_01',
}
exports['lrp-target']:AddTargetModel(models, { 
	options = {
		{
			type = "client",
			event = "lrp-drugs:client:pickingweed",
			icon = "fas fa-box-circle-check",
			label = "Pick Weed",
		}
	},
	distance = 1.8, 
})










Citizen.CreateThread(function()
	while true do
		Wait(1000)
		getname = exports['lrp-territories']:IsTerritoryDominationMoreThanZero('Grove')
		Wait(Config.Delays.territory)
	end
end)


