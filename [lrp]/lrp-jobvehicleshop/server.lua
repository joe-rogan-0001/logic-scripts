-- Variables
local QBCore = exports['lrp-core']:GetCoreObject()
local financetimer = {}
local paymentDue = false

-- Handlers

-- Store game time for player when they load
RegisterNetEvent('qb-jobvehicleshop:server:addPlayer', function(citizenid, gameTime)
    financetimer[citizenid] = gameTime
end)

-- Deduct stored game time from player on logout
RegisterNetEvent('qb-jobvehicleshop:server:removePlayer', function(citizenid)
    if financetimer[citizenid] then
        local playTime = financetimer[citizenid]
        local financetime = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ?', {citizenid})
        for k,v in pairs(financetime) do
            if v.balance >= 1 then
                local newTime = math.floor(v.financetime - (((GetGameTimer() - playTime) / 1000) / 60))
                if newTime < 0 then newTime = 0 end
                MySQL.Async.execute('UPDATE player_vehicles SET financetime = ? WHERE plate = ?', {newTime, v.plate})
            end
        end
    end
    financetimer[citizenid] = {}
end)


-- Functions

local function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

local function calculateFinance(vehiclePrice, downPayment, paymentamount)
    local balance = vehiclePrice - downPayment
    local vehPaymentAmount = balance / paymentamount
    return round(balance), round(vehPaymentAmount)
end

local function calculateNewFinance(paymentAmount, vehData)
    local newBalance = tonumber(vehData.balance - paymentAmount)
    local minusPayment = vehData.paymentsLeft - 1
    local newPaymentsLeft = newBalance / minusPayment
    local newPayment = newBalance / newPaymentsLeft
    return round(newBalance), round(newPayment), newPaymentsLeft
end

local function GeneratePlate()
    local plate = QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(2)
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    if result then
        return GeneratePlate()
    else
        return plate:upper()
    end
end

local function comma_value(amount)
    local formatted = amount
    while true do
      formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')
      if (k==0) then
        break
      end
    end
    return formatted
end

-- Callbacks

QBCore.Functions.CreateCallback('qb-jobvehicleshop:server:getVehicles', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if player then
        local vehicles = MySQL.Sync.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ?', {player.PlayerData.citizenid})
        if vehicles[1] then
            cb(vehicles)
        end
    end
end)

-- Events

-- Sync vehicle for other players
RegisterNetEvent('qb-jobvehicleshop:server:swapVehicle', function(data)
    local src = source
    TriggerClientEvent('qb-jobvehicleshop:client:jobswapVehicle', -1, data)

    Wait(1500) -- let new car spawn
    TriggerClientEvent('qb-jobvehicleshop:client:homeMenu', src) -- reopen main menu
end)








-- Buy public vehicle outright
RegisterNetEvent('qb-jobvehicleshop:server:buyShowroomVehicle', function(vehicle)
    local src = source
    local vehicle = vehicle.buyVehicle
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local cash = pData.PlayerData.money['cash']
    local bank = pData.PlayerData.money['bank']
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
    local plate = GeneratePlate()
    if cash > vehiclePrice then
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, job, vehicle, hash, mods, plate, garage, jobstate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            pData.PlayerData.job.name,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            pData.PlayerData.job.name,
            1
        })
        TriggerClientEvent('QBCore:Notify', src, 'Congratulations on your purchase!', 'success')
        TriggerClientEvent('qb-jobvehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney('cash', vehiclePrice, 'vehicle-bought-in-showroom')
    elseif bank > vehiclePrice then
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, job, vehicle, hash, mods, plate, garage, jobstate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            pData.PlayerData.job.name,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            pData.PlayerData.job.name,
            1
        })
        TriggerClientEvent('QBCore:Notify', src, 'Congratulations on your purchase!', 'success')
        TriggerClientEvent('qb-jobvehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney('bank', vehiclePrice, 'vehicle-bought-in-showroom')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
    end
end)




RegisterNetEvent('qb-jobvehicleshop:server:buyShowroomVehiclepersonal', function(vehicle)
    local src = source
    local vehicle = vehicle.buyVehicle
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local cash = pData.PlayerData.money['cash']
    local bank = pData.PlayerData.money['bank']
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
    local plate = GeneratePlate()
    if cash > vehiclePrice then
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, job, vehicle, hash, mods, plate, garage, jobstate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            "personaljobveh",
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            pData.PlayerData.job.name,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, 'Congratulations on your purchase!', 'success')
        TriggerClientEvent('qb-jobvehicleshop:client:buyShowroomVehiclepersonal', src, vehicle, plate)
        pData.Functions.RemoveMoney('cash', vehiclePrice, 'vehicle-bought-in-showroom')
    elseif bank > vehiclePrice then
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, job, vehicle, hash, mods, plate, garage, jobstate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            "personaljobveh",
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            pData.PlayerData.job.name,
            0
        })
        TriggerClientEvent('QBCore:Notify', src, 'Congratulations on your purchase!', 'success')
        TriggerClientEvent('qb-jobvehicleshop:client:buyShowroomVehiclepersonal', src, vehicle, plate)
        pData.Functions.RemoveMoney('bank', vehiclePrice, 'vehicle-bought-in-showroom')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
    end
