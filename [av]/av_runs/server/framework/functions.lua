function registerStash(name, label, slots, weight)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:RegisterStash(name, label, slots, weight)
        Wait(1000)
    end
end

function addTrunkItem(name, item, count, metadata)
    if Config.Inventory == "ox_inventory" then
        local success, response = exports.ox_inventory:AddItem(name, item, count, metadata, 1)
        return
    end
    local itemList = {}
    local newItem = QBCore.Shared.Items[item]
    if newItem then
        newItem['amount'] = count
        newItem['info'] = metadata
        newItem['slot'] = 1
        itemList[#itemList+1] = newItem
        exports[Config.Inventory]:addTrunkItems(name, itemList)
    else
        print("[ERROR] Item "..name.." is not registered in your Framework!")
    end
end

function getStashItems(name)
    if Config.Inventory == "ox_inventory" then
        local inv = exports.ox_inventory:GetInventory(name)
        if inv and inv.items then
            return inv.items
        end
    else
        local items = exports[Config.Inventory]:GetStashItems(name)
        if items then
            return items
        end
    end
    return false
end

function wipeStash(name)
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:ClearInventory(name)
        return
    end
    exports[Config.Inventory]:WipeStash(name)
end

function addItem(src,item,amount,info)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.Functions.AddItem(item,amount,false,info) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
            return true
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer.canCarryItem(item,amount) then
            if Config.Inventory == "qs-inventory" then
                exports['qs-inventory']:AddItem(src, item, amount, info)
            else
                xPlayer.addInventoryItem(item,amount,info)
            end
            return true
        end
    end
    return false
end

-- Add Money
function addMoney(src, account, amount)
    if Config.Debug then
        print("addMoney(), source: "..src.. " account: "..account.." amount: "..amount)
    end
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            Player.Functions.AddMoney(account,amount)
        else
            print("[ERROR] addMoney() function couldn't find the player (?), source: "..src)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            xPlayer.addAccountMoney(account,amount)
        else
            print("[ERROR] addMoney() function couldn't find the player (?), source: "..src)
        end
    end
end

function getIdentifier(src)
    if Config.Framework == "QBCore" then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player then
            return Player.PlayerData.citizenid
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            return xPlayer.identifier
        end
    end
    return false
end

function getAllPlayers()
    local list = {}
    if Config.Framework == "QBCore" then
        local players = QBCore.Functions.GetQBPlayers()
        for k, v in pairs(players) do
            list[#list+1] = v.PlayerData.source
        end
    end
    if Config.Framework == "ESX" then
        local players = ESX.GetExtendedPlayers()
        for k, v in pairs(players) do
            list[#list+1] = v.source
        end
    end
    return list
end

-- Has item?
function hasItem(src,name,amount)
    local qty = 1
    if tonumber(amount) then
        qty = tonumber(amount)
    end
    if Config.Framework == "QBCore" then
        if Config.Inventory == "ox_inventory" then
            local item = exports.ox_inventory:GetItem(src, name, nil, true)
            if item and tonumber(item) >= qty then
                return true 
            end
        else
            return exports[Config.Inventory]:HasItem(src,name,qty)
        end
    elseif Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local item = xPlayer.getInventoryItem(name)
        if item and item['count'] >= qty then
            return true
        end
    end
    return false
end

function sendToDiscord(message)
    PerformHttpRequest(Config.Webhook, function() end, 'POST', json.encode({ username = 'AV Scripts', embeds = message}), { ['Content-Type'] = 'application/json' })
end