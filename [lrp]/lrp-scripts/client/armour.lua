local QBCore = exports['lrp-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('qb-setarmor:Server:GetPlayerarmor')
end)

RegisterNetEvent('qb-setarmor:client:setarmor', function(amount)
    SetPedArmour(PlayerPedId(), tonumber(amount))
    TriggerServerEvent('qb-armor:server:updateMetadata')
end)

RegisterNetEvent("lrp-armourupdate", function()
    --local armam = GetPedArmour(PlayerPedId())
    TriggerServerEvent('qb-armor:server:updateMetadata')
end)