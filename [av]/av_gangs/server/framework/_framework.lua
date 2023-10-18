RegisterCommand(Config.RegisterGangCommand, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Config.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:register',src)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

RegisterCommand(Config.SetGangBossCommand, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Config.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:addBoss',src,gangs_names)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

RegisterCommand(Config.RemoveGangMember, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Config.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:removeMember',src,gangs_names)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

RegisterCommand(Config.DeleteGang, function(source, args)
    local src = source
    local permission = exports['av_laptop']:getPermission(src, Config.AdminLevel)
    if permission then
        TriggerClientEvent('av_gangs:deleteGang',src,gangs_names)
    else
        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['no_access'],"error")
    end
end)

CreateThread(function()
    if Config.Framework == "QBCore" then
        QBCore = exports['lrp-core']:GetCoreObject()
        QBCore.Functions.CreateUseableItem(Config.SprayItem, function(source, item)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,item)
            if metadata and metadata.expiration then
                if isExpired(tonumber(metadata.expiration)) then
                    TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['expired'],"error")
                    return
                end
                if metadata.gang and Config.Sprays[metadata.gang] then
                    if GetMembersCount(metadata.gang) >= Config.MinMembersForSpray then
                        TriggerClientEvent('av_gangs:sprayItem',src,metadata.gang)
                    else
                        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['not_enough_members'],"error")
                    end
                end
            else
                print('[ERROR] This item ('..Config.SprayItem..') was given by command, you need to buy it directly from the NPC')
            end
        end)
        QBCore.Functions.CreateUseableItem(Config.SprayRemover, function(source, item)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,item)
            if metadata.gang and Config.Sprays[metadata.gang] then
                TriggerClientEvent('av_gangs:removerItem',src,metadata.gang)
            end
        end)
    elseif Config.Framework == "ESX" then
        ESX = exports['es_extended']:getSharedObject()
        ESX.RegisterUsableItem(Config.SprayItem, function(source, item, info)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,info)
            if metadata and metadata.expiration then
                if isExpired(tonumber(metadata.expiration)) then
                    TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['expired'],"error")
                    return
                end
                if metadata and Config.Sprays[metadata.gang] then
                    if GetMembersCount(metadata.gang) >= Config.MinMembersForSpray then
                        TriggerClientEvent('av_gangs:sprayItem',src,metadata.gang)
                    else
                        TriggerClientEvent('av_laptop:notification',src,Lang['app_title'],Lang['not_enough_members'],"error")
                    end
                end
            else
                print('[ERROR] This item ('..Config.SprayItem..') was given by command, you need to buy it directly from the NPC')
            end
        end)
        ESX.RegisterUsableItem(Config.SprayRemover, function(source, item, info)
            local src = source
            local metadata = exports['av_laptop']:getMetadata(item,info)
            if metadata and Config.Sprays[metadata.gang] then
                TriggerClientEvent('av_gangs:removerItem',src,metadata.gang)
            end
        end)
    end
end)