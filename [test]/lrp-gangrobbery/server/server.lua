local QBCore = exports['lrp-core']:GetCoreObject() 

local Cooldown = false

RegisterServerEvent('lrp-methrun:server:startr', function()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money['cash'] >= Config.RunCost then
		Player.Functions.RemoveMoney('cash', Config.RunCost)
        Player.Functions.AddItem("cratekey", 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cratekey"], "add")
		TriggerClientEvent("lrp-methrun:server:runactivate", src)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("success.send_email_right_now"), 'success')
        TriggerEvent('lrp-methrun:server:coolout')
	else
		TriggerClientEvent('QBCore:Notify', source, Lang:t("error.you_dont_have_enough_money"), 'error')
	end
end)

-- cool down for job
RegisterServerEvent('lrp-methrun:server:coolout', function()
    Cooldown = true
    local timer = Config.Cooldown * 1000
    while timer > 0 do
        Wait(1000)
        timer = timer - 1000
        if timer == 0 then
            Cooldown = false
        end
    end
end)

QBCore.Functions.CreateCallback("lrp-methrun:server:coolc",function(source, cb)
    if Cooldown then
        cb(true)
    else
        cb(false) 
    end
end)

RegisterServerEvent('lrp-methrun:server:unlock', function (playerped)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("gangcrate", 1)
    Player.Functions.RemoveItem("cratekey", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["gangcrate"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["cratekey"], "remove")

    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            TriggerClientEvent('gangrobbery:client:blipadd', playerped)
        end
    end
end)

--[[RegisterServerEvent('lrp-methrun:server:rewardpayout', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("meth_cured", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_cured"], "remove")

    Player.Functions.AddItem( Config.Bozo)

    local chance = math.random(1, 100)

    if chance >= 85 then
        Player.Functions.AddItem(Config.Item, Config.MethAmount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.Item], "add")
    end

    if chance >= 95 then
        Player.Functions.AddItem(Config.SpecialItem, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.SpecialItem], "add")
    end
end)]]

RegisterServerEvent('lrp-methrun:server:givecaseitems', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)

	Player.Functions.AddItem("meth_cured", 1)
    Player.Functions.RemoveItem("gangcrate", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_cured"], "add")
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["gangcrate"], "remove")
end)

local ItemTable = {
    "pistol_suppressor",
    "rifle_suppressor",
    "smg_extendedclip",
    "thermitec",
    "nightvisiongoggles",
    "pistol_ammo",
    "advancedlockpick",
    "radio",
    "thermiec"
}

RegisterNetEvent('lrp-methrun:server:rewardpayout', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem("meth_cured", 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["meth_cured"], "remove")
    for i = 1, math.random(4, 6), 1 do
        local randItem = ItemTable[math.random(1, #ItemTable)]
        local amount = math.random(1, 1)
        Player.Functions.AddItem(randItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[randItem], 'add')
        Wait(500)
    end

    local chance = math.random(1, 100)
    if chance < 70 then
        Player.Functions.AddItem("weapon_pistol50", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_pistol50"], "add")
    else 
        Player.Functions.AddItem("weapon_machinepistol", 1, false)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_machinepistol"], "add")
    end

    local Luck = math.random(1, 10)
    local Odd = math.random(1, 10)
    if Luck == Odd then
        local random = math.random(1, 1)
        Player.Functions.AddItem("weapon_stickybomb", random)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["weapon_stickybomb"], 'add')
    end

    local Luck = math.random(1, 5)
    local Odd = math.random(1, 5)
    if Luck == Odd then
        local random = math.random(1, 1)
        Player.Functions.AddItem("greendongle", random)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["greendongle"], 'add')
    end
end)
