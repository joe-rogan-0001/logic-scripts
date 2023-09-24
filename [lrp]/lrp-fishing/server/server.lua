local QBCore = exports['lrp-core']:GetCoreObject()
--============================================================================ Items

QBCore.Functions.CreateUseableItem("anchor", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		TriggerClientEvent('fishing:client:anchor', source)
    end
end)

QBCore.Functions.CreateUseableItem("fishingrod", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
 		TriggerClientEvent('fishing:fishstart', source)
    end
end)

QBCore.Functions.CreateUseableItem("fishicebox", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) then
		--TriggerClientEvent('fishing:client:useFishingBox', source, item.info.boxid)  
    end
end)

QBCore.Functions.CreateUseableItem("fishinglootbig", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		TriggerClientEvent("fishing:client:attemptTreasureChest", src)
    end
end)

QBCore.Functions.CreateUseableItem("fishingloot", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
		Player.Functions.RemoveItem("fishingloot", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "remove", 1)
		TriggerClientEvent('QBCore:Notify', src, "Opening Box", "primary")
		SetTimeout(1000, function()
			Player.Functions.AddItem('fishingkey', 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingkey'], "add", 1)

			Player.Functions.AddItem(Config.smallLootboxReward, 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.smallLootboxReward], "add", 1)

			Player.Functions.AddMoney('cash', Config.smallLootboxCash, "fishingloot")
			TriggerClientEvent('QBCore:Notify', src, "You found a couple items and $"..Config.smallLootboxCash, "success")
		end)
    end
end)

QBCore.Functions.CreateUseableItem("fishtacklebox", function(source, item)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then

		TriggerClientEvent('QBCore:Notify', src, "Opening Tackel Box", "success")
		Player.Functions.RemoveItem("fishtacklebox", 1)
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishtacklebox'], "remove", 1)

		SetTimeout(1250, function()
			Player.Functions.AddItem('pearlscard', 1, nil, {["quality"] = 100}) 
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['pearlscard'], "add", 1)
		end)
    end
end)

--============================================================================ Events

