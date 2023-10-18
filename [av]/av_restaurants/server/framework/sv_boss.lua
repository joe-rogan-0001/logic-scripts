if Config.Framework == 'QBCore' then
    QBCore = exports['lrp-core']:GetCoreObject()
end

lib.callback.register('av_restaurant:getBusiness', function(source, job)
    local money = 0
    local data = GetSociety(job)
    if data and data.money then
        money = data.money
    end
    return money
end)

RegisterServerEvent('av_restaurant:getItems')
AddEventHandler('av_restaurant:getItems', function(data)
    local src = source
    local job = GetJob(src)
    local type = data['type']
    local items = MySQL.query.await('SELECT * FROM av_items WHERE job = ? AND type = ?', {job,type})
    if type == "drink" then
        local items2 = MySQL.query.await('SELECT * FROM av_items WHERE job = ? AND type = ?', {job,"super-drinks"})
        if items2 and items2[1] then
            for k, v in pairs(items2) do
                items[#items+1] = v
            end
        end
    end
    TriggerClientEvent('av_restaurant:listItems',src,items,job)
end)

RegisterServerEvent('av_restaurant:deleteItem')
AddEventHandler('av_restaurant:deleteItem', function(name)
    local src = source
    if isBoss(src) then
        MySQL.query('DELETE FROM av_items WHERE name = ?', {name}, function(result)
            if result then
                TriggerClientEvent('av_laptop:notificationUI',src,Lang['item_deleted'],'success',Lang['app_title'])
            end
        end)
    end
end)

RegisterServerEvent('av_restaurant:bossWithdraw')
AddEventHandler('av_restaurant:bossWithdraw', function()
    local src = source
    if isBoss(src) then
        local job = GetJob(src)
        if job then
            if not society[job] then
                return 
            end
            local societyMoney = GetSociety(job)
            if societyMoney and tonumber(societyMoney['money']) > 0 then
                if Config.UsingRenewedBanking then
                    local current = exports['Renewed-Banking']:getAccountMoney(job)
                    exports['Renewed-Banking']:removeAccountMoney(job, current)
                else
                    MySQL.update.await('UPDATE av_society SET money = ? WHERE job = ?', {0, job})
                end
                AddMoney(src, "bank", tonumber(societyMoney['money']))
                TriggerClientEvent('av_laptop:notificationUI', src, Lang['boss_withdrawn']..tonumber(societyMoney['money']), 'success')
                SaveResourceFile(GetCurrentResourceName(), "society.json", json.encode(society), -1)
            end
        end
    end
end)