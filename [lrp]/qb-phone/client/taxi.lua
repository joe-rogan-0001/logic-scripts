local QBCore = exports['lrp-core']:GetCoreObject()

RegisterNUICallback('GetAvailableTaxiDrivers', function(_, cb)
    QBCore.Functions.TriggerCallback('qb-phone:server:GetAvailableTaxiDrivers', function(drivers)
        cb(drivers)
    end)
end)