RegisterNetEvent('fishing:server:removeFishingBait', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.RemoveItem('fishbait', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishbait'], "remove", 1)
end)

RegisterNetEvent("fishing:server:addTackleBox", function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('QBCore:Notify', src, "There seems to tackle box left over from another fisherman", "primary")
	SetTimeout(1000, function()
		Player.Functions.AddItem('fishtacklebox', 1, nil, {["quality"] = 100}) 
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishtacklebox'], "add", 1)
	end)
end) 

RegisterNetEvent("fishing:server:returnDeposit", function()
	local src = source
    local pData = QBCore.Functions.GetPlayer(src)
	local price = math.floor(Config.BoatPrice/2)
	pData.Functions.AddMoney('bank', price , "boat-rental")
	TriggerClientEvent('QBCore:Notify', src, "Boat has been returned for $"..price, "success")
end) 

RegisterNetEvent('fishing:server:catch', function() 
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local luck = math.random(1, 100)
    local itemFound = true
    local itemCount = 1

    if itemFound then
        for i = 1, itemCount, 1 do
            if luck == 100 then
				local weight = math.random(850,1000)
				local info = {species = "Orca",lbs = weight,type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 1)
				Player.Functions.AddItem('killerwhale', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['killerwhale'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a killer whale!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 95 and luck <= 100 then
				Player.Functions.AddItem('fishinglootbig', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishinglootbig'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a Treasure Chest!", "success")
			elseif luck >= 90 and luck <= 95 then
				local weight = math.random(10,28)
				local info = {species = "Bottlenose",lbs = weight, type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 2)
				Player.Functions.AddItem('dolphin', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dolphin'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a dolphin!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 85 and luck <= 90 then
				local weight = math.random(20,30)
				local info = {species = "Hammerhead Shark", lbs = weight, type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 3)
				Player.Functions.AddItem('sharkhammer', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharkhammer'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a hammerhead shark!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 80 and luck <= 85 then
				local weight = math.random(1,6)
				local info = {species = "Tiger Shark", lbs = weight, type = "Exotic"}
				TriggerClientEvent('fishing:client:spawnFish', src, 4)
				Player.Functions.AddItem('sharktiger', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['sharktiger'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a tiger shark!\nThese are endangered species and are illegal to possess", "primary")
			elseif luck >= 75 and luck <= 80 then
				local weight = math.random(4,9)
				local info = {species = "Manta ray", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 5)
				Player.Functions.AddItem('stingray', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stingray'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a "..weight.."lbs Stingray!", "success")
			elseif luck >= 70 and luck <= 75 then
				local weight = math.random(10,15)
				local info = {species = "Flounder", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('flounder', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['flounder'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs Flounder", "success")
			elseif luck >= 65 and luck <= 70 then
				Player.Functions.AddItem('fishingboot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingboot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a fishing boot!", "primary")
			elseif luck >= 60 and luck <= 65 then
				local weight = math.random(1,6)
				local info = {species = "Bass", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('bass', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['bass'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs Bass", "success")
			elseif luck >= 55 and luck <= 60 then
				Player.Functions.AddItem('fishingloot', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingloot'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You found a small box!", "success")
			elseif luck >= 50 and luck <= 55 then
				local weight = math.random(5,7)
				local info = {species = "Cod", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('codfish', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['codfish'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs  Cod", "success")
			elseif luck >= 45 and luck <= 50 then
				Player.Functions.AddItem('fishingtin', 1, nil, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['fishingtin'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a fishing tin!", "primary")
			elseif luck >= 0 and luck <= 45 then
				local weight = math.random(1,5)
				local info = {species = "Mackerel", lbs = weight, type = "Normal"}
				TriggerClientEvent('fishing:client:spawnFish', src, 6)
				Player.Functions.AddItem('mackerel', 1, nil, info, {["quality"] = 100})
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['mackerel'], "add", 1)
				TriggerClientEvent('QBCore:Notify', src, "You caught a " .. weight .. "lbs Mackerel", "success")
            end
            Citizen.Wait(500)
        end
    end
end)


--illegal fish
RegisterServerEvent('lrp-fishing:server:dolphin')
AddEventHandler('lrp-fishing:server:dolphin', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local dolphin = Player.Functions.GetItemByName("dolphin")
	
	if dolphin ~= nil then 	
		local totaldolphin = dolphin.amount
		local payment = Config.dolphinPrice * totaldolphin
		Player.Functions.RemoveItem('dolphin', totaldolphin)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any dolphin', "error") 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	end
end)


RegisterServerEvent('lrp-fishing:server:sharktiger')
AddEventHandler('lrp-fishing:server:sharktiger', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local sharktiger = Player.Functions.GetItemByName("sharktiger")
	
	if sharktiger ~= nil then 	
		local totalsharktiger = sharktiger.amount
		local payment = Config.sharktigerPrice * totalsharktiger
		Player.Functions.RemoveItem('sharktiger', totalsharktiger)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any sharktiger', "error") 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	end
end)


RegisterServerEvent('lrp-fishing:server:sharkhammer')
AddEventHandler('lrp-fishing:server:sharkhammer', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local sharkhammer = Player.Functions.GetItemByName("sharkhammer")
	
	if sharkhammer ~= nil then 	
		local totalsharkhammer = sharkhammer.amount
		local payment = Config.sharkhammerPrice * totalsharkhammer
		Player.Functions.RemoveItem('sharkhammer', totalsharkhammer)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any sharkhammer', "error") 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	end
end)


RegisterServerEvent('lrp-fishing:server:killerwhale')
AddEventHandler('lrp-fishing:server:killerwhale', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local killerwhale = Player.Functions.GetItemByName("killerwhale")
	
	if killerwhale ~= nil then 	
		local totalkillerwhale = killerwhale.amount
		local payment = Config.killerwhalePrice * totalkillerwhale
		Player.Functions.RemoveItem('killerwhale', totalkillerwhale)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any killerwhale', "error") 
		TriggerClientEvent('doj:client:SellillegalFish', source)
	end
end)














--legal fish
RegisterServerEvent('lrp-fishing:server:mackerel')
AddEventHandler('lrp-fishing:server:mackerel', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local mackerel = Player.Functions.GetItemByName("mackerel")
	
	if mackerel ~= nil then 	
		local totalmackerel = mackerel.amount
		local payment = Config.mackerelPrice * totalmackerel
		Player.Functions.RemoveItem('mackerel', totalmackerel)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any mackerel', "error") 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	end
end)


RegisterServerEvent('lrp-fishing:server:codfish')
AddEventHandler('lrp-fishing:server:codfish', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local codfish = Player.Functions.GetItemByName("codfish")
	
	if codfish ~= nil then 	
		local totalcodfish = codfish.amount
		local payment = Config.codfishPrice * totalcodfish
		Player.Functions.RemoveItem('codfish', totalcodfish)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any codfish', "error") 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	end
end)


RegisterServerEvent('lrp-fishing:server:bass')
AddEventHandler('lrp-fishing:server:bass', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local bass = Player.Functions.GetItemByName("bass")
	
	if bass ~= nil then 	
		local totalbass = bass.amount
		local payment = Config.bassPrice * totalbass
		Player.Functions.RemoveItem('bass', totalbass)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any bass', "error") 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	end
end)


RegisterServerEvent('lrp-fishing:server:flounder')
AddEventHandler('lrp-fishing:server:flounder', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local flounder = Player.Functions.GetItemByName("flounder")
	
	if flounder ~= nil then 	
		local totalflounder = flounder.amount
		local payment = Config.flounderPrice * totalflounder
		Player.Functions.RemoveItem('flounder', totalflounder)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any flounder', "error") 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	end
end)



RegisterServerEvent('lrp-fishing:server:stingray')
AddEventHandler('lrp-fishing:server:stingray', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local stingray = Player.Functions.GetItemByName("stingray")
	
	if stingray ~= nil then 	
		local totalstingray = stingray.amount
		local payment = Config.stingrayPrice * totalstingray
		Player.Functions.RemoveItem('stingray', totalstingray)
		TriggerEvent('qb-banking:server:sendPaycheck', payment, source) 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any stingray', "error") 
		TriggerClientEvent('doj:client:SellLegalFish', source)
	end
end)




--============================================================================ Callbacks
QBCore.Functions.CreateCallback('fishing:server:checkMoney', function(source, cb)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local bankBalance = pData.PlayerData.money["bank"]
	local price = Config.BoatPrice
    if bankBalance >= price then
        pData.Functions.RemoveMoney('bank', Config.BoatPrice, "boat-rental")
		TriggerClientEvent('QBCore:Notify', src, "Boat has been rented for $"..price, "success")
        cb(true)
    else
        TriggerClientEvent('QBCore:Notify', src, "You dont have enough money..", "error")
        cb(false)
    end
end)
