QBCore = exports['lrp-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent("np-paintball:getArenaType")
AddEventHandler("np-paintball:getArenaType", function()
    TriggerClientEvent("np-paintball:changeArenaType", source, "wasteland")
end)

QBCore.Functions.CreateCallback("np-paintball:setArenaType", function(source, cb)
    local pSource = source
    TriggerClientEvent("np-paintball:changeArenaType", pSource, "wasteland")
end)
