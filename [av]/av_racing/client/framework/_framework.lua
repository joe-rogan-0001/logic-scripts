QBCore, ESX = nil, nil

if Config.Framework == "QBCore" then
    QBCore = exports['lrp-core']:GetCoreObject()
end

if Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end