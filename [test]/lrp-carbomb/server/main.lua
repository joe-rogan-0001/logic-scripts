local QBCore = exports['lrp-core']:GetCoreObject()


RegisterNetEvent('lrp-carbomb:server:ripbozo')
AddEventHandler('lrp-carbomb:server:ripbozo', function(veh, pos) 
    TriggerClientEvent("lrp-carbomb:client:ripbozo", -1, veh, pos)
end)
