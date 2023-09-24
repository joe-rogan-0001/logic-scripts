local QBCore = exports['lrp-core']:GetCoreObject()

-- CAR PAPERS
RegisterServerEvent('lrp-rentals:carrentalpapers')
AddEventHandler('lrp-rentals:carrentalpapers', function(plate, model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    --local cash = Player.PlayerData.money['cash']

      local info = {}
      info.citizenid = Player.PlayerData.citizenid
      info.firstname = Player.PlayerData.charinfo.firstname
      info.lastname = Player.PlayerData.charinfo.lastname
      info.plate = plate
      info.model = model
      TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["carrentalpapers"], 'add')
      Player.Functions.AddItem('carrentalpapers', 1, false, info)
      --Player.Functions.RemoveMoney('cash', money, "vehicle-rental")
end)

QBCore.Functions.CreateCallback('lrp-rentals:server:checkbal', function(source, cb, money)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money['cash']

    print(cash)
    print(money)

    if cash >= money then
        Player.Functions.RemoveMoney('cash', money, "vehicle-rental")
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('lrp-rentals:removecarpapers')
AddEventHandler('lrp-rentals:removecarpapers', function(plate, model, money)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["carrentalpapers"], 'remove')
    Player.Functions.RemoveItem('carrentalpapers', 1, false, info)
end)

-- BOAT PAPERS
RegisterServerEvent('lrp-rentals:boatrentalpapers')
AddEventHandler('lrp-rentals:boatrentalpapers', function(plate, model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    --local cash = Player.PlayerData.money['cash']

      local info = {}
      info.citizenid = Player.PlayerData.citizenid
      info.firstname = Player.PlayerData.charinfo.firstname
      info.lastname = Player.PlayerData.charinfo.lastname
      info.plate = plate
      info.model = model
      TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["boatrentalpapers"], 'add')
      Player.Functions.AddItem('boatrentalpapers', 1, false, info)
      --Player.Functions.RemoveMoney('cash', money, "vehicle-rental")
end)

RegisterServerEvent('lrp-rentals:removeboatpapers')
AddEventHandler('lrp-rentals:removeboatpapers', function(plate, model, money)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["boatrentalpapers"], 'remove')
    Player.Functions.RemoveItem('boatrentalpapers', 1, false, info)
end)
-- PLANE PAPERS
RegisterServerEvent('lrp-rentals:planerentalpapers')
AddEventHandler('lrp-rentals:planerentalpapers', function(plate, model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    --local cash = Player.PlayerData.money['cash']

      local info = {}
      info.citizenid = Player.PlayerData.citizenid
      info.firstname = Player.PlayerData.charinfo.firstname
      info.lastname = Player.PlayerData.charinfo.lastname
      info.plate = plate
      info.model = model
      TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["planerentalpapers"], 'add')
      Player.Functions.AddItem('planerentalpapers', 1, false, info)
      --Player.Functions.RemoveMoney('cash', money, "vehicle-rental")
end)

RegisterServerEvent('lrp-rentals:removeplanepapers')
AddEventHandler('lrp-rentals:removeplanepapers', function(plate, model, money)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["planerentalpapers"], 'remove')
    Player.Functions.RemoveItem('planerentalpapers', 1, false, info)
end)