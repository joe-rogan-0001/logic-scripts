local QBCore = exports['lrp-core']:GetCoreObject()



RegisterServerEvent('qb-weedpicking:pickedUpCannabis') --hero
AddEventHandler('qb-weedpicking:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local rnd = math.random(1, 100)
	print(rnd)
	if (10 >= rnd) then
		Player.Functions.AddItem("marijuana_seeds", 1, slot, {["quality"] = 100})
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['marijuana_seeds'], "add")
		local amount = math.random(2, 4)
		Player.Functions.AddItem('untrimmedweed', amount) 
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['untrimmedweed'], "add")
	else
		local amount = math.random(7, 9)
		Player.Functions.AddItem('untrimmedweed', amount) 
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['untrimmedweed'], "add")
	end
end)


RegisterServerEvent('qb-weedpicking:processweed')
AddEventHandler('qb-weedpicking:processweed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local cannabis = Player.Functions.GetItemByName("cannabis")
	local process = "Bagging Weed"
	local time = Config.Delays.WeedProcessing
	
	if cannabis ~= nil then 
		local cannabis2 = Player.Functions.GetItemByName("cannabis")
   		local empty_weed_bag = Player.Functions.GetItemByName("empty_weed_bag")
        if cannabis2.amount >= 3 and empty_weed_bag.amount >= 1 then
			TriggerClientEvent('lrp-drugs:client:processing', source, process, time) 
			Wait(time)
			Player.Functions.RemoveItem('cannabis', 3) 
			Player.Functions.RemoveItem('empty_weed_bag', 1)
			Player.Functions.AddItem('weed_bag', 1)
			TriggerClientEvent('QBCore:Notify', src, 'Bag of Weed Processed', "success")  
		
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
        end
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)




RegisterServerEvent('qb-weedpicking:processweedbrick')
AddEventHandler('qb-weedpicking:processweedbrick', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local weed	=  Player.Functions.GetItemByName("cannabis")
	local process = "Processing Brick of Weed"
	local time = Config.Delays.WeedBrick
	
	if weed ~= nil then
        if weed.amount >= 30 then
			TriggerClientEvent('lrp-drugs:client:processing', source, process, time) 
			Wait(time)
			Player.Functions.RemoveItem('cannabis', 30)
            Player.Functions.AddItem('weed_brick', 1)
			TriggerClientEvent('QBCore:Notify', src, 'Brick of Weed Processed', "success")  
		
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
        end
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)


RegisterServerEvent('qb-weedpicking:trimmingweed')
AddEventHandler('qb-weedpicking:trimmingweed', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local untrimmedweed	=  Player.Functions.GetItemByName("untrimmedweed") 
	local process = "Trimming Weed"
	local time = Config.Delays.WeedTrimming

	if untrimmedweed ~= nil then
        if untrimmedweed.amount >= 1 then
			TriggerClientEvent('lrp-drugs:client:processing', source, process, time) 
			Wait(time)
			Player.Functions.RemoveItem('untrimmedweed', 1)
            Player.Functions.AddItem('cannabis', 1)
			TriggerClientEvent('QBCore:Notify', src, 'Weed Trimmed', "success")  
		
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
        end
	else
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)




function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end


RegisterServerEvent('qb-weedpicking:onPlayerDeath')
AddEventHandler('qb-weedpicking:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)


