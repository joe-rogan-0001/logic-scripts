local VehicleNitrous = {}
local QBCore = exports['lrp-core']:GetCoreObject()

RegisterNetEvent('tackle:server:TacklePlayer', function(playerId)
    TriggerClientEvent("tackle:client:GetTackled", playerId)
end)

QBCore.Functions.CreateCallback('nos:GetNosLoadedVehs', function(source, cb)
    cb(VehicleNitrous)
end)

QBCore.Commands.Add("id", "Check Your ID #", {}, false, function(source, args)
    local src = source
    TriggerClientEvent('QBCore:Notify', src,  "ID: "..src)
end)

QBCore.Functions.CreateUseableItem("harness", function(source, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('seatbelt:client:UseHarness', src, item)
end)

RegisterNetEvent('equip:harness', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.items[item.slot].info.uses - 1 == 0 then
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['harness'], "remove")
        Player.Functions.RemoveItem('harness', 1)
    else
        Player.PlayerData.items[item.slot].info.uses = Player.PlayerData.items[item.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('seatbelt:DoHarnessDamage', function(hp, data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if hp == 0 then
        Player.Functions.RemoveItem('harness', 1, data.slot)
    else
        Player.PlayerData.items[data.slot].info.uses = Player.PlayerData.items[data.slot].info.uses - 1
        Player.Functions.SetInventory(Player.PlayerData.items)
    end
end)

RegisterNetEvent('qb-carwash:server:washCar', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('cash', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    elseif Player.Functions.RemoveMoney('bank', Config.DefaultPrice, "car-washed") then
        TriggerClientEvent('qb-carwash:client:washCar', src)
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have enough money..', 'error')
    end
end)

QBCore.Functions.CreateCallback('smallresources:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

RegisterNetEvent("stopsign:server:additem")
AddEventHandler("stopsign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("stopsign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['stopsign'], "add")
end)

RegisterNetEvent("walkingmansign:server:additem")
AddEventHandler("walkingmansign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("walkingmansign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['walkingmansign'], "add")
end)

RegisterNetEvent("dontblockintersectionsign:server:additem")
AddEventHandler("dontblockintersectionsign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("dontblockintersectionsign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['dontblockintersectionsign'], "add")
end)

RegisterNetEvent("uturnsign:server:additem")
AddEventHandler("uturnsign:server:additem", function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(tonumber(src))

	xPlayer.Functions.AddItem("uturnsign", 1, false)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['uturnsign'], "add")
end)

RegisterNetEvent('vehicle:flipit')
AddEventHandler('vehicle:flipit', function()
    TriggerClientEvent('vehicle:flipit')
end)

AddEventHandler('chatMessage', function(source, name, msg)
    local src = source
    local msg = msg

    if msg == "/-playerFocus" or msg == "/+playerFocus" then
        return
    else
        TriggerEvent("qb-log:server:CreateLog", "ooc", "Chat", "green", "**Player: **"..GetPlayerName(src) .. "\n**Message: **" .. msg)
    end
end)

QBCore.Functions.CreateUseableItem("nightvisiongoggles", function(source)
    local player = QBCore.Functions.GetPlayer(source)
        if player ~= nil then 
            TriggerClientEvent("lrp-nightvision:toggle", source)
        end 
end)

QBCore.Functions.CreateUseableItem("id_card", function(source,item)
    local src = source
    local PlayerPed = GetPlayerPed(source)
    local PlayerCoords = GetEntityCoords(PlayerPed)
    
    local data = {
		['DOB'] = item.info.birthdate,
		['Name'] = item.info.firstname,
		['Surname'] = item.info.lastname,
		['Sex'] = item.info.gender,
		['Identifier'] = item.info.citizenid,
		['pref'] = "sex"
	}

    if data.Sex == 0 then
        data.pref = "Male"
        data.Sex = "M"
    else
        data.Sex = "F"
        data.pref = "Female"
    end
    
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local TargetPed = GetPlayerPed(v)
        local dist = #(PlayerCoords - GetEntityCoords(TargetPed))
        if dist < 3.0 then
            TriggerClientEvent('chat:showCID', v, data)
        end
    end
    --TriggerClientEvent("chat:showCID", -1, data, src)
end)