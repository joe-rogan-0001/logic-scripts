local QBCore = exports['lrp-core']:GetCoreObject()

RegisterServerEvent('lrp-methcar:start')
AddEventHandler('lrp-methcar:start', function()
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemAcetone = Player.Functions.GetItemByName("acetone")
	local Itemphenylaceticacid = Player.Functions.GetItemByName("phenylaceticacid")
    local ItemLithium = Player.Functions.GetItemByName("lithium")
	local ItemMethlab = Player.Functions.GetItemByName("methlab")

	if ItemAcetone ~= nil and ItemLithium ~= nil and ItemMethlab ~= nil and Itemphenylaceticacid ~= nil then
		if ItemAcetone.amount >= 5 and ItemLithium.amount >= 2 and ItemMethlab.amount >= 1 and Itemphenylaceticacid.amount >= 1 then	
			TriggerClientEvent("lrp-methcar:startprod", _source)
			Player.Functions.RemoveItem("acetone", 5, false)
			Player.Functions.RemoveItem("lithium", 2, false)
			Player.Functions.RemoveItem("phenylaceticacid", 1, false)
		else
		TriggerClientEvent('QBCore:Notify', source, "U don't have enough ingredients to cook!", 'error')
		end	
	else
	TriggerClientEvent('QBCore:Notify', source, "You're missing essential ingredients!", 'error')
	end	
end)

RegisterServerEvent('lrp-methcar:stopf')
AddEventHandler('lrp-methcar:stopf', function(id)
local _source = source
	local xPlayers = QBCore.Functions.GetPlayers()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('lrp-methcar:stopfreeze', xPlayers[i], id)
	end	
end)

RegisterServerEvent('lrp-methcar:make')
AddEventHandler('lrp-methcar:make', function(posx,posy,posz)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	if xPlayer.Functions.GetItemByName('methlab') ~= nil then
		if xPlayer.Functions.GetItemByName('methlab').amount >= 1 then	
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('QBCore:Notify', source, "You're missing a lab!", 'error')
	end	
end)

RegisterServerEvent('lrp-methcar:finish')
AddEventHandler('lrp-methcar:finish', function(qualtiy)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local rnd = math.random(-5, 5)
	xPlayer.Functions.AddItem('meth', math.floor(qualtiy / 2) + rnd)	
end)

RegisterServerEvent('lrp-methcar:blow')
AddEventHandler('lrp-methcar:blow', function(posx, posy, posz)
	local _source = source
	local xPlayers = QBCore.Functions.GetPlayers()
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	for i=1, #xPlayers, 1 do
		TriggerClientEvent('lrp-methcar:blowup', xPlayers[i],posx, posy, posz)
	end
	xPlayer.Functions.RemoveItem('methlab', 1)
end)
















------------------------------------------- ingredient parts

------Methylamine

