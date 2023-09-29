local QBCore = exports['lrp-core']:GetCoreObject()

AddEventHandler('onResourceStart', function(resource) if GetCurrentResourceName() ~= resource then return end
	for k, v in pairs(Crafting) do for i = 1, #v do
			for l, b in pairs(v[i]) do if not QBCore.Shared.Items[l] then print("Crafting: Missing Item from QBCore.Shared.Items: '"..k.."'") end
				for j, c in pairs(b) do if not QBCore.Shared.Items[j] then print("Crafting: Missing Item from QBCore.Shared.Items: '"..j.."'") end end end end end
	for i = 1, #Config.Items.items do
		if not QBCore.Shared.Items[Config.Items.items[i].name] then print("Store: Missing Item from QBCore.Shared.Items: '"..Config.Items.items[i].name.."'") end
	end
	if not QBCore.Shared.Jobs["noodleexchange"] then print("Error: Job role not found - 'noodleexchange'") end
end)

--Consumables
CreateThread(function()
	local food = { 'springrolls', 'dragonrolls', 'saltandpepperchicken', 'ramen', 'noodlebowl', 'friednoodles' }
    for _, v in pairs(food) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-noodleexchange:client:Eat', source, item.name) end) end
	
	local drinks = { 'fantaslushy', 'bbobatea' }
    for _, v in pairs(drinks) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-noodleexchange:client:Drink', source, item.name) end) end
	
	local alcohol = { "soju" }
    for _, v in pairs(alcohol) do QBCore.Functions.CreateUseableItem(v, function(source, item) TriggerClientEvent('jim-noodleexchange:client:DrinkAlcohol', source, item.name) end) end
end)

---Crafting 
RegisterServerEvent('jim-noodleexchange:Crafting:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	if craftable["amount"] then amount = craftable["amount"] else amount = 1 end
	for k,v in pairs(craftable[ItemMake]) do
		TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(k)], "remove", v) 
		Player.Functions.RemoveItem(tostring(k), v)
		if Config.Debug then print("Removing "..tostring(k)) end
	end
	--This should give the item, while the rest removes the requirements
	Player.Functions.AddItem(ItemMake, amount)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ItemMake], "add", amount)
	if Config.Debug then print("Giving Player "..tostring(ItemMake).." x"..amount) end
end)

---ITEM REQUIREMENT CHECKS
QBCore.Functions.CreateCallback('jim-noodleexchange:Crafting:get', function(source, cb, item, craftable)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local hasitem = true
	local testtable = {}
	for k, v in pairs(craftable[item]) do testtable[k] = false end
	for k,v in pairs(craftable[item]) do
		if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(k).amount >= v then
			testtable[k] = true if Config.Debug then print(k.." (x"..v..") found") end
		end
	end
	for k, v in pairs(testtable) do
		if not v then hasitem = false if Config.Debug then print(QBCore.Shared.Items[k].label.." NOT found") end end
	end
	cb(hasitem)
end)

RegisterServerEvent("lrp-noodleexchange:bill:player")
AddEventHandler("lrp-noodleexchange:bill:player", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'noodleexchange' then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                       --if Config.SQL == 'oxmysql' then
                        MySQL.Async.insert('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (:citizenid, :amount, :society, :sender)', {
                            ['citizenid'] = billed.PlayerData.citizenid,
                            ['amount'] = amount,
                            ['society'] = biller.PlayerData.job.name,
                            ['sender'] = biller.PlayerData.citizenid,
                        })
                        --else
                          --exports.ghmattimysql:execute('INSERT INTO phone_invoices (citizenid, amount, society, sender) VALUES (@citizenid, @amount, @society, @sender)', {
                          --  ['@citizenid'] = billed.PlayerData.citizenid,
                          --  ['@amount'] = amount,
                          --  ['@society'] = biller.PlayerData.job.name,
                          --  ['@sender'] = biller.PlayerData.charinfo.firstname
                          -- })
                       --end
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Must Be A Valid Amount Above 0', 'error')
                    end
                else
                	TriggerClientEvent('QBCore:Notify', source, 'You Cannot Bill Yourself', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'Player Not Online', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'No Access', 'error')
        end
end)