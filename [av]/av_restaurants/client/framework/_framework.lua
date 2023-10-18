if Config.Framework == 'QBCore' then
    QBCore = exports['lrp-core']:GetCoreObject()
elseif Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
end

function EatDrink(type)
    if type == 'food' then
        if Config.Framework == 'QBCore' then
            TriggerServerEvent("consumables:server:addHunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.EatValue)
        elseif Config.Framework == 'ESX' then
            TriggerEvent('esx_status:add','hunger',Config.EatValue * 5000)
        end
    elseif type == 'drink' then
        if Config.Framework == 'QBCore' then
            TriggerServerEvent("consumables:server:addThirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.DrinkValue)
        elseif Config.Framework == 'ESX' then
            TriggerEvent('esx_status:add','thirst',Config.DrinkValue * 5000)
        end
    elseif type == 'joint' then
        if Config.Framework == 'QBCore' then
            TriggerServerEvent('hud:server:RelieveStress', Config.JointValue)
        elseif Config.Framework == 'ESX' then
        -- ESX Status doesn't have any stress event (?)
        end
    end
end

RegisterNetEvent('av_restaurant:notification')
AddEventHandler('av_restaurant:notification', function(msg)
    lib.notify({
        title = 'Restaurants',
        description = msg,
        type = 'inform'
    })
end)