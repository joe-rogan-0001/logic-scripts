CreateThread(function()
    local boosting = GetResourceState("av_boosting")
    if Config.Framework == "QBCore" then
        QBCore = exports['lrp-core']:GetCoreObject()
        if boosting ~= "started" then
            QBCore.Functions.CreateUseableItem(Config.HackingDevice, function(source, item)
                TriggerClientEvent('av_boosting:trackerMinigame',source)
            end)
        end
    end

    if Config.Framework == "ESX" then
        ESX = exports['es_extended']:getSharedObject()
        if boosting ~= "started" then
            ESX.RegisterUsableItem(Config.HackingDevice, function(source, item)
                TriggerClientEvent('av_boosting:trackerMinigame',source)
            end)
        end
    end
end)