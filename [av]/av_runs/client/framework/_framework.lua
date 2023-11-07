CreateThread(function()
    if Config.Framework == "QBCore" then
        QBCore = exports['lrp-core']:GetCoreObject()
    end
    if Config.Framework == "ESX" then
        ESX = exports['es_extended']:getSharedObject()
    end
    if Config.Inventory == "ox_inventory" then
        exports.ox_inventory:displayMetadata("strain", Lang['strain_metadata'])
    end
end)
