local QBCore = exports['lrp-core']:GetCoreObject()

local Objects = {}



RegisterServerEvent('qb-cokepicking:pickedUpcoke') --hero
AddEventHandler('qb-cokepicking:pickedUpcoke', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	    if 	TriggerClientEvent("QBCore:Notify", src, "Picked up some Coca leaf!!", "Success", 1000) then
		  local amount = math.random(2, 4)
		  Player.Functions.AddItem('cocaleaf', amount) 
		  TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items['cocaleaf'], "add")
	    end
end)


RegisterServerEvent('qb-cokepicking:processcoke')
AddEventHandler('qb-cokepicking:processcoke', function(posx,posy,posz)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local cokepaste = Player.Functions.GetItemByName("cokepaste")

	local process = "Cooking Coke"
	local time = Config.Delays.cokeProcessing
	
	if cokepaste ~= nil then 
        if cokepaste.amount >= 50  then

			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-coke:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end	
			TriggerClientEvent('lrp-drugs:client:processingcoke', source, process, time) 
			Wait(time)
			Player.Functions.RemoveItem('cokepaste', 50) 
			Player.Functions.AddItem('coke', 65)
			TriggerClientEvent('QBCore:Notify', src, 'Coke Processed', "success")  
		
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
        end
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)


RegisterServerEvent('qb-cokepicking:bagcoke')
AddEventHandler('qb-cokepicking:bagcoke', function(posx,posy,posz)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local coke = Player.Functions.GetItemByName("coke")
	local cokebag = Player.Functions.GetItemByName("empty_weed_bag")

	local process = "Bagging coke"
	local time = Config.Delays.cokeBagging
	
	if coke ~= nil and cokebag ~= nil then 
		
        if coke.amount >= 25 and cokebag.amount >= 5 then

			TriggerClientEvent('lrp-drugs:client:processingcoke', source, process, time) 
			Wait(time)
			Player.Functions.RemoveItem('coke', 25)
			Player.Functions.RemoveItem('empty_weed_bag', 5) 
			Player.Functions.AddItem('cokebaggy', 5)
			TriggerClientEvent('QBCore:Notify', src, 'Coke Bagged', "success")  
		
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
        end
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have the right items', "error") 
	end
end)





RegisterServerEvent('qb-cokepicking:processcokebrick')
AddEventHandler('qb-cokepicking:processcokebrick', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local coke	=  Player.Functions.GetItemByName("cokebaggy")
	local process = "Processing Brick of coke"
	local time = Config.Delays.cokeBrick
	
	if coke ~= nil  then 
        if coke.amount >= 100 then
			TriggerClientEvent('lrp-drugs:client:processingcoke', source, process, time) 
			Wait(time)
			Player.Functions.RemoveItem('coke', 100)
            Player.Functions.AddItem('coke_brick', 1)
			TriggerClientEvent('QBCore:Notify', src, 'Brick of coke Processed', "success")  
		
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough coke!', "error") 
        end
	else 
		TriggerClientEvent('QBCore:Notify', src, 'You don\'t have any coke!', "error") 
	end
end)







function CancelProcessing(playerId)
	if playersProcessingCannabis[playerId] then
		ClearTimeout(playersProcessingCannabis[playerId])
		playersProcessingCannabis[playerId] = nil
	end
end


RegisterServerEvent('qb-cokepicking:onPlayerDeath')
AddEventHandler('qb-cokepicking:onPlayerDeath', function(data)
	local src = source
	CancelProcessing(src)
end)

















 
local table = false
local barrel = false




------props

--Useable props

QBCore.Functions.CreateUseableItem("tent", function(source, item)
    local src = source
	TriggerClientEvent('lrp-drug:client:spawnTent', src)
	table = true
end)





QBCore.Functions.CreateUseableItem("table", function(source, item)
    local src = source
	if table then
   	 	TriggerClientEvent('lrp-drug:client:spawnTable', src)
		barrel = true
	else 	
		TriggerClientEvent('QBCore:Notify', src, "You need to place down a tent first!", 'error')
	end
end)

QBCore.Functions.CreateUseableItem("barrel", function(source, item)
    local src = source
	if barrel then
		TriggerClientEvent('lrp-drug:client:spawnBarrel', src)
		local table = false
		local barrel = false
	else 	
		TriggerClientEvent('QBCore:Notify', src, "You need to place down a table first!", 'error')
	end
   	 
end)





--object control

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end


RegisterNetEvent('lrp-drug:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("lrp-drug:client:spawnObject", src, objectId, type, src)
end)


RegisterNetEvent('lrp-drug:server:deleteObject', function(objectId)
    TriggerClientEvent('lrp-drug:client:removeObject', -1, objectId)
end)














---processes

