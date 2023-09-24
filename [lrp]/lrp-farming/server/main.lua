-- SCRIPT DEVELOPED BY OSMIUM | OSMFX | DISCORD.IO/OSMFX --
local QBCore = exports['lrp-core']:GetCoreObject()

local playersProcessingCannabis = {}

RegisterServerEvent('osm-farming:pickedUpCannabis')
AddEventHandler('osm-farming:pickedUpCannabis', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	  if TriggerClientEvent("QBCore:Notify", src, "Picked up some Corn Kernels!!", 3000) then
		local amount = Config.CornOutput
		  Player.Functions.AddItem('corn_kernel', amount) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['corn_kernel'], "add",amount)
	  end
end)

RegisterServerEvent('osm-farming:GivePlayerBox')
AddEventHandler('osm-farming:GivePlayerBox', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem('box', 2) ---- change this shit 
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['box'], "add",2)

end)

RegisterServerEvent("osm-farming:server:SellFarmingItems")
AddEventHandler("osm-farming:server:SellFarmingItems", function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Config.ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    price = price + (Config.ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
		TriggerEvent('qb-banking:server:sendPaycheck', price, src)
		--TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
        -- Player.Functions.AddMoney("cash", price, "sold-farm-items")
        -- TriggerClientEvent('QBCore:Notify', src, "You have sold your items for "..price.."$")
    end
end)

RegisterServerEvent('osm-farming:CowMilked')
AddEventHandler('osm-farming:CowMilked', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	  if TriggerClientEvent("QBCore:Notify", src, "You got some Milk!", 4000) then
		  local amount = Config.MilkOutput
		  Player.Functions.AddItem('milk', amount) ---- change this shit 
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['milk'], "add",amount)
	  end
end)

RegisterServerEvent('osm-farming:ProcessCorn')
AddEventHandler('osm-farming:ProcessCorn', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)

		local corn = Player.Functions.GetItemByName('corn_kernel')
		local box = Player.Functions.GetItemByName('box')
		if corn ~= nil and corn.amount >= 4 then 

			if box ~= nil and box.amount >= 1 then
				Player.Functions.RemoveItem('corn_kernel', 4)----change this
				Player.Functions.RemoveItem('box', 1)----change this
				Player.Functions.AddItem('corn_packet', 1)----change this
				TriggerClientEvent('QBCore:Notify', src, 'You made a Corn Packet!', "success")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['corn_kernel'], "remove",4)
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['box'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['corn_packet'], "add")
			else
				TriggerClientEvent('QBCore:Notify', src, 'You need at least 1 Box!', "info") 
			end
		else    
			TriggerClientEvent('QBCore:Notify', src, 'You need at least 4 Corn Kernels!', "info")   
		end                                                                				
end)

RegisterServerEvent('osm-farming:ProcessOranges')
AddEventHandler('osm-farming:ProcessOranges', function()
	print('wow')
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)

		local item = Player.Functions.GetItemByName('orange')
		if item ~= nil then 
			if item.amount > 10 then 
				Player.Functions.RemoveItem('orange', math.random(5,10))----change this
				Player.Functions.RemoveItem('box', 1)----change this
				Player.Functions.AddItem('fruit_pack', 1)----change this
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['fruit_pack'], "add")
				TriggerClientEvent('QBCore:Notify', src, 'You made a Fruit Pack!', "success")   
			else 
				TriggerClientEvent('QBCore:Notify', src, 'You need atleast 10 Oranges!', "success")   
			end     
		else    
			TriggerClientEvent('QBCore:Notify', src, 'You need atleast 10 Oranges!', "success")   
		end                                                                				
end)

RegisterServerEvent('osm-farming:ProcessMilk')
AddEventHandler('osm-farming:ProcessMilk', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)

		local item = Player.Functions.GetItemByName('milk')
		if item ~= nil then 
			if item.amount > 5 then 
				Player.Functions.RemoveItem('milk', math.random(2,5))----change this
				Player.Functions.RemoveItem('box', 1)----change this
				Player.Functions.AddItem('milk_pack', 1)----change this
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['milk'], "remove")
				TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['milk_pack'], "add")
				TriggerClientEvent('QBCore:Notify', src, 'You made a Milk Carton!', "success")   
			else 
				TriggerClientEvent('QBCore:Notify', src, 'You need atleast 5 Milk!!', "success")   
			end     
		else    
			TriggerClientEvent('QBCore:Notify', src, 'You need atleast 5 Milk!', "success")   
		end                                                                				
end)

RegisterServerEvent('osm-farming:server:SpawnTractor')
AddEventHandler('osm-farming:server:SpawnTractor', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
		local cashamount = Player.PlayerData.money["cash"]

		if cashamount >= Config.TractorRent then
			Player.Functions.RemoveMoney('cash', Config.TractorRent) 
			TriggerClientEvent('SpawnTractor', src)
		else
			TriggerClientEvent('QBCore:Notify', src, 'You need $'..Config.TractorRent..' Cash to Rent a Tractor', "success")   
		end
end)

RegisterServerEvent('osm-farming:GiveOranges')
AddEventHandler('osm-farming:GiveOranges', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
		local amount = math.random(4, 7)
		Player.Functions.AddItem('orange', amount)----change this
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['orange'], "add",amount)
		-- TriggerClientEvent('QBCore:Notify', src, 'You got a few oranges from the Tree!', "success")                                                                         				
end)

RegisterServerEvent('Server:UnRentTractor')
AddEventHandler('Server:UnRentTractor', function()
		local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
		-- Player.Functions.RemoveMoney('bank', 1500, 'tractor')
		TriggerClientEvent('UnRentTractor', src)
end)

function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end

RegisterServerEvent('osm-farming:cancelProcessing')
AddEventHandler('osm-farming:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('osm-farming:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('osm-farming:onPlayerDeath')
AddEventHandler('osm-farming:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

QBCore.Functions.CreateCallback('osm-farming:server:GetSellingPrice', function(source, cb)
    local retval = 0
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Config.ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    retval = retval + (Config.ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                end
            end
        end
    end
    cb(retval)
end)