end)


RegisterNetEvent('qb-jobvehicleshop:server:deliverVehicle', function(vehicle)
    local src = source
    local vehicle = vehicle.buyVehicle
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local cash = pData.PlayerData.money['cash']
    local bank = pData.PlayerData.money['bank']
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]['price']
    local plate = GeneratePlate()

    if cash > vehiclePrice then
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, job, vehicle, hash, mods, plate, garage, fuel, jobstate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            pData.PlayerData.job.name,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            pData.PlayerData.job.name,
            100,
            1
        })
        TriggerClientEvent('QBCore:Notify', src, 'Your vehicle will be delivered to your job garage!', 'success')
        pData.Functions.RemoveMoney('cash', vehiclePrice, 'vehicle-bought-in-showroom')
    elseif bank > vehiclePrice then
        MySQL.Async.insert('INSERT INTO player_vehicles (license, citizenid, job, vehicle, hash, mods, plate, garage, fuel, jobstate) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            pData.PlayerData.license,
            cid,
            pData.PlayerData.job.name,
            vehicle,
            GetHashKey(vehicle),
            '{}',
            plate,
            pData.PlayerData.job.name,
            100,
            1
        })
        TriggerClientEvent('QBCore:Notify', src, 'Your vehicle will be delivered to your job garage!', 'success')
        pData.Functions.RemoveMoney('bank', vehiclePrice, 'vehicle-bought-in-showroom')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
    end
end)








-- Transfer vehicle to player in passenger seat
QBCore.Commands.Add('transferVehicle', 'Gift or sell your vehicle', {{ name = 'amount', help = 'Sell amount' }}, false, function(source, args)
    local src = source
    local ped = GetPlayerPed(src)
    local player = QBCore.Functions.GetPlayer(src)
    local citizenid = player.PlayerData.citizenid
    local sellAmount = tonumber(args[1])
    local vehicle = GetVehiclePedIsIn(ped, false)
    if vehicle == 0 then return TriggerClientEvent('QBCore:Notify', src, 'Must be in a vehicle', 'error') end
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local passenger = GetPedInVehicleSeat(vehicle, 0)
    local plate = GetVehicleNumberPlateText(vehicle)
    local isOwned = MySQL.Sync.fetchScalar('SELECT citizenid FROM player_vehicles WHERE plate = ?', {plate})
    if isOwned ~= citizenid then return TriggerClientEvent('QBCore:Notify', src, 'You dont own this vehicle', 'error') end
    if ped ~= driver then return TriggerClientEvent('QBCore:Notify', src, 'Must be driver', 'error') end
    if passenger == 0 then return TriggerClientEvent('QBCore:Notify', src, 'No passenger', 'error') end
    local targetid = NetworkGetEntityOwner(passenger)
    local target = QBCore.Functions.GetPlayer(targetid)
    if not target then return TriggerClientEvent('QBCore:Notify', src, 'Couldnt get passenger info', 'error') end
    if sellAmount then
        if target.Functions.GetMoney('cash') > sellAmount then
            local targetcid = target.PlayerData.citizenid
            MySQL.Async.execute('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {targetcid, plate})
            player.Functions.AddMoney('cash', sellAmount)
            TriggerClientEvent('QBCore:Notify', src, 'You sold your vehicle for $'..comma_value(sellAmount), 'success')
            target.Functions.RemoveMoney('cash', sellAmount)
            TriggerClientEvent('vehiclekeys:client:SetOwner', target.PlayerData.source, plate)
            TriggerClientEvent('QBCore:Notify', target.PlayerData.source, 'You bought a vehicle for $'..comma_value(sellAmount), 'success')
        else
            TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
        end
    else
        local targetcid = target.PlayerData.citizenid
        MySQL.Async.execute('UPDATE player_vehicles SET citizenid = ? WHERE plate = ?', {targetcid, plate})
        TriggerClientEvent('QBCore:Notify', src, 'You gifted your vehicle', 'success')
        TriggerClientEvent('vehiclekeys:client:SetOwner', target.PlayerData.source, plate)
        TriggerClientEvent('QBCore:Notify', target.PlayerData.source, 'You were gifted a vehicle', 'success')
    end
end, 'user')