RegisterServerEvent('lrp-coke:start')
AddEventHandler('lrp-coke:start', function()
	
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemcocaleaf = Player.Functions.GetItemByName("cocaleaf")
	if Itemcocaleaf  then
		if Itemcocaleaf.amount >= 80 then	
			Player.Functions.RemoveItem("cocaleaf", 80, false)
			TriggerClientEvent("lrp-coke:startprod", _source)
		else
		TriggerClientEvent('QBCore:Notify', source, "You don't have enough coca leaf!", 'error')
		end	
	else
	TriggerClientEvent('QBCore:Notify', source, "You don't have any coca leaf?", 'error')
	end	
end)






RegisterServerEvent('lrp-coke:finish')
AddEventHandler('lrp-coke:finish', function(quality)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local rnd = 2
	local quality2 = quality
	if quality2 >= 10 then
		xPlayer.Functions.AddItem('cokepaste', math.floor(quality2) * rnd)	
	else 
		TriggerClientEvent('QBCore:Notify', source, "The coke quality was way to bad!!!", 'error')
	end		
end)



RegisterServerEvent('lrp-coke:blow')
AddEventHandler('lrp-coke:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = QBCore.Functions.GetPlayers()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('lrp-coke:blowup', xPlayers[i],posx, posy, posz)
	end
	--xPlayer.Functions.RemoveItem('methlab', 1)
end)






------------------------------------------- ingredient parts

------cement

RegisterServerEvent('lrp-coke:cement')
AddEventHandler('lrp-coke:cement', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemcement = Player.Functions.GetItemByName("cement")

	if Itemcement ~= nil then
		if Itemcement.amount >= 3 then	
			Player.Functions.RemoveItem("cement", 3, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-coke:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing cement!", 'error')
			TriggerClientEvent('lrp-coke:stop', _source)
		end
	else
	TriggerClientEvent('lrp-coke:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing cement!", 'error')
	end	
end)


RegisterServerEvent('lrp-coke:cement3')
AddEventHandler('lrp-coke:cement3', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemcement = Player.Functions.GetItemByName("cement")

	if Itemcement ~= nil then
		if Itemcement.amount >= 6 then	
			Player.Functions.RemoveItem("cement", 6, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-coke:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing cement!", 'error')
			TriggerClientEvent('lrp-coke:stop', _source)
		end
	else
	TriggerClientEvent('lrp-coke:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing cement!", 'error')
	end	
end)









------hydrochloricacid

RegisterServerEvent('lrp-coke:hydrochloricacid')
AddEventHandler('lrp-coke:hydrochloricacid', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
	local Itemhydrochloricacid = Player.Functions.GetItemByName("hydrochloricacid")

	if Itemhydrochloricacid ~= nil then
		if Itemhydrochloricacid.amount >= 1 then	
			Player.Functions.RemoveItem("hydrochloricacid", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()	
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Hydrochloric Acid!", 'error')
			TriggerClientEvent('lrp-coke:stop', _source)
		end
	else
	TriggerClientEvent('lrp-coke:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Hydrochloric Acid!", 'error')
	end	
end)







------hydratedlime

RegisterServerEvent('lrp-coke:hydratedlime')
AddEventHandler('lrp-coke:hydratedlime', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
	local Itemhydratedlime = Player.Functions.GetItemByName("hydratedlime")

	if Itemhydratedlime ~= nil then
		if Itemhydratedlime.amount >= 2 then	
			Player.Functions.RemoveItem("hydratedlime", 2, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-coke:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Hydrated Lime!", 'error')
			TriggerClientEvent('lrp-coke:stop', _source)
		end
	else
	TriggerClientEvent('lrp-coke:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Hydrated Lime!", 'error')
	end	
end)





RegisterServerEvent('lrp-coke:hydratedlime4')
AddEventHandler('lrp-coke:hydratedlime4', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemhydratedlime = Player.Functions.GetItemByName("hydratedlime")
	if Itemhydratedlime ~= nil then
		if Itemhydratedlime.amount >= 4 then	
			Player.Functions.RemoveItem("hydratedlime", 4, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-coke:fire',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Hydrated Lime!", 'error')
			TriggerClientEvent('lrp-coke:stop', _source)
		end
	else
	TriggerClientEvent('lrp-coke:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Hydrated Lime!", 'error')
	end	
end)



------ammonia

RegisterServerEvent('lrp-coke:ammonia')
AddEventHandler('lrp-coke:ammonia', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemammonia = Player.Functions.GetItemByName("ammonia")

	if Itemammonia ~= nil then
		if Itemammonia.amount >= 1 then	
			Player.Functions.RemoveItem("ammonia", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
	
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Ammonia!", 'error')
			TriggerClientEvent('lrp-coke:stop', _source)
		end
	else
	TriggerClientEvent('lrp-coke:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Ammonia!", 'error')
	end	
end)


















