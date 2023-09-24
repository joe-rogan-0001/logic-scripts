-- MADE BY OSMIUM | DISCORD.IO/OSMFX

local QBCore = exports['lrp-core']:GetCoreObject()

RegisterServerEvent('osm-mining:getItemNew')
AddEventHandler('osm-mining:getItemNew', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local washedstone = Player.Functions.GetItemByName("washedstone")

    for i=1, (washedstone.amount) do 
        if Player then
            local randomItem = Config.Items[math.random(1, #Config.Items)]
            local randomItemadd = math.random(1,3)
            --print(randomItemadd)
            Player.Functions.RemoveItem('washedstone', washedstone.amount)
            Player.Functions.AddItem(randomItem, randomItemadd)   ----chnage these to give different amounts once completed mining
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randomItem], 'add', randomItemadd)
        end
    end
end)

RegisterServerEvent('osm-mining:getStone')
AddEventHandler('osm-mining:getStone', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(2,6)  
    if Player then   
        Player.Functions.AddItem('stone', amount)   ----chnage these to give different amounts once completed mining
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stone'], 'add')
    end
end)

RegisterServerEvent("osm-mining:washing")
AddEventHandler("osm-mining:washing", function(x,y,z)
  	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
    local washedstone = Player.Functions.GetItemByName("stone")

	TriggerClientEvent("QBCore:Notify", src, "You wash all of your stone.", 5000)
	Player.Functions.RemoveItem('stone', washedstone.amount)
	Player.Functions.AddItem('washedstone', washedstone.amount)
	TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['stone'], "remove")
	TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['washedstone'], "add")
end)

local Objects = {}

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

RegisterNetEvent('mining:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("mining:client:spawnObject", src, objectId, type, src)
end)

RegisterNetEvent('mining:server:deleteObject', function(objectId)
    TriggerClientEvent('mining:client:removeObject', -1, objectId)
end)

---price of items to sell

local ItemList = {
    ["steel"] = math.random(100, 180),
    ["copper"] = math.random(40, 100),
    ["aluminum"] = math.random(60, 90),
    ["iron"] = math.random(70, 100),
    ["metalscrap"] = math.random(100, 160),
    ["plastic"] = math.random(15, 25),
    ["glass"] = math.random(70, 90),
    ["rubber"] = math.random(40, 50),
    ["sulfur"] = math.random(120, 140),
}

RegisterServerEvent('osm-mining:sell')
AddEventHandler('osm-mining:sell', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items and next(Player.PlayerData.items) then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] then 
                if ItemList[Player.PlayerData.items[k].name] then 
                    price = price + (ItemList[Player.PlayerData.items[k].name] * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                end
            end
        end
        if price >= 1 then 
        --TriggerEvent('qb-banking:server:sendPaycheck', price, src)
        --TriggerClientEvent('QBCore:Notify', -1, "You received a Paycheck, you can get it at the Pacific Standard Bank!", "success")
        Player.Functions.AddMoney("cash", price, "sold-items")
        TriggerClientEvent('QBCore:Notify', src, "You have sold your items")
        else 
            TriggerClientEvent('QBCore:Notify', src, "You dont have enough materials")
        end
    end
end)



QBCore.Functions.CreateCallback('lrp-mining:server:washedstoneamount', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local washedstone = Player.Functions.GetItemByName("washedstone")
    cb(washedstone.amount)
end)


QBCore.Functions.CreateCallback('lrp-mining:server:stoneamount', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local stone = Player.Functions.GetItemByName("stone")
    cb(stone.amount)
end)