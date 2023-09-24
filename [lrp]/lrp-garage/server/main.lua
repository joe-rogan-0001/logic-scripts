local QBCore = exports['lrp-core']:GetCoreObject()
local OutsideVehicles = {}



AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    MySQL.Async.fetchAll('UPDATE player_vehicles SET jobstate = ? WHERE garage = ?',{1, "police", })
    MySQL.Async.fetchAll('UPDATE player_vehicles SET jobstate = ? WHERE garage = ?',{1, "ambulance", })
end)


-- Events

RegisterServerEvent('qb-garages:server:UpdateOutsideVehicles', function(Vehicles)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local CitizenId = Ply.PlayerData.citizenid
    OutsideVehicles[CitizenId] = Vehicles
end)

RegisterServerEvent('qb-garage:server:PayDepotPrice', function(vehicle, garage)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cashBalance = Player.PlayerData.money["cash"]
    local bankBalance = Player.PlayerData.money["bank"]
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {vehicle.plate}, function(result)
        if result[1] then
            if cashBalance >= result[1].depotprice then
                Player.Functions.RemoveMoney("cash", result[1].depotprice, "paid-depot")
                TriggerClientEvent("qb-garages:client:takeOutDepot", src, vehicle, garage)
            elseif bankBalance >= result[1].depotprice then
                Player.Functions.RemoveMoney("bank", result[1].depotprice, "paid-depot")
                TriggerClientEvent("qb-garages:client:takeOutDepot", src, vehicle, garage)
            else
                TriggerClientEvent('QBCore:Notify', src, 'Not enough money', 'error')
            end
        end
    end)
end)

RegisterNetEvent('qb-garage:server:changevehiclename')
AddEventHandler('qb-garage:server:changevehiclename', function(garagename, plate)
    MySQL.Async.fetchAll('UPDATE player_vehicles SET garagename = ? WHERE plate = ?',{garagename, plate})
end)



RegisterServerEvent('qb-garage:server:updateVehicleState', function(state, plate, garage)
    MySQL.Async.fetchAll('UPDATE player_vehicles SET state = ?, garage = ?, depotprice = ? WHERE plate = ?',{state, garage, 0, plate})
end)




RegisterServerEvent('qb-garage:server:updateVehicleJobState', function(state, plate, garage)
    MySQL.Async.fetchAll('UPDATE player_vehicles SET jobstate = ?, garage = ? WHERE plate = ?',{state, garage, plate})
end)

RegisterServerEvent('qb-garage:server:updateVehicleJobState2', function(state, plate)
    MySQL.Async.fetchAll('UPDATE player_vehicles SET jobstate = ? WHERE plate = ?',{state, plate})
end)



RegisterServerEvent('qb-garage:server:updateVehicleStatus', function(fuel, engine, body, plate, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    if engine > 1000 then
        engine = engine / 1000
    end

    if body > 1000 then
        body = body / 1000
    end

    MySQL.Async.fetchAll('UPDATE player_vehicles SET fuel = ?, engine = ?, body = ? WHERE plate = ? AND citizenid = ? AND garage = ?',{fuel, engine, body, plate, pData.PlayerData.citizenid, garage})
end)

-- Callbacks

QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleOwner", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local job = "none"

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ? AND job = ?',{plate, pData.PlayerData.citizenid, job}, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)

RegisterServerEvent('qb-garage:server:setjobstate', function(type, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    MySQL.Async.execute("UPDATE player_vehicles SET job = ? WHERE plate = ?", {type, plate})
end)


QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleOwnergang", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local gang = pData.PlayerData.gang.name


    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ?',{plate, pData.PlayerData.citizenid}, function(result)
        if result[1] then
            cb(true)
        else
            MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND garage = ?',{plate, gang}, function(result)
                if result[1] then
                    cb(true)
                else
                    cb(false)
                end
            end)
        end
    end)


end)


QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleOwner2", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local job = "personaljobveh"

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND citizenid = ? AND job = ?',{plate, pData.PlayerData.citizenid, job}, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleJob", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local job = pData.PlayerData.job.name

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND job = ?',{plate, job}, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)




