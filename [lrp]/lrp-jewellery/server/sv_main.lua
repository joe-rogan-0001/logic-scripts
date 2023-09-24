local QBCore = exports['lrp-core']:GetCoreObject()

-- Code

local timeOut = false

local alarmTriggered = false


RegisterServerEvent('lrp-jewellery:server:setVitrineState')
AddEventHandler('lrp-jewellery:server:setVitrineState', function(stateType, state, k)
end)

RegisterServerEvent('lrp-jewellery:server:vitrineReward')
AddEventHandler('lrp-jewellery:server:vitrineReward', function()
end)


QBCore.Functions.CreateCallback('lrp-jewellery:vitrineReward', function(source, cb)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local otherchance = math.random(1, 4)
    local odd = math.random(1, 4)

    if otherchance == odd then
        local item = math.random(1, #Config.VitrineRewards)
        local amount = math.random(Config.VitrineRewards[item]["amount"]["min"], Config.VitrineRewards[item]["amount"]["max"])
        if Player.Functions.AddItem(Config.VitrineRewards[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.VitrineRewards[item]["item"]], 'add')
            TriggerEvent("qb-log:server:CreateLog", 'jewellery', "Jewellery Loot", "yellow", "**"..Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *(" .. Player.PlayerData.source .. "))*: has looted " ..amount.. " x "..Config.VitrineRewards[item]["item"])  
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have too much in your pocket..', 'error')
        end
    else
        local amount = math.random(Config.VitrineRewards[3]["amount"]["min"], Config.VitrineRewards[3]["amount"]["max"])
        if Player.Functions.AddItem("goldchain", amount) then
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["goldchain"], 'add')
            TriggerEvent("qb-log:server:CreateLog", 'jewellery', "Jewellery Loot", "yellow", "**"..Player.PlayerData.name .. "** (citizenid: *" .. Player.PlayerData.citizenid .. "* | id: *(" .. Player.PlayerData.source .. "))*: has looted " ..amount.. " x ".."goldchain")  
        else
            TriggerClientEvent('QBCore:Notify', src, 'You have too much in your pocket..', 'error')
        end
    end
end)	

QBCore.Functions.CreateCallback('lrp-jewellery:server:setVitrineState', function(source, cb, stateType, state, k)
	Config.Locations[k][stateType] = state
    TriggerClientEvent('lrp-jewellery:client:setVitrineState', -1, stateType, state, k)
end)

QBCore.Functions.CreateCallback('lrp-jewellery:server:setTimeout', function(source, cb)
	if not timeOut then
        timeOut = true
        TriggerEvent('qb-scoreboard:server:SetActivityBusy', "jewellery", true)
        Citizen.CreateThread(function()
            Citizen.Wait(Config.Timeout)

            for k, v in pairs(Config.Locations) do
                Config.Locations[k]["isOpened"] = false
                TriggerClientEvent('lrp-jewellery:client:setVitrineState', -1, 'isOpened', false, k)
                TriggerClientEvent('lrp-jewellery:client:setAlertState', -1, false)
                --TriggerEvent('qb-scoreboard:server:SetActivityBusy', "jewellery", false)
            end
            timeOut = false
            alarmTriggered = false
        end)
    end
end)

--QBCore.Functions.CreateCallback('lrp-jewellery:server:PoliceHackMessage', function(source, cb, title, coords, blip)
	--TriggerClientEvent('un-dispatch:jewelrobbery')
--end)
local cooldown = false

RegisterServerEvent('lrp-jewellery:server:setTimeout')
AddEventHandler('lrp-jewellery:server:setTimeout', function()
end)

RegisterServerEvent('lrp-jewellery:server:cooldown')
AddEventHandler('lrp-jewellery:server:cooldown', function()
    if not cooldown then
        cooldown = true
        Citizen.CreateThread(function()
            Wait(2700000)         
            cooldown = false
        end)
    end
end)

RegisterServerEvent('lrp-jewellery:server:PoliceAlertMessage')
AddEventHandler('lrp-jewellery:server:PoliceAlertMessage', function(title, coords, blip)
end)

QBCore.Functions.CreateCallback('lrp-jewellery:server:getCops', function(source, cb)
	local amount = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local Player = QBCore.Functions.GetPlayer(v)
        if Player ~= nil then 
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                amount = amount + 1
            end
        end
	end
	cb(amount)
end)

QBCore.Functions.CreateCallback('lrp-jewellery:server:ExchangeFail', function(source, cb)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName("electronickit")
    --local ItemData2 = Player.Functions.GetItemByName("trojan_usb")

    if ItemData then
        Player.Functions.RemoveItem("electronickit", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["electronickit"], "remove")
        --Player.Functions.RemoveItem("trojan_usb", 1)
        --TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["trojan_usb"], "remove")
        TriggerClientEvent('QBCore:Notify', src, "Attempt failed, your electronics shortcircuited..", 'error', 5000)
    end
end)

QBCore.Functions.CreateCallback('lrp-jewellery:server:ExchangeSuccess', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName("electronickit")
    --local ItemData2 = Player.Functions.GetItemByName("trojan_usb")

    if ItemData then
        Player.Functions.RemoveItem("electronickit", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["electronickit"], "remove")
        --Player.Functions.RemoveItem("trojan_usb", 1)
        --TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["trojan_usb"], "remove")
        TriggerClientEvent('QBCore:Notify', src, "You succesfully hacked the security", "success", 3500)
    end
end)

QBCore.Functions.CreateCallback('lrp-jewellery:server:ExchangeSuccess2', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName("security_card_04")

    if ItemData ~= nil then
        Player.Functions.RemoveItem("security_card_04", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["security_card_04"], "remove")
    end
end)

QBCore.Functions.CreateCallback('lrp-jewellery:server:HasHack', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local Item = Player.Functions.GetItemByName("electronickit")
    --local Item2 = Player.Functions.GetItemByName("trojan_usb")

    if cooldown then
        TriggerClientEvent('lrp-notify:Alert', src, "Vangellico Store", "The store is currently underlock down come back later!", 2000, 'info')
    else
        if Item then
            cb(true)
        else
            cb(false)
        end
    end
end)

--[[
QBCore.Functions.CreateUseableItem("security_card_04", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemByName('security_card_04') ~= nil then
        TriggerClientEvent("lrp-jewellery:client:UsePinkCard", source)
    end
end)
]]--