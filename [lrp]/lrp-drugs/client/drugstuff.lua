Citizen.CreateThread(function()
	while QBCore == nil do
		Wait(200)
	end
	while true do
		Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessing.coords, true) < 5 then
			DrawMarker(2, Config.CircleZones.WeedProcessing.coords.x, Config.CircleZones.WeedProcessing.coords.y, Config.CircleZones.WeedProcessing.coords.z - 0.2 , 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.15, 255, 0, 0, 100, 0, 0, 0, true, 0, 0, 0)

			
			if not isProcessing and GetDistanceBetweenCoords(coords, Config.CircleZones.WeedProcessing.coords, true) <1 then
				QBCore.Functions.DrawText3D(Config.CircleZones.WeedProcessing.coords.x, Config.CircleZones.WeedProcessing.coords.y, Config.CircleZones.WeedProcessing.coords.z, 'Press ~g~[E]~w~ to Process')
			end

			if IsControlJustReleased(0, 38) and not isProcessing then
				local hasBag = false
				local s1 = false
				local hasWeed = false
				local s2 = false

				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					hasWeed = result
					s1 = true
				end, 'cannabis')
				
				while(not s1) do
					Wait(100)
				end
				Wait(100)
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					hasBag = result
					s2 = true
				end, 'empty_weed_bag')
				
				while(not s2) do
					Wait(100)
				end

				if (hasWeed and hasBag) then
					Processweed()
				elseif (hasWeed) then
					QBCore.Functions.Notify('You dont have enough plastic bags.', 'error')
				elseif (hasBag) then
					QBCore.Functions.Notify('You dont have enough cannabis.', 'error')
				else
					QBCore.Functions.Notify('You dont have enough cannabis and plastic bags.', 'error')
				end
			end
		else
			Wait(500)
		end
	end
end)



function Processweed()
	isProcessing = true
	local playerPed = PlayerPedId()

	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	SetEntityHeading(PlayerPedId(), 108.06254)

	QBCore.Functions.Progressbar("search_register", "Trying to Process..", 30000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableInventory = true,
	}, {}, {}, {}, function()
	 TriggerServerEvent('qb-weedpicking:processweed')

		local timeLeft = Config.Delays.WeedProcessing / 1000

		while timeLeft > 0 do
			Wait(1000)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
				TriggerServerEvent('qb-weedpicking:cancelProcessing')
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end) -- Cancel
	
	isProcessing = false
end






Citizen.CreateThread(function()
	while QBCore == nil do
		Wait(200)
	end
	while true do
		Wait(10)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		if GetDistanceBetweenCoords(coords, Config.CircleZones.DrugDealer.coords, true) < 5 then
			DrawMarker(2, Config.CircleZones.DrugDealer.coords.x, Config.CircleZones.DrugDealer.coords.y, Config.CircleZones.DrugDealer.coords.z - 0.2 , 0, 0, 0, 0, 0, 0, 0.3, 0.2, 0.15, 255, 0, 0, 100, 0, 0, 0, true, 0, 0, 0)

			
			if not isProcessing2 and GetDistanceBetweenCoords(coords, Config.CircleZones.DrugDealer.coords, true) <1 then
				QBCore.Functions.DrawText3D(Config.CircleZones.DrugDealer.coords.x, Config.CircleZones.DrugDealer.coords.y, Config.CircleZones.DrugDealer.coords.z, 'Press ~g~[E]~w~ to Sell')
			end

			if IsControlJustReleased(0, 38) and not isProcessing2 then
				local hasWeed2 = false
				local hasBag2 = false
				local s3 = false
				
				QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
					hasWeed2 = result
					hasBag2 = result
					s3 = true
					
				end, 'weed_bag')
				
				while(not s3) do
					Wait(100)
				end
				

				if (hasWeed2) then
					SellDrug()
				elseif (hasWeed2) then
					QBCore.Functions.Notify('You dont have enough plastic bags.', 'error')
				elseif (hasBag2) then
					QBCore.Functions.Notify('You dont have enough cannabis.', 'error')
				else
					QBCore.Functions.Notify('You dont have enough weed bags to sell.', 'error')
				end
			end
		else
			Wait(500)
		end
	end
end)



function SellDrug()
	isProcessing2 = true
	local playerPed = PlayerPedId()

	--
	TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
	SetEntityHeading(PlayerPedId(), 108.06254)

	QBCore.Functions.Progressbar("search_register", "Trying to Sell..", 1500, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
		disableInventory = true,
	}, {}, {}, {}, function()
	 TriggerServerEvent('qb-weedpicking:selld')

		local timeLeft = Config.Delays.WeedProcessing / 1000

		while timeLeft > 0 do
			Wait(500)
			timeLeft = timeLeft - 1

			if GetDistanceBetweenCoords(GetEntityCoords(playerPed), Config.CircleZones.WeedProcessing.coords, false) > 4 then
				break
			end
		end
		ClearPedTasks(PlayerPedId())
	end, function()
		ClearPedTasks(PlayerPedId())
	end) -- Cancel

	isProcessing2 = false
end