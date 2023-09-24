local QBCore = exports['lrp-core']:GetCoreObject()
local Objects = {}
local ObjectList = {}



QBCore.Functions.CreateCallback("lrp-crafting:server:weapon", function(source, cb, weapons)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
   
    local result = MySQL.Sync.fetchScalar('SELECT weapons FROM players WHERE citizenid = ?', {pData.PlayerData.citizenid})

    if string.match(result, weapons) then
        cb(true)
    else
        cb(false)
    end

end)






RegisterNetEvent('lrp-crafting:server:updateobjects', function(objectId, spawnedObj, x, y, z)
    ObjectList[objectId] = {
        id = objectId,
        object = spawnedObj,
        coords = {
            x = x,
            y = y,
            z = z,
        },
    }
end)

RegisterNetEvent('lrp-crafting:server:givebackitem', function(item)
    local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
    if item == -1065766299 then
        Player.Functions.AddItem('campfire', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['campfire'], "add", 1)

    elseif item == 1515457234 then
        Player.Functions.AddItem('pestle', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['pestle'], "add", 1)

    end
end)
 



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


RegisterNetEvent('lrp-crafting:server:spawnObject', function(type)
    
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("lrp-crafting:client:spawnObject", src, objectId, type, src)

end)


RegisterNetEvent('lrp-crafting:server:deleteObject', function(objectId) 
    TriggerClientEvent('lrp-crafting:client:removeObject', -1, objectId, ObjectList[objectId])
    ObjectList[objectId] = nil  
end)



QBCore.Functions.CreateUseableItem("pestle", function(source, item)
    local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('lrp-crafting:client:spawnpestle', src)
    Player.Functions.RemoveItem('pestle', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['pestle'], "remove", 1)
	table = true
end)


QBCore.Functions.CreateUseableItem("campfire", function(source, item)
    local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('lrp-crafting:client:spawncampfire', src)
    Player.Functions.RemoveItem('campfire', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['campfire'], "remove", 1)
	table = true
end)








RegisterNetEvent('lrp-crafting:server:gunpowder', function()
	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
    local sulfur = Player.Functions.GetItemByName("sulfur")
    local charcoal = Player.Functions.GetItemByName("charcoal")

    if sulfur ~= nil and charcoal ~= nil then
        if sulfur.amount >= 3 and charcoal.amount >= 10 then
            TriggerClientEvent("QBCore:Notify", src, "You made gun powder.", 5000)
            Player.Functions.RemoveItem('sulfur', 3)
            Player.Functions.RemoveItem('charcoal', 10)
            local amount = math.random(3, 5)
            Player.Functions.AddItem('gunpowder', amount)

            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['sulfur'], "remove", 3)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['charcoal'], "remove", 10)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['gunpowder'], "add", amount)
        else
            TriggerClientEvent("QBCore:Notify", src, "You need 3 sulfur and 10 charcol to make gun powder.", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You need sulfur and charcol to make gun powder.", "error")
    end

end)


RegisterNetEvent('lrp-crafting:server:charcoal', function()
	local src = source
  	local Player = QBCore.Functions.GetPlayer(src)
    local wood = Player.Functions.GetItemByName("tree_lumber")
    if wood ~= nil then
        if wood.amount >= 3 then
            TriggerClientEvent("QBCore:Notify", src, "You made Charcoal.", 5000)
            Player.Functions.RemoveItem('tree_lumber', 3)
            local amount = math.random(20, 35)
            Player.Functions.AddItem('charcoal', amount)

            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['tree_lumber'], "remove", 3)
            TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['charcoal'], "add", amount)
        else
            TriggerClientEvent("QBCore:Notify", src, "You need 3 Lumber to make charcoal.", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", src, "You need lumber to make charcoal.", "error")
    end

end)






QBCore.Functions.CreateCallback("lrp-crafting:server:deleteObject", function(source, cb, pos)

    local src = source
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
    cb(current, dist)
    dist = nil
    current = nil
end)


































