local QBCore = exports['lrp-core']:GetCoreObject()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        GenerateVehicleList()
        Citizen.Wait((1000 * 60) * 60)
    end
end)


RegisterNetEvent('qb-scrapyard:server:LoadVehicleList', function()
    local src = source
    TriggerClientEvent("qb-scapyard:client:setNewVehicles", src, Config.CurrentVehicles)
end)


QBCore.Functions.CreateCallback('qb-scrapyard:checkOwnerVehicle', function(source, cb, plate)
    local result = MySQL.Sync.fetchScalar("SELECT `plate` FROM `player_vehicles` WHERE `plate` = ?",{plate})
    if result then
        cb(false)
    else
        cb(true)
    end
end)


RegisterNetEvent('qb-scrapyard:server:ScrapVehicle', function(listKey)
    if Config.CurrentVehicles[listKey] ~= nil then
        Config.CurrentVehicles[listKey] = nil
        TriggerClientEvent("qb-scapyard:client:setNewVehicles", -1, Config.CurrentVehicles)
    end
end)

RegisterNetEvent('qb-scrapyard:server:removedoor', function(vehiclebeingscrapped, doortype)
    TriggerClientEvent("lrp-scraping:client:removedoor", -1, vehiclebeingscrapped, doortype)
end)

RegisterNetEvent('lrp-scrapyard:server:sellcar', function(part)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney("cash", math.random(500, 1200))
end)

RegisterNetEvent('lrp-scrapyard:server:sellpart', function(part)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if part ~= nil then
        if part == "driverdoorf" or part == "passengerdoorf" or part == "driverdoorr" or part == "passengerdoorr" then
            for i = 1, 2, 1 do
                local item = Config.DoorItems[math.random(1, #Config.DoorItems)]
                local amount =  math.random(4, 6)
                Player.Functions.AddItem(item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
                Citizen.Wait(500)
            end
        elseif part == "bonnet" or part == "boot" then
            for i = 1, 2, 1 do
                local item = Config.DoorItems2[math.random(1, #Config.DoorItems2)]
                local amount =  math.random(5, 8)
                Player.Functions.AddItem(item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
                Citizen.Wait(500)
            end
        elseif part == "tire" then
            for i = 1, #Config.tireItems, 1 do
                local item = Config.tireItems[math.random(1, #Config.tireItems)]
                local amount =  math.random(7, 11)
                Player.Functions.AddItem(item, amount)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add', amount)
                Citizen.Wait(500)
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 'You dont have any vehicle parts to sell', 'error')
    end
end)

function GenerateVehicleList()
    Config.CurrentVehicles = {}
    for i = 1, math.random(14, 25), 1 do
        local randVehicle = Config.Vehicles[math.random(1, #Config.Vehicles)]
        if not IsInList(randVehicle) then
            Config.CurrentVehicles[i] = randVehicle
        end
    end
    TriggerClientEvent("qb-scapyard:client:setNewVehicles", -1, Config.CurrentVehicles)
end

function IsInList(name)
    local retval = false
    if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then
        for k, v in pairs(Config.CurrentVehicles) do
            if Config.CurrentVehicles[k] == name then
                retval = true
            end
        end
    end
    return retval
end


QBCore.Functions.CreateCallback('lrp-scrap:server:getCops', function(source, cb)
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

