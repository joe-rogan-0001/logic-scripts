if Config.Framework == 'QBCore' then
    QBCore = exports['lrp-core']:GetCoreObject()
elseif Config.Framework == 'ESX' then
    ESXItems = {}
end

lib.callback.register('av_restaurant:getItems', function(source, data)
    local job = GetJob(source)
    local items = MySQL.query.await('SELECT * FROM av_items WHERE job = ? AND type = ?', {job, data['type']})
    return items
end)

function addItem(src, item)
    if not isBoss(src) then return end
    local job = GetJob(src)
    local name = item['name']:gsub("[%c%p%s]", "")
    name = string.lower(name)
    local label = item['name']
    local type = item['type']
    local image = item['image']
    local description = item['description']
    local ingredients = item['ingredients']
    local matches = MySQL.query.await("SELECT name FROM av_items WHERE name = ?", {name})
    local weight = Config.ItemsWeight[type] or Config.DefaultItemWeight
    if not matches[1] and not VerifyItem(name) then
        MySQL.insert('INSERT INTO av_items (job, name, label, type, image, description, weight, ingredients) VALUES (:job, :name, :label, :type, :image, :description, :weight, :ingredients)', {
            job = job,
            name = name,
            label = label,
            type = type,
            image = image,
            description = description,
            weight = weight,
            ingredients = json.encode(ingredients),
        }, function(res)
            if res then
                if Config.Framework == 'QBCore' then
                    TriggerEvent('av_restaurant:QBItem',{name = name, label = label, weight = weight, image = image, description = description})
                    if Config.Framework == "ox_inventory" then
                        TriggerClientEvent('av_laptop:notificationUI',src,Lang['ESX_Restart'],"warning",Lang['app_title'])
                    else
                        TriggerClientEvent('av_laptop:notificationUI',src,Lang['item_added'],"success",Lang['app_title'])
                    end
                elseif Config.Framework == 'ESX' then
                    TriggerClientEvent('av_laptop:notificationUI',src,Lang['ESX_Restart'],"warning",Lang['app_title'])
                end
                TriggerEvent('inventory:refresh')
                RegisterItem(name,type)
            end
        end)
    else
        TriggerClientEvent('av_laptop:notificationUI',src,Lang['item_duplicated'],"error",Lang['app_title'])
    end
end

RegisterServerEvent('av_restaurant:craftEnd')
AddEventHandler('av_restaurant:craftEnd', function(job,item,type,ingredients,image,label)
    local src = source
    local job = GetJob(src)
    if item and job then
        if Config.UseIngredients and ingredients then
            local hasIngredients = 0
            local totalIngredients = #ingredients
            for k, v in pairs(ingredients) do
                if not hasItem(src,v) then
                    TriggerClientEvent('av_restaurant:notification',src,Lang['missing_ingredients'])
                    return
                end
                hasIngredients += 1
            end
            if hasIngredients >= totalIngredients then
                for k, v in pairs(ingredients) do
                    removeItem(src, v, 1)
                end
            end
        end
        if Config.Framework == 'ESX' then
            if ESXItems[item] then
                AddItem(src,item,1,type)
            else
                TriggerClientEvent('av_restaurant:notification',src,Lang['ESX_Restart'])
            end
        else
            AddItem(src,item,1,type)
        end
        addDish(job, item, image, label)
    end
end)