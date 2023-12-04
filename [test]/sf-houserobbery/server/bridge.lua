---@diagnostic disable: duplicate-set-field
Bridge = {}

function Setup()
    local bridgeDetected = false
    if(GetResourceState("ox_inventory") ~= "missing") then
        bridgeDetected = true
        Bridge.AddItem = function(source, itemName, count)
            return exports['ox_inventory']:AddItem(source, itemName, count)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            return exports['ox_inventory']:RemoveItem(source, itemName, count)
        end
        Bridge.GetItemCount = function(source, itemName)
            return exports['ox_inventory']:GetItem(source, itemName, nil, true)
        end
    end
    if(GetResourceState("lrp-core") ~= "missing") then
        QBCore = exports['lrp-core']:GetCoreObject()
        bridgeDetected = true
        Bridge.AddItem = function(source, itemName, count)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return end
            if(itemName == "money") then
                ply.Functions.AddMoney("cash", count)
                return true
            end
            if(itemName == "bank") then
                ply.Functions.AddMoney("bank", count)
                return true
            end
            return ply.Functions.AddItem(itemName, count)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return end
            if(itemName == "money") then
                ply.Functions.RemoveMoney("cash", count)
                return true
            end
            if(itemName == "bank") then
                ply.Functions.RemoveMoney("bank", count)
                return true
            end
            ply.Functions.RemoveItem(itemName, count)
            return true
        end
        Bridge.GetItemCount = function(source, itemName)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return 0 end
            if(itemName == "money") then
                return ply.Functions.GetMoney("cash")
            end
            if(itemName == "bank") then
                return ply.Functions.GetMoney("bank")
            end
            local items = ply.Functions.GetItemsByName(itemName)
            local itemCount = 0
            for k, v in ipairs(items) do
                itemCount += v.count
            end
            return itemCount
        end
        Bridge.CheckJob = function(source, jobName, grade)
            local ply = QBCore.Functions.GetPlayer(source)
            if not ply then return false end
            return ply.PlayerData.job.name == jobName and ply.PlayerData.job.grade.level >= grade
        end
        Bridge.GetJobCount = function(jobName)
            local players, count = QBCore.Functions.GetPlayersOnDuty(jobName)
            return count
        end
        Bridge.GetJobPlayers = function(jobName)
            local players, count = QBCore.Functions.GetPlayersOnDuty(jobName)
            return players
        end
    end
    if(GetResourceState("es_extended") ~= "missing") then
        bridgeDetected = true
        ESX = nil
        if(ESXEvent) then
            while not ESX do
                TriggerEvent(ESXEvent, function(obj) ESX = obj end)
                Citizen.Wait(100)
            end
        else
            ESX = exports["es_extended"]:getSharedObject()
        end
        Bridge.AddItem = function(source, itemName, count)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            if(itemName == "money") then
                xPlayer.addMoney(count)
                return true
            end
            if(itemName == "bank") then
                xPlayer.addAccountMoney("bank", count)
                return true
            end
            return not (xPlayer.addInventoryItem(itemName, count) == false)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            if(itemName == "money") then
                xPlayer.removeMoney(count)
                return true
            end
            if(itemName == "bank") then
                xPlayer.removeAccountMoney("bank", count)
                return true
            end
            xPlayer.removeInventoryItem(itemName, count)
            return true
        end
        Bridge.GetItemCount = function(source, itemName)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            if(itemName == "money") then
                return xPlayer.getMoney()
            end
            if(itemName == "bank") then
                return xPlayer.getAccount("bank").money
            end
            return xPlayer.getInventoryItem(itemName)?.count or 0
        end
        Bridge.CheckJob = function(source, jobName, grade)
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return end
            return xPlayer.getJob().name == jobName and xPlayer.getJob().grade >= grade
        end
        Bridge.GetJobCount = function(jobName)
            local xPlayers = ESX.GetPlayers()
            local count = 0
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer and xPlayer.job.name == jobName then
                    count = count + 1
                end
            end
            return count
        end
        Bridge.GetJobPlayers = function(jobName)
            local xPlayers = ESX.GetPlayers()
            local players = {}
            for i=1, #xPlayers, 1 do
                local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                if xPlayer and xPlayer.job.name == jobName then
                    players[#players+1] = xPlayers[i]
                end
            end
            return players
        end
    end
    if(GetResourceState("qs-inventory") ~= "missing") then
        bridgeDetected = true
        Bridge.AddItem = function(source, itemName, count)
            return exports['qs-inventory']:AddItem(source, itemName, count)
        end
        Bridge.RemoveItem = function(source, itemName, count)
            return exports['qs-inventory']:RemoveItem(source, itemName, count)
        end
        Bridge.GetItemCount = function(source, itemName)
            return exports['qs-inventory']:GetItemTotalAmount(source, itemName)
        end
    end
    if(not bridgeDetected) then
        print("^3Could not detect inventory/framework, script will work in standalone mode")
        Bridge.AddItem = function(source, itemName, count)
            -- here you can hook up your own inventory
            return true
        end
        Bridge.RemoveItem = function(source, itemName, count)
            -- here you can hook up your own inventory
            return true
        end
        Bridge.GetItemCount = function(source, itemName)
            -- here you can hook up your own inventory
            return 99999
        end
        Bridge.CheckJob = function(source, jobName, grade)
            -- here you can hook up your custom framework job check (Required for legal job scripts)
            return true
        end
    end
end

Setup()