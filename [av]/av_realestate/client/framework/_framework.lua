if Config.Framework == "QBCore" then
    QBCore = exports['lrp-core']:GetCoreObject()
else
    ESX = exports['es_extended']:getSharedObject()
end