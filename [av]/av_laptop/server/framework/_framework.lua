if Config.Framework == 'QBCore' then
    QBCore = exports['lrp-core']:GetCoreObject()
    QBCore.Functions.CreateUseableItem(Config.LaptopItem, function(source, item)
        local src = source
        local identifier = getIdentifier(src)
        local metadata, slot = exports['av_laptop']:getMetadata(item,item)
        local isAdmin = getPermission(src, Config.AdminLevel)
        if Config.Debug then
            print("open laptop", json.encode(metadata))
        end
        if metadata and not metadata.serial then
            local info = {}
            info['serial'] = identifier
            if Config.Debug then
                print(metadata['durability'])
            end
            info['durability'] = metadata['durability'] or 100
            info['password'] = false
            info['wallpaper'] = Config.DefaultWallpaper
            if info['durability'] > 100 then
                if Config.Debug then
                    print("more than 100")
                end
                info['durability'] = 100
            end
            if Config.Debug then
                print(metadata['durability'])
            end
            removeItem(src, Config.LaptopItem, 1, slot)
            addItem(src, Config.LaptopItem, 1, info)
            setItemMetadata(src, Config.LaptopItem, slot, info)
            TriggerClientEvent("av_laptop:openUI", src, info, identifier, isAdmin, slot)
        else
            if metadata and metadata.durability then
                if Config.Debug then
                    print(metadata['durability'])
                end
                local res = math.random(1,3)
                local newDurability = (metadata.durability - res)
                if newDurability <= 0 then
                    newDurability = 0
                end
                if res == 1 and Config.UseBattery then
                    metadata.durability = newDurability
                    setItemMetadata(src, Config.LaptopItem, slot, metadata)
                end
            end
            TriggerClientEvent("av_laptop:openUI", src, metadata, identifier, isAdmin, slot)
        end
    end)
elseif Config.Framework == "ESX" then
    ESX = exports['es_extended']:getSharedObject()
    ESX.RegisterUsableItem(Config.LaptopItem, function(source,item,info)
        local src = source
        local identifier = getIdentifier(src)
        local metadata, slot = exports['av_laptop']:getMetadata(item,info)
        local isAdmin = getPermission(src, Config.AdminLevel)
        if metadata and not metadata.serial then
            local info = {}
            info['serial'] = identifier
            info['durability'] = metadata['durability'] or 100
            if info['durability'] > 100 then
                info['durability'] = 100
            end
            info['password'] = false
            info['wallpaper'] = Config.DefaultWallpaper
            removeItem(src, Config.LaptopItem, 1, slot)
            addItem(src, Config.LaptopItem, 1, info)
            setItemMetadata(src, Config.LaptopItem, slot, info)
            TriggerClientEvent("av_laptop:openUI", src, info, identifier, isAdmin, slot)
        else
            if metadata and metadata.durability then
                local res = math.random(1,3)
                local newDurability = (metadata.durability - res)
                if newDurability <= 0 then
                    newDurability = 0
                end
                if res == 1 and Config.UseBattery then
                    metadata.durability = newDurability
                    setItemMetadata(src, Config.LaptopItem, slot, metadata)
                end
            end
            TriggerClientEvent("av_laptop:openUI", src, metadata, identifier, isAdmin, slot)
        end
    end)
end

lib.callback.register('av_laptop:getItem', function(source,item, amount)
    local src = source
    local qty = 1
    if tonumber(amount) then
        qty = tonumber(amount)
    end
    if type(item) == "table" then
        local count = 0
        for k, v in pairs(item) do
            if hasItem(src,v,qty) then
                count = count + 1
            end
        end
        if count == #item then
            return true
        else
            return false
        end
    end
    return hasItem(src,item,qty)
end)

lib.callback.register('av_laptop:removeItem', function(source,item,amount)
    local src = source
    return removeItem(src,item,amount)
end)