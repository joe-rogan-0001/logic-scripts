local webhook = "https://discord.com/api/webhooks/1173694814068424744/IOAEBrXzlcfl4vqZcJSZZB7UL06VaEpSGWSNsBvPtNDtv6LjhnfExm9dcmydQ_AhAnGi"
CreateThread(function()
    if webhook == "YOUR_DISCORD_WEBHOOK_GOES_HERE" then
        print("Script can't work if you don't provide a valid webhook (server/framework/_framework.lua line 1)")
        return
    end
    if Config.Framework == "QBCore" then
        QBCore = exports['lrp-core']:GetCoreObject()
        for k, v in pairs(Config.Cameras) do
            QBCore.Functions.CreateUseableItem(v['itemName'], function(source, item)
                TriggerClientEvent('av_cameras:install',source,v,webhook)
            end)
        end
        QBCore.Functions.CreateUseableItem(Config.CameraJammerItem, function(source,item)
            TriggerClientEvent('av_cameras:useJammer',source)
        end)
    elseif Config.Framework == "ESX" then
        ESX = exports['es_extended']:getSharedObject()
        for k, v in pairs(Config.Cameras) do
            ESX.RegisterUsableItem(v['itemName'], function(source)
                TriggerClientEvent('av_cameras:install',source,v,webhook)
            end)
        end
        ESX.RegisterUsableItem(Config.CameraJammerItem, function(source)
            TriggerClientEvent('av_cameras:useJammer',source)
        end)
    end
end)

if Config.TestCommand then
    RegisterCommand(Config.TestCommand, function(source,_)
        local src = source
        if exports['av_laptop']:getPermission(src, Config.AdminLevel) then
            TriggerClientEvent('av_cameras:debug',src, webhook)
        else
            TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],'error')
        end
    end)
end