RegisterServerEvent('lrp-methcar:Methylamine')
AddEventHandler('lrp-methcar:Methylamine', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemmethylamine = Player.Functions.GetItemByName("methylamine")

	if Itemmethylamine ~= nil then
		if Itemmethylamine.amount >= 1 then	
			Player.Functions.RemoveItem("methylamine", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing methylamine!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing methylamine!", 'error')
	end	
end)


RegisterServerEvent('lrp-methcar:Methylamine2')
AddEventHandler('lrp-methcar:Methylamine2', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemmethylamine = Player.Functions.GetItemByName("methylamine")

	if Itemmethylamine ~= nil then
		if Itemmethylamine.amount >= 1 then	
			Player.Functions.RemoveItem("methylamine", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing methylamine!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing methylamine!", 'error')
	end	
end)

RegisterServerEvent('lrp-methcar:Methylamine3')
AddEventHandler('lrp-methcar:Methylamine3', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local Itemmethylamine = Player.Functions.GetItemByName("methylamine")

	if Itemmethylamine ~= nil then
		if Itemmethylamine.amount >= 3 then	
			Player.Functions.RemoveItem("methylamine", 3, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing methylamine!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing methylamine!", 'error')
	end	
end)









------Methanol

RegisterServerEvent('lrp-methcar:Methanol')
AddEventHandler('lrp-methcar:Methanol', function(posx,posy,posz)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local ItemMethanol = Player.Functions.GetItemByName("methanol")

	if ItemMethanol ~= nil then
		if ItemMethanol.amount >= 1 then	
			Player.Functions.RemoveItem("methanol", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Methanol!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Methanol!", 'error')
	end	
end)


RegisterServerEvent('lrp-methcar:Methanol2')
AddEventHandler('lrp-methcar:Methanol2', function(posx,posy,posz)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local ItemMethanol = Player.Functions.GetItemByName("methanol")

	if ItemMethanol ~= nil then
		if ItemMethanol.amount >= 1 then	
			Player.Functions.RemoveItem("methanol", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Methanol!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Methanol!", 'error')
	end	
end)




------Phosphorus

RegisterServerEvent('lrp-methcar:Phosphorus')
AddEventHandler('lrp-methcar:Phosphorus', function(posx,posy,posz)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(tonumber(source))
	local ItemPhosphorus = Player.Functions.GetItemByName("redphosphorus")

	if ItemPhosphorus ~= nil then
		if ItemPhosphorus.amount >= 1 then	
			Player.Functions.RemoveItem("redphosphorus", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Phosphorus!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Phosphorus!", 'error')
	end	
end)


RegisterServerEvent('lrp-methcar:Phosphorus2')
AddEventHandler('lrp-methcar:Phosphorus2', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemPhosphorus = Player.Functions.GetItemByName("redphosphorus")

	if ItemPhosphorus ~= nil then
		if ItemPhosphorus.amount >= 1 then	
			Player.Functions.RemoveItem("redphosphorus", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Phosphorus!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Phosphorus!", 'error')
	end	
end)


RegisterServerEvent('lrp-methcar:phosphorus4')
AddEventHandler('lrp-methcar:phosphorus4', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemPhosphorus = Player.Functions.GetItemByName("redphosphorus")
	print("fire")
	if ItemPhosphorus ~= nil then
		if ItemPhosphorus.amount >= 2 then	
			Player.Functions.RemoveItem("redphosphorus", 2, false)
			Player.Functions.RemoveItem('methlab', 1)
			local xPlayers = QBCore.Functions.GetPlayers()
			
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:fire',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Phosphorus!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Phosphorus!", 'error')
	end	
end)



------Pseudoephedrine

RegisterServerEvent('lrp-methcar:Pseudoephedrine')
AddEventHandler('lrp-methcar:Pseudoephedrine', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemPseudoephedrine = Player.Functions.GetItemByName("pseudoephedrine")

	if ItemPseudoephedrine ~= nil then
		if ItemPseudoephedrine.amount >= 1 then	
			Player.Functions.RemoveItem("pseudoephedrine", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Pseudoephedrine!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Pseudoephedrine!", 'error')
	end	
end)


RegisterServerEvent('lrp-methcar:Pseudoephedrine2')
AddEventHandler('lrp-methcar:Pseudoephedrine2', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemPseudoephedrine = Player.Functions.GetItemByName("pseudoephedrine")

	if ItemPseudoephedrine ~= nil then
		if ItemPseudoephedrine.amount >= 1 then	
			Player.Functions.RemoveItem("pseudoephedrine", 1, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:smoke',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Pseudoephedrine!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Pseudoephedrine!", 'error')
	end	
end)



RegisterServerEvent('lrp-methcar:Pseudoephedrine3')
AddEventHandler('lrp-methcar:Pseudoephedrine3', function(posx,posy,posz)
	local _source = source
	local Player = QBCore.Functions.GetPlayer(source)
	local ItemPseudoephedrine = Player.Functions.GetItemByName("pseudoephedrine")

	if ItemPseudoephedrine ~= nil then
		if ItemPseudoephedrine.amount >= 2 then	
			Player.Functions.RemoveItem('methlab', 1)
			Player.Functions.RemoveItem("pseudoephedrine", 2, false)
			local xPlayers = QBCore.Functions.GetPlayers()
			for i=1, #xPlayers, 1 do
				TriggerClientEvent('lrp-methcar:fire',xPlayers[i],posx,posy,posz, 'a') 
			end		
		else
			TriggerClientEvent('QBCore:Notify', source, "You're missing Pseudoephedrine!", 'error')
			TriggerClientEvent('lrp-methcar:stop', _source)
		end
	else
	TriggerClientEvent('lrp-methcar:stop', _source)
	TriggerClientEvent('QBCore:Notify', source, "You're missing Pseudoephedrine!", 'error')
	end	
end)