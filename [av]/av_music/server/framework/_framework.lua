if Config.Framework == "QBCore" then
    QBCore = exports['lrp-core']:GetCoreObject()
    QBCore.Functions.CreateUseableItem("cd", function(source, item)
        local metadata = exports['av_laptop']:getMetadata(item,item)
        TriggerClientEvent('av_laptop:play',source,metadata.url)
    end)
end

if Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
    ESX.RegisterUsableItem("cd", function(source,item,info)
        local metadata = exports['av_laptop']:getMetadata(item,info)
        TriggerClientEvent('av_laptop:play',source,metadata.url)
    end)
end

RegisterNetEvent("av_music:burnCD", function(data)
    local src = source
    local info = {}
    info.artist = data.artist
    info.song = data.title
    info.url = data.url
    info.description = "Artist: "..info.artist.. " Song: "..info.song
    exports['av_laptop']:addItem(src,"cd",tonumber(data.itemCount),info)
end)