QBCore.Functions.CreateCallback("qb-garage:server:GetOutsideVehicles", function(source, cb)
    local Ply = QBCore.Functions.GetPlayer(source)
    local CitizenId = Ply.PlayerData.citizenid
    if OutsideVehicles[CitizenId] and next(OutsideVehicles[CitizenId]) then
        cb(OutsideVehicles[CitizenId])
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback("qb-garage:server:GetUserVehicles", function(source, cb, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ? AND garage = ?', {pData.PlayerData.citizenid, garage}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-garage:server:GetUserVehicles2", function(source, cb, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local job = "personaljobveh"

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ? AND garage = ? AND job = ?', {pData.PlayerData.citizenid, garage, job}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-garage:server:GetjobVehicles", function(source, cb, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local job = pData.PlayerData.job.name

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE job = ? AND garage = ?', {job, garage}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)




 

QBCore.Functions.CreateCallback("qb-garage:server:GetGangVehicles", function(source, cb, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local gang = pData.PlayerData.gang.name

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE garage = ?', {gang}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)


QBCore.Functions.CreateCallback("qb-garage:server:GetVehicleProperties", function(source, cb, plate)
    local src = source
    local properties = {}
    local result = MySQL.Sync.fetchAll('SELECT mods FROM player_vehicles WHERE plate = ?', {plate})
    if result[1] then
        properties = json.decode(result[1].mods)
    end
    cb(properties)
end)

QBCore.Functions.CreateCallback("qb-garage:server:GetDepotVehicles", function(source, cb)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ? AND state = ?',{pData.PlayerData.citizenid, 0}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-garage:server:GetHouseVehicles", function(source, cb, house)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE garage = ?', {house}, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleHouseOwner", function(source, cb, plate, house)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ?', {plate}, function(result)
        if result[1] then
            local hasHouseKey = exports['qb-houses']:hasKey(result[1].license, result[1].citizenid, house)
            if hasHouseKey then
                cb(true)
            else
                cb(false)
            end
        else
            cb(false)
        end
    end)
end)

--Call from qb-phone
QBCore.Functions.CreateCallback('qb-garage:server:GetPlayerVehicles', function(source, cb)
    local Player = QBCore.Functions.GetPlayer(source)
    local Vehicles = {}

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE citizenid = ?', {Player.PlayerData.citizenid}, function(result)
        if result[1] then
            for k, v in pairs(result) do
                --local VehicleData = QBCore.Shared.Vehicles[v.vehicle]
    
                local VehicleGarage = 'None'
                if v.garage ~= nil then
                    if Garages[v.garage] ~= nil then
                        VehicleGarage = Garages[v.garage].label
                    else
                        VehicleGarage = 'Home'        -- HouseGarages[v.garage].label
                    end
                end

                if v.state == 0 then
                    v.state = 'Out'
                elseif v.state == 1 then
                    v.state = 'Garaged'
                elseif v.state == 2 then
                    v.state = 'Impounded'
                end
                
                --[[
                local fullname 
                if VehicleData["brand"] ~= nil then
                    fullname = VehicleData["brand"] .. " " .. VehicleData["name"]
                else
                    fullname = VehicleData["name"]
                end    

                ]]--

                Vehicles[#Vehicles+1] = {
                    model = v.vehicle,
                    plate = v.plate,
                    garage = VehicleGarage,
                    state = v.state,
                    fuel = v.fuel,
                    engine = v.engine,
                    body = v.body
                }
            end
            cb(Vehicles)
        else
            cb(nil)
        end
    end)
end)


QBCore.Functions.CreateCallback("qb-garage:server:checkVehicleState", function(source, cb, plate)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)

    MySQL.Async.fetchAll('SELECT * FROM player_vehicles WHERE plate = ? AND state = ?',{plate, "1"}, function(result)
        if result[1] then
            cb(true)
        else
            cb(false)
        end
    end)
